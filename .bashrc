# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# --ignore-case or -i: Cause search in less to ignore case unless an uppercase letter is present in the search pattern.
# --status-column or -J: Display a status column on the left to indicate lines that match current search or indicate the first unread line after moving a full page.
# --LONG-PROMPT or -M: Prompt more verbosely.
# --RAW-CONTROL-CHARS or -R: Cause ANSI “color” escape sequences to be displayed in their raw form. This is for the color display explained later in the next section.
# --HILITE-UNREAD or -W: Highlight the first unread line after scrolling the screen for more than one lines.
# --tabs=2 or -x4: Display a tab as 2-character width
# --window=-4 or -z-4: Change the default scrolling size to 4 lines fewer than the current screen size, so always keep 4 lines overlapping with previous screen when scrolling with the space key.
export LESS='--ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=2 --window=-4'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

function git_branch()
{
  c_git_clean="\[\e[0;33m\]"
  c_git_dirty="\[\e[0;31m\]"
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi

  git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  if git diff --no-ext-diff --quiet 2>/dev/null; then
    git_color="$c_git_clean"
  else
    git_color="$c_git_dirty"
  fi
  if git status -s | grep '??' > /dev/null; then
    untracked="$c_git_dirty*"
  else
    untracked=''
  fi
  echo "$git_color$git_branch$untracked"
}

function bash_prompt()
{
  local tmp=''
  local trunc=''
  my_pwd=`echo ${PWD/#$HOME/\~} | rev`
  IFS='/'
  my_pwd=($my_pwd)
  unset IFS
  for (( i=0,cnt=${#my_pwd[@]}; i<cnt; i++ ))
  do
    if [ $i -gt 2 ]
    then
      trunc='..'
      break
    fi
    if [ "$tmp" == "" ]
    then
      tmp+=${my_pwd[$i]}
    else
      tmp+='/'${my_pwd[$i]}
    fi

  done
  tmp+=$trunc
  my_pwd=`echo $tmp | rev`
  COLOR_GREEN="\[\e[0;32m\]"
  COLOR_RED="\[\e[0;31m\]"
  COLOR_RESET="\[\e[m\]"
  if [ $(/usr/bin/id -u) -eq 0 ]; then
    LAST='#'
    USERCOLOR=$COLOR_RED
  else
    LAST='\$'
    USERCOLOR=$COLOR_GREEN
  fi
  gbranch=$(git_branch)
  if [ "$gbranch" != "" ]; then
    gbranch="[$gbranch$COLOR_GREEN]"
  fi

  export PS1="$COLOR_GREEN[$USERCOLOR\u$COLOR_GREEN@\h$COLOR_RESET${debian_chroot:+$debian_chroot}$COLOR_GREEN:$my_pwd]$gbranch$COLOR_RESET$LAST "
}
PROMPT_COMMAND=bash_prompt

# do not react to  ^S and ^Q
stty stop undef
stty start undef

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias grep='grep --color=auto'

# -a do not ignore entries starting with .
# -h print human readable sizes
# -F append indicator (one of */=>@|) to entries
# -f do not sort: needed for MacOS to sort case-insensitively, turns off -ls for GNU ls so use it only for BSD platform
# -l use a long listing format
ll_keys='lahF'
if strings `which ls` | grep -q 'GNU coreutils'; then
  alias ls='ls --color=auto'
else
  ll_keys+='f' 
  export CLICOLOR=1
fi
alias ll="ls -$ll_keys"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif which brew > /dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi
  fi
fi

# do not expand ~ on tab completions
_expand() { :; }
__expand_tilde_by_ref() { :; }

export LANG="en_US.UTF-8"
export EDITOR='vim'
