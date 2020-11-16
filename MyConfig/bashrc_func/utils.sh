#!/bin/bash

#临时自动切换cuda版本
function switchcuda_temp() {
	local new_cuda=`ls /usr/local/ |grep cuda-|fzf --height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'`
    local path_bak=$PATH
    local path_bakk=`echo $path_bak|sed "s/cuda[-0-9.]*/$new_cuda/g"`
    export PATH=$path_bakk
	
	local ld_library_path_bak=$LD_LIBRARY_PATH
	local ld_library_path_bakk=`echo $LD_LIBRARY_PATHBAK|sed "s/cuda[-0-9.]*/$NEWCUDA/g"`
    export LD_LIBRARY_PATH=$ld_library_path_bakk

	local library_path_bak=$LIBRARY_PATH
	local library_path_bakk=`echo $LIBRARY_PATHBAK|sed "s/cuda[-0-9.]*/$NEWCUDA/g"`
    export LIBRARY_PATH=$library_path_bakk
}

#交互式切换conda环境
function condaswitch() {
	source ~/anaconda3/etc/profile.d/conda.sh
	local condaenv_tmp=`conda info -e|awk '{if(NR>2)print $0}'|fzf --height 40% --layout=reverse|awk '{print $1}'`
	conda activate $condaenv_tmp
}

#切换conda下载源到清华源
function condachannel2qh() {
	source ~/anaconda3/etc/profile.d/conda.sh
	cp -f /home/chiebotgpuhq/MyConfig/bashrc_func/conda_source/condarc_qh ~/.condarc
	conda clean -i
}

#切换conda下载源到北外（推荐）
function condachannel2bw() {
	source ~/anaconda3/etc/profile.d/conda.sh
	cp -f /home/chiebotgpuhq/MyConfig/bashrc_func/conda_source/condarc_bw ~/.condarc
	conda clean -i
}

# 切换conda下载源到上交
function condachannel2sj() {
	source ~/anaconda3/etc/profile.d/conda.sh
	cp -f /home/chiebotgpuhq/MyConfig/bashrc_func/conda_source/condarc_sj ~/.condarc
	conda clean -i
}

#切换conda下载源到中科大
function condachannel2zkd() {
	source ~/anaconda3/etc/profile.d/conda.sh
	conda config --remove-key channels
    conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/main/
    conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
    conda config --add channels https://mirrors.ustc.edu.cn/anaconda/cloud/conda-forge/
    conda config --add channels https://mirrors.ustc.edu.cn/anaconda/cloud/msys2/
    conda config --add channels https://mirrors.ustc.edu.cn/anaconda/cloud/bioconda/
    conda config --add channels https://mirrors.ustc.edu.cn/anaconda/cloud/menpo/
    conda config --set show_channel_urls yes
	conda clean -i
}

#切换conda下载源到默认
function condachannel2default() {
	source ~/anaconda3/etc/profile.d/conda.sh
	cp -f /home/chiebotgpuhq/MyConfig/bashrc_func/conda_source/condarc_default ~/.condarc
	conda clean -i
}

# >>> PATH处理 <<< -------------------------------------------------
pathrm () {                                                                      
  local IFS=':'                                                                  
  local newpath                                                                  
  local dir                                                                      
  local pathvar=${2:-PATH}                                                       
  for dir in ${!pathvar} ; do                                                    
    if [ "$dir" != "$1" ] ; then                                                 
      newpath=${newpath:+$newpath:}$dir                                          
    fi                                                                           
  done                                                                           
  export $pathvar="$newpath"                                                        
}

pathprepend () {                                                                 
  pathrm $1 $2                                                                   
  local pathvar=${2:-PATH}                                                       
  export $pathvar="$1${!pathvar:+:${!pathvar}}"                                  
}

pathappend () {                                                                    
  pathrm $1 $2                                                                   
  local pathvar=${2:-PATH}                                                       
  export $pathvar="${!pathvar:+${!pathvar}:}$1"                                  
} 

#交互式进入当前目录下的第一层子目录
function cdd() {
	local dir_tmp=`ls -l|rg "^d"|awk '{print $NF}'|fzf --height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'`
	cd $dir_tmp
}

function _get_all_conda_env() {
	conda info -e|awk -F"[* ]" 'NR>2 {print $1}'
}
function _comp_conda_env() {
    source ~/anaconda3/etc/profile.d/conda.sh
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W '`_get_all_conda_env`' -- $curw))
    return 0
}

shopt -s progcomp
complete -F _comp_conda_env conda activate

