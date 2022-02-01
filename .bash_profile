export BASH_SILENCE_DEPRECATION_WARNING=1 # MacOS bash -> zsh warning

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.bashrc"  ]] && source "$HOME/.bashrc" # load non-login shell config
