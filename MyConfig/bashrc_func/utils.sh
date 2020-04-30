#!/bin/bash

#临时自动切换cuda版本
function switchcuda_temp() {
    NEWCUDA=`ls /usr/local/ |grep cuda-|fzf`
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
	export CONDAENV_TEMP=`conda info -e|awk '{if(NR>2)print $0}'|fzf|awk '{print $1}'`
	conda activate $CONDAENV_TEMP
	unset CONDAENV_TEMP
}

#切换conda下载源到清华源
function condachannel2qh() {
	source ~/anaconda3/etc/profile.d/conda.sh
	conda config --remove-key channels
	conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
	conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r/
	conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/pro/
	conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2/
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ 
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/simpleitk/
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/menpo/
    conda config --set show_channel_urls yes
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
	conda config --remove-key channels
    conda config --set show_channel_urls yes
	conda clean -i
}



#交互式进入当前目录下的第一层子目录
function cdd() {
	export DIR_TEMP=`ls -l|rg "^d"|awk '{print $NF}'|fzf`
	cd $DIR_TEMP
	unset DIR_TEMP
}
