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
alias ll='ls -alFh'
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

# >>> 激活辅助函数脚本 必须放在conda初始化之前 <<<-----------------------------------
source /home/chiebotgpuhq/MyConfig/bashrc_func/ps1.sh
PS1="${debian_chroot:+($debian_chroot)}\[$COLOR_PINK\]\$(_fish_collapsed_pwd)"
PS1+="\[\$(git_color)\]"
PS1+=" \$(git_branch)"
PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "
export PS1

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/chiebotgpuhq/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/chiebotgpuhq/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/chiebotgpuhq/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/chiebotgpuhq/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> fzf 设置 <<< -----------------------------------------------------------------------------------------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# 这行配置开启 ag 查找隐藏文件 及忽略 .git 文件
#export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
# 用fd搜
#export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.sass-cache,node_modules,build} --type f"

#export FZF_DEFAULT_COMMAND="fd --color always"
export FZF_TMUX=1
export FZF_TMUX_OPTS='-p 80%'
export FZF_DEFAULT_COMMAND='rg --color always --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS=" --tiebreak=index --ansi --border --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

#export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
#--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'
#"

#export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#--color=dark
#--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
#--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
#'


eval "$(thefuck --alias)"
export EDITOR=/usr/bin/nvim

HISTTIMEFORMAT="%F %T "
export HISTTIMEFORMAT

# add navi
source "$(navi widget bash)"
export NAVI_PATH="/opt/navi/cheats:/home/chiebotgpuhq/MyConfig/navi_cheats"


# >>> My add bashrc <<<---------------------------------------------------------------------------------------------
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
export PATH=/usr/local/cuda/bin:$PATH 
export PATH=/usr/bin/ruby:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/cuda/lib64
# gcc  头文件搜索路径,建议自己项目在cmake中指明
export C_INCLUDE_PATH=$C_INCLUDE_PATH
# g++ 头文件搜索路径,建议自己项目在cmake中指明
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH
source ~/PATHFIX.sh


# 屏蔽ctrl+s的功能
stty -ixon

# >>> change rm <<<--------------------------------------------------------------------------------------------------
alias trm=trash
alias r=trash
alias rl='ls ~/.trash/'
alias ur=recoverfile

recoverfile()
{
    mv -i ~/.trash/$@ ./
}

trash()
{
    mv $@ ~/.t
}
# >>> 添加辅助脚本 <<< -------------------------------------------------------------------------------
# 自己加的一些辅助功能脚本
source /home/chiebotgpuhq/MyConfig/bashrc_func/utils.sh
# z是一个跳转工具
source /home/chiebotgpuhq/MyTools/z/z.sh 
# bashmakrs一个跳转工具
source /home/chiebotgpuhq/MyConfig/bashrc_func/bashmarks/bashmarks.sh
source "`ueberzug library`"
# 打开笔记
alias opennote='typora /home/chiebotgpuhq/Share/note/'
alias xmind='/home/chiebotgpuhq/MyConfig/XMind'
export PATH=/home/chiebotgpuhq/MyTools:$PATH
# >>> My own diy command <<<-------------------------------------------------------------------------------------
alias jupyter-notebook-xyy='jupyter notebook --config /home/chiebotgpuhq/.jupyter/user_xyy_config.py'
alias git-tree='git-foresta --all --style=10 | less -RSX'
alias picgo='/home/chiebotgpuhq/MyTools/PicGo-2.3.0-beta.3.AppImage'
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
#export PATH=$PATH

# >>> 末尾处理 <<<-----------------------------------------------------------------------------------
# 去除路径中的重复路径
export PATH=$( python -c "import os; path = os.environ['PATH'].split(':'); print(':'.join(sorted(set(path), key=path.index)))" )
export LD_LIBRARY_PATH=$( python -c "import os; path = os.environ['LD_LIBRARY_PATH'].split(':'); print(':'.join(sorted(set(path), key=path.index)))" )
export LIBRARY_PATH=$( python -c "import os; path = os.environ['LIBRARY_PATH'].split(':'); print(':'.join(sorted(set(path), key=path.index)))" )
export PKG_CONFIG_PATH=$( python -c "import os; path = os.environ['PKG_CONFIG_PATH'].split(':'); print(':'.join(sorted(set(path), key=path.index)))" )
