#!/usr/bin/env python3
"""
Sync dotfiles from private chezmoi repository to public dotfiles repository.

This script:
1. Gets all files managed by chezmoi
2. Filters out sensitive patterns
3. Renders chezmoi templates to get final content
4. Copies rendered files to the public repo
5. Leaves changes unstaged for manual review
"""

import argparse
import os
import subprocess
import sys
from pathlib import Path
from typing import List, Set

# Sensitive patterns to exclude from syncing
SENSITIVE_PATTERNS = {
    # SSH and GPG
    '.ssh/', '.gnupg/', '*.pem', '*.key', '*_rsa', '*_ed25519', '*.pub',
    # Credentials
    '*secret*', '*password*', '*token*', '*credential*', '*.env', '*api_key*',
    # Cloud providers
    '.aws/credentials', '.aws/config', '.azure/', '.gcloud/',
    # Other sensitive
    '.netrc', '.docker/config.json', '*_history', '.zsh_history', '.bash_history',
    # Git-specific
    '.git/', '.gitconfig.local',
}


def matches_pattern(file_path: str, patterns: Set[str]) -> bool:
    """Check if file path matches any sensitive pattern."""
    from fnmatch import fnmatch

    for pattern in patterns:
        # Check exact match or wildcard match
        if fnmatch(file_path, pattern) or fnmatch(file_path, f'*/{pattern}'):
            return True
        # Check if any part of the path matches
        if pattern.endswith('/') and pattern.rstrip('/') in file_path.split('/'):
            return True
    return False


def get_chezmoi_files(chezmoi_dir: Path) -> List[str]:
    """Get list of all files managed by chezmoi."""
    try:
        result = subprocess.run(
            ['chezmoi', 'managed'],
            capture_output=True,
            text=True,
            check=True
        )
        files = [line.strip() for line in result.stdout.strip().split('\n') if line.strip()]
        return files
    except subprocess.CalledProcessError as e:
        print(f"Error getting chezmoi files: {e}", file=sys.stderr)
        print(f"stderr: {e.stderr}", file=sys.stderr)
        sys.exit(1)
    except FileNotFoundError:
        print("Error: chezmoi command not found. Is chezmoi installed?", file=sys.stderr)
        sys.exit(1)


def filter_sensitive_files(files: List[str]) -> List[str]:
    """Filter out files matching sensitive patterns."""
    filtered = []
    excluded = []

    for file in files:
        if matches_pattern(file, SENSITIVE_PATTERNS):
            excluded.append(file)
        else:
            filtered.append(file)

    if excluded:
        print(f"\nExcluded {len(excluded)} sensitive files:")
        for file in excluded[:10]:  # Show first 10
            print(f"  - {file}")
        if len(excluded) > 10:
            print(f"  ... and {len(excluded) - 10} more")

    return filtered


def render_chezmoi_file(file_path: str) -> str:
    """Render a chezmoi file using 'chezmoi cat'."""
    try:
        # Convert to home-relative path if needed
        home = Path.home()
        if not file_path.startswith('~') and not file_path.startswith('/'):
            file_path = f"~/{file_path}"

        result = subprocess.run(
            ['chezmoi', 'cat', file_path],
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"Warning: Could not render {file_path}: {e}", file=sys.stderr)
        return None


def sync_file(file_path: str, public_repo: Path, dry_run: bool = False) -> bool:
    """Sync a single file from chezmoi to public repo."""
    # Render the file content
    content = render_chezmoi_file(file_path)
    if content is None:
        return False

    # Determine destination path
    # Remove leading ~ or / from file_path
    clean_path = file_path.lstrip('~').lstrip('/')
    dest_path = public_repo / clean_path

    if dry_run:
        print(f"Would sync: {file_path} -> {dest_path}")
        return True

    # Create parent directories
    dest_path.parent.mkdir(parents=True, exist_ok=True)

    # Write content to destination
    try:
        dest_path.write_text(content)
        print(f"Synced: {file_path}")
        return True
    except Exception as e:
        print(f"Error writing {dest_path}: {e}", file=sys.stderr)
        return False


def main():
    parser = argparse.ArgumentParser(
        description='Sync dotfiles from chezmoi to public dotfiles repository'
    )
    parser.add_argument(
        '--dry-run',
        action='store_true',
        help='Preview what would be synced without copying files'
    )
    parser.add_argument(
        '--chezmoi-dir',
        type=Path,
        default=Path.home() / '.local' / 'share' / 'chezmoi',
        help='Chezmoi source directory (default: ~/.local/share/chezmoi)'
    )
    parser.add_argument(
        '--public-repo',
        type=Path,
        default=Path.home() / 'Developer' / 'misc' / 'dot',
        help='Public dotfiles repository (default: ~/Developer/misc/dot)'
    )

    args = parser.parse_args()

    # Verify directories exist
    if not args.chezmoi_dir.exists():
        print(f"Error: Chezmoi directory not found: {args.chezmoi_dir}", file=sys.stderr)
        sys.exit(1)

    if not args.public_repo.exists():
        print(f"Error: Public repo directory not found: {args.public_repo}", file=sys.stderr)
        sys.exit(1)

    print(f"Syncing dotfiles from chezmoi to {args.public_repo}")
    if args.dry_run:
        print("DRY RUN MODE - no files will be copied\n")

    # Get all managed files
    print("Getting files from chezmoi...")
    all_files = get_chezmoi_files(args.chezmoi_dir)
    print(f"Found {len(all_files)} managed files")

    # Filter sensitive files
    safe_files = filter_sensitive_files(all_files)
    print(f"\n{len(safe_files)} files to sync")

    # Sync each file
    print("\nSyncing files...")
    success_count = 0
    for file in safe_files:
        if sync_file(file, args.public_repo, args.dry_run):
            success_count += 1

    print(f"\nCompleted: {success_count}/{len(safe_files)} files synced")

    if not args.dry_run:
        print("\nChanges left unstaged. Review with:")
        print(f"  cd {args.public_repo}")
        print("  git status")
        print("  git diff")


if __name__ == '__main__':
    main()
