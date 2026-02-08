#!/bin/bash

# Read JSON input
input=$(cat)

# Extract current directory from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Change to that directory
cd "$cwd" 2>/dev/null || true

# Get directory name (basename)
dir=$(basename "$cwd")

# Get git info if in a git repo
git_info=''
if git rev-parse --git-dir > /dev/null 2>&1; then
    # Get branch name or commit hash
    branch=$(git branch --show-current 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

    # Check if there are uncommitted changes (skip optional locks for performance)
    status=''
    if [ -n "$(git --no-optional-locks status --porcelain 2>/dev/null)" ]; then
        status='*'
    fi

    # Format git info in cyan
    git_info=" $(printf '\033[36m')${branch}${status}$(printf '\033[0m')"
fi

# Get model display name
model_name=$(echo "$input" | jq -r '.model.display_name // .model.id')

# Get context window usage
context_info=''
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
if [ -n "$remaining" ]; then
    # Convert to integer for cleaner display
    remaining_int=$(printf "%.0f" "$remaining")
    context_info=" $(printf '\033[33m')[${remaining_int}%%]$(printf '\033[0m')"
fi

# Get vim mode if present
vim_info=''
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')
if [ -n "$vim_mode" ]; then
    if [ "$vim_mode" = "INSERT" ]; then
        vim_info=" $(printf '\033[32m')[I]$(printf '\033[0m')"
    else
        vim_info=" $(printf '\033[35m')[N]$(printf '\033[0m')"
    fi
fi

# Print status line with all elements
# Format: directory (blue) | git branch/status (cyan) | model (dim) | context (yellow) | vim mode | prompt (green)
printf "$(printf '\033[34m')%s$(printf '\033[0m')%s $(printf '\033[2m')%s$(printf '\033[0m')%s%s $(printf '\033[32m')❯$(printf '\033[0m')" \
    "$dir" "$git_info" "$model_name" "$context_info" "$vim_info"
