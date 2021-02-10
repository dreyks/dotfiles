# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [[ -z $TMUX ]]; then
  if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
  fi

  # if [ -d "$HOME/.rvm/bin" ] ; then
  #   export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
  # fi

  if [ -d "/usr/local/opt/coreutils/libexec" ] ; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  fi

  if [ -d "/usr/local/opt/grep/libexec/gnubin" ] ; then
    export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/grep/libexec/gnuman:$MANPATH"
  fi
  
  if [ -d "/usr/local/opt/gnu-time/libexec/gnubin" ] ; then
    export PATH="/usr/local/opt/gnu-time/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/gnu-time/libexec/gnuman:$MANPATH"
  fi
fi

# RVM
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# NVM
# [ -s "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh"  # This loads nvm
# [ -s "$HOME/.nvm/bash_completion" ] && source "$HOME/.nvm/bash_completion"  # This loads nvm bash_completion

# AVN
# [[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    	. "$HOME/.bashrc"
    fi
fi

