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
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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
  echo "$git_color$git_branch"
}

function bash_prompt()
{
  local tmp=''
  local trunc=''
  my_pwd=`echo ${PWD/#$HOME/\~} | rev`
  #my_pwd=$(rev_str `echo ${PWD/#$HOME/\~}`)
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
  #my_pwd=$(rev_str $tmp)
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
  #gbranch=''
  #gbranch="$(__git_ps1)"
  gbranch=$(git_branch)
  if [ "$gbranch" != "" ]; then
    #gbranch="${gbranch/ \(/\[}"
    #gbranch="${gbranch/\)/\]}"
    gbranch="[$gbranch$COLOR_GREEN]"
  fi


  export PS1="$COLOR_GREEN[$USERCOLOR\u$COLOR_GREEN@\h$COLOR_RESET${debian_chroot:+$debian_chroot}$COLOR_GREEN:$my_pwd]$gbranch$COLOR_RESET$LAST "

}
PROMPT_COMMAND=bash_prompt

stty stop undef
stty start undef


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lahF'
alias la='ls -A'
alias l='ls -CF'

# alias gs='git status -s'

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
  fi
fi

export LANG="en_US.UTF8"
export EDITOR='vim'
