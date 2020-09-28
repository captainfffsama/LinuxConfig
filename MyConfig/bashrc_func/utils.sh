#!/bin/bash

#临时自动切换cuda版本
function switchcuda_temp() {
	NEWCUDA=`ls /usr/local/ |grep cuda-|fzf --height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'`
    PATHBAK=$PATH
    PATHBAKK=`echo $PATHBAK|sed "s/cuda[-0-9.]*/$NEWCUDA/g"`
    export PATH=$PATHBAKK
    LD_LIBRARY_PATHBAK=$LD_LIBRARY_PATH
    LD_LIBRARY_PATHBAKK=`echo $LD_LIBRARY_PATHBAK|sed "s/cuda[-0-9.]*/$NEWCUDA/g"`
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATHBAKK
    LIBRARY_PATHBAK=$LIBRARY_PATH
    LIBRARY_PATHBAKK=`echo $LIBRARY_PATHBAK|sed "s/cuda[-0-9.]*/$NEWCUDA/g"`
    export LIBRARY_PATH=$LIBRARY_PATHBAKK
    unset PATHBAK
    unset LD_LIBRARY_PATHBAK
    unset LIBRARY_PATHBAK
    unset NEWCUDA
}

#交互式切换conda环境
function condaswitch() {
	source ~/anaconda3/etc/profile.d/conda.sh
	export CONDAENV_TEMP=`conda info -e|awk '{if(NR>2)print $0}'|fzf --height 40% --layout=reverse|awk '{print $1}'`
	conda activate $CONDAENV_TEMP
	unset CONDAENV_TEMP
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



#交互式进入当前目录下的第一层子目录
function cdd() {
	export DIR_TEMP=`ls -l|rg "^d"|awk '{print $NF}'|fzf --height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'`
	cd $DIR_TEMP
	unset DIR_TEMP
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

