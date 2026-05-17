# Custom aliases

# General

# Prefer neovim
alias vim="nvim"
alias v="nvim"
# Open the current directory in Finder
alias of="open ."
# List all files in the current directory, one per line
alias lsao="ls -a1"
# List all user-defined aliases
alias aliases="grep '^alias' ~/.config/zsh/04-aliases.zsh"
# List all brews installed by the user
alias brew-leaves="brew leaves --installed-on-request"
# Set python3 as the default python
alias python=python3
alias gt="gittower ."
# Create a directory and change into it
mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

# Weird paths
alias icloud-drive="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias obsidian-vault="cd ~/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/Main"

# Chezmoi
alias cs="chezmoi status"
alias cm="chezmoi merge"
alias cadd="chezmoi add"
alias cdiff="chezmoi diff"
alias capp="chezmoi apply"
# Sync ~/.openclaw via the daily sync script
sync-openclaw() {
  "${HOME}/.local/bin/sync-openclaw-daily"
}

# Git

# Show git status in short format
alias gstt="git status -s"
# Add a file
alias ga="git add"
# Stage all files
alias gaa="git add ."
# Commit with a message
alias gcm="git commit -m"
# Unstage all files
alias grhead="git reset HEAD"
# Pull
alias gl="git pull"
# Push
alias gp="git push"
# Git log, one line per commit
alias glol="git log --oneline"
# Fetch remote branches and prune them
alias gfp="git fetch --prune"
# List remote branches
alias grr="git branch -r"
# Switch branches and pull from remote
gsw() { git switch "$@" && git pull; }
# Switch to main
alias gsm="git switch main && git pull"
# Create a branch and switch to it
alias gsc="git switch -c"
# Cherry pick
alias gcp="git cherry-pick"

# AI agents

# Run Claude Code in full automatic mode
alias claude-yolo="claude --dangerously-skip-permissions"
alias ccy="claude --dangerously-skip-permissions"
# Run Codex in full automatic mode
alias codex-yolo="codex --dangerously-bypass-approvals-and-sandbox"
alias cxy="codex --dangerously-bypass-approvals-and-sandbox"
# Attach or switch to the remote Codex tmux session, creating it if needed
rcx() {
  local session="remote-codex-7"

  if tmux has-session -t "$session" 2>/dev/null; then
    if [[ -n "${TMUX:-}" ]]; then
      tmux switch-client -t "$session"
    else
      tmux attach-session -t "$session"
    fi
  else
    if [[ -n "${TMUX:-}" ]]; then
      tmux new-session -d -s "$session"
      tmux switch-client -t "$session"
    else
      tmux new-session -s "$session"
    fi
  fi
}
# Run Gemini in full automatic mode
alias gemini-yolo="gemini --yolo"
# Run Qwen in full automatic mode
alias qwen-yolo="qwen --yolo"
# Run Mistral Vibe in full automatic mode
alias vibe-yolo="vibe --auto-approve"

# Xcode

# List available simulators
alias simulators="xcrun simctl list devices available"
# Clean derived data
alias cdd="rm -rf ~/Library/Developer/Xcode/DerivedData/"
