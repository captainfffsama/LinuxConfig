#!/bin/bash

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function git_color() {
local git_status="$(git status 2> /dev/null)"
    if [[ ! $git_status =~ "干净的工作区" ]]; then
	    if [[ $git_status =~ "尚无提交" ]]; then
		echo -e $COLOR_YELLOW
	    else
                echo -e $COLOR_RED
	    fi
    elif [[ $git_status =~ "无文件要提交" ]]; then
        echo -e $COLOR_GREEN
    else
        echo -e $COLOR_OCHRE
    fi
}
# >>> 修改终端显示 <<<-----------------------------------------------------------------------------------------------
# 缩短路径显示 
function shortwd() {
    num_dirs=3
    pwd_symbol="..."
    newPWD="${PWD/#$HOME/~}"
    if [ $(echo -n $newPWD | awk -F '/' '{print NF}') -gt $num_dirs ]; then
        newPWD=$(echo -n $newPWD | awk -F '/' '{print $1 "/.../" $(NF-1) "/" $(NF)}')
    fi 
    echo -n $newPWD
}
# 添加git分支显示
function git_branch() {
    git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}

function _fish_collapsed_pwd() {
    local pwd="$1"
    local home="$HOME"
    local size=${#home}
    [[ $# == 0 ]] && pwd="$PWD"
    [[ -z "$pwd" ]] && return
    if [[ "$pwd" == "/" ]]; then
        echo "/"
        return
    elif [[ "$pwd" == "$home" ]]; then
        echo "~"
        return
    fi
    [[ "$pwd" == "$home/"* ]] && pwd="~${pwd:$size}"
    if [[ -n "$BASH_VERSION" ]]; then
        local IFS="/"
        local elements=($pwd)
        local length=${#elements[@]}
        for ((i=0;i<length-1;i++)); do
            local elem=${elements[$i]}
            if [[ ${#elem} -gt 1 ]]; then
                elements[$i]=${elem:0:1}
            fi
        done
    else
        local elements=("${(s:/:)pwd}")
        local length=${#elements}
        for i in {1..$((length-1))}; do
            local elem=${elements[$i]}
            if [[ ${#elem} > 1 ]]; then
                elements[$i]=${elem[1]}
            fi
        done
    fi
    local IFS="/"
    echo "${elements[*]}"
}

#export current_conda_env=$CONDA_PROMPT_MODIFIER
# >>> 修改终端显示 <<<-------------------------------------------------------------------------------------------------
function changeps(){
#    export PS1='\e[38;5;211m$(_fish_collapsed_pwd)\[\$(git_color)\]\e[38;5;48m [$(git_branch)]\e[0m$'
    PS1='\e[38;5;211m$(_fish_collapsed_pwd)'
    PS1+='$(git_color)'
    PS1+='[$(git_branch)]'
    PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "
    export PS1
    conda activate base
}

