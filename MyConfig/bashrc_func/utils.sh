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

#交互式进入当前目录下的第一层子目录
function cdd() {
	export DIR_TEMP=`ls -l|rg "^d"|awk '{print $NF}'|fzf`
	cd $DIR_TEMP
	unset DIR_TEMP
}
