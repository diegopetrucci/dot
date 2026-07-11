# Silence direnv's load/unload messages so Powerlevel10k instant prompt
# doesn't warn about console output during shell initialization.
export DIRENV_LOG_FORMAT=''
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
