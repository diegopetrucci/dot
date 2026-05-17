# Add Homebrew completions (must be before compinit)
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

# Add custom completions (must be before compinit)
fpath=(~/.zfunc $fpath)

# Enable case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
