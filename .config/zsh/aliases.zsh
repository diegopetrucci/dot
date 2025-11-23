# Custom aliases

# General

# Prefer neovim
alias vim="nvim"
# Open the current directory in Finder
alias of="open ."
# List all files in the current directory, one per line
alias lsao="ls -a1"
# List all user-defined aliases
alias aliases="grep '^alias' ~/.config/zsh/aliases.zsh"
# List all brews installed by the user
alias brew-leaves="brew leaves --installed-on-request"
# Set python3 as the default python
alias python=python3
# Create a directory and change into it
mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

# Chezmoi
alias cs="chezmoi status"
alias cm="chezmoi merge"
alias ca="chezmoi apply"

# Git

# Show git status in short format
alias gstt="git status -s"
# Add a file
alias ga="git add"
# Stage all files
alias gaa="git add ."
# Commit with a message
alias gcm="git commit -m"
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

# AI agents

# Run Claude Code in full automatic mode
alias claude-yolo="claude --dangerously-skip-permissions"
# Run Codex in full automatic mode
alias codex-yolo="npm install -g @openai/codex@latest && codex --dangerously-bypass-approvals-and-sandbox"
# Run Gemini in full automatic mode
alias gemini-yolo="gemini --yolo"
