# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Setup homebrew
if [ -d /opt/homebrew ] ; then # Apple Silicon
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Setup homebrew binaries
if [ -x "$(command -v brew)" ] ; then
    prefix=$(brew --prefix)

    if [ -d "$prefix/opt/coreutils/libexec" ] ; then
        export PATH="$prefix/opt/coreutils/libexec/gnubin:$PATH"
        export MANPATH="$prefix/opt/coreutils/libexec/gnuman:$MANPATH"
    fi

    if [ -d "$prefix/opt/grep/libexec/gnubin" ] ; then
        export PATH="$prefix/opt/grep/libexec/gnubin:$PATH"
        export MANPATH="$prefix/opt/grep/libexec/gnuman:$MANPATH"
    fi

    if [ -d "$prefix/opt/gnu-time/libexec/gnubin" ] ; then
        export PATH="$prefix/opt/gnu-time/libexec/gnubin:$PATH"
        export MANPATH="$prefix/opt/gnu-time/libexec/gnuman:$MANPATH"
    fi
fi
