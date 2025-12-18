# Themes

ZSH_THEME="powerlevel10k/powerlevel10k"

P10K_THEME="$(brew --prefix powerlevel10k 2>/dev/null)/share/powerlevel10k/powerlevel10k.zsh-theme"
[[ -r "${P10K_THEME}" ]] && source "${P10K_THEME}"
unset P10K_THEME
