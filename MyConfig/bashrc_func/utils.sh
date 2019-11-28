#!/bin/bash

#临时自动切换cuda版本
function switchcuda_temp() {
    NEWCUDA=`ls /usr/local/ |grep cuda-|fzf`
	PATHBAK=$PATH
	PATHBAKK=`echo $PATHBAK|sed "s/cuda/$NEWCUDA/g"`
	export PATH=$PATHBAKK
	LD_LIBRARY_PATHBAK=$LD_LIBRARY_PATH
	LD_LIBRARY_PATHBAKK=`echo $LD_LIBRARY_PATHBAK|sed "s/cuda/$NEWCUDA/g"`
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATHBAKK
	LIBRARY_PATHBAK=$LIBRARY_PATH
	LIBRARY_PATHBAKK=`echo $LIBRARY_PATHBAK|sed "s/cuda/$NEWCUDA/g"`
	export LIBRARY_PATH=$LIBRARY_PATHBAKK
}
