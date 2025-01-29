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
    xterm-color|*-256color) color_prompt=yes;;
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

# Kubernetes config
alias k=kubectl
source <(kubectl completion bash)
source <(helm completion bash)
complete -F __start_kubectl k
# for f in ~/.kube/config_*
# do
#   export KUBECONFIG=$KUBECONFIG:$f
# done
# export PS1="\e[34m(`k config current-context`)$PS1"
#alias k-switch=". k-switch"


# Guido colored setup
NORMAL="\[\033[00m\]"
GREEN="\001\e[1;32m\002"
YELLOW="\001\e[1;33m\002"
RED="\001\e[1;31m\002"
BLUE="\001\e[1;34m\002"
MAGENTA="\001\e[1;35m\002"
LGREEN="\001\e[1;92m\002"
LRED="\001\e[1;91m\002"

formatGitBranch() 
{
        CURRENT_GIT_BRANCH=$(git branch --show-current 2>/dev/null )
        if [ $? -eq 0 ]; then
           if [[ $CURRENT_GIT_BRANCH == "master" ]]; then
                echo -e "${RED}[${CURRENT_GIT_BRANCH}]"
           elif [[ $CURRENT_GIT_BRANCH == *"release/"* ]]; then
               echo -e "${RED}[${CURRENT_GIT_BRANCH}]"
           else
                echo -e "${GREEN}[${CURRENT_GIT_BRANCH}]"
           fi
        fi

}

formatKubernetesContext()
{
        CONTEXT=$(kubectl config current-context)

        if [[ $CONTEXT == *"toni-dev"* ]]; then
            echo -e "${GREEN}[${CONTEXT}]"
        elif [[ $CONTEXT == *"toni-test"* ]]; then
            echo -e "${YELLOW}[${CONTEXT}]"
        elif [[ $CONTEXT == *"toni-prod"* ]]; then
            echo -e "${RED}[${CONTEXT}]"
        elif [[ $CONTEXT == *"toni-dsc"* ]]; then
            echo -e "${BLUE}[${CONTEXT}]"
       elif [[ $CONTEXT == *"toni-adm"* ]]; then
            echo -e "${LRED}[${CONTEXT}]"
        else
            echo -e "${MAGENTA}[${CONTEXT}]"
        fi
}

# show kubernetes and git branch
# export PS1="${GREEN}\u@\h \$(formatKubernetesContext)\$(formatGitBranch)${NORMAL} \w \$ "

# show kubernetes only
#formatKubernetesContext
export PS1="${GREEN}\u@\h${NORMAL}:${BLUE}\w \$(formatKubernetesContext) ${NORMAL}\$ "

# enable Fn key on Keychron
#echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode

# Enable krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Add Maven to PATH
export MAVEN_HOME=$HOME/maven/apache-maven-3.8.6
export PATH=$PATH:$MAVEN_HOME/bin

# Start ssh-agent and add keys
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
