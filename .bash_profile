[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

. /usr/local/opt/asdf/asdf.sh

. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash
