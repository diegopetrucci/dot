# Pyenv virtualenv configuration for zsh

# https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv
export PYENV_ROOT="$HOME/.pyenv"

if [[ -d $PYENV_ROOT/bin ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"

  # Lazy-load pyenv on first use to speed up shell startup.
  pyenv() {
    unset -f pyenv
    eval "$("$PYENV_ROOT/bin/pyenv" init -)"
    eval "$("$PYENV_ROOT/bin/pyenv" virtualenv-init -)"
    pyenv "$@"
  }
fi
