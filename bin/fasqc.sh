#!/bin/bash
source "/data/zhoulab/yuxinghai/wangylab/soft/utilis.sh"
RAWDIR=/data3/zhoulab/yuxinghai/zjU/data/zju/Cleandata
DESDIR=/data3/zhoulab/yuxinghai/zjU/file/01_fastqc
LANES=(2 5 6)
numLanes=${#LANES[@]}


for (( i=0; i<${numLanes}; i++ )); do
    lane=${LANES[$i]}
    f_fq1=$RAWDIR/${lane}/${lane}_R1.fq.gz
    f_fq2=$RAWDIR/${lane}/${lane}_R2.fq.gz
    mkdir -p ${DESDIR}/${lane}
    exist_or_run "fastqc -f fastq -t 2 --noextract -o ${DESDIR}/${lane} ${f_fq1} ${f_fq2}"
done

RAWDIR=/data3/zhoulab/yuxinghai/zjU/data/zju/Rawdata
DESDIR=/data3/zhoulab/yuxinghai/zjU/file/01_fastqc
LANES=(2 5 6)
numLanes=${#LANES[@]}


for (( i=0; i<${numLanes}; i++ )); do
    lane=${LANES[$i]}
    f_fq1=$RAWDIR/${lane}/${lane}_R1.fq.gz
    f_fq2=$RAWDIR/${lane}/${lane}_R2.fq.gz
    mkdir -p ${DESDIR}/R_${lane}
    exist_or_run "fastqc -f fastq -t 2 --noextract -o ${DESDIR}/R_${lane} ${f_fq1} ${f_fq2}"
done

