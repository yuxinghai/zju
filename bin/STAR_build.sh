#!/usr/bin/bash
RAWDIR=/data3/zhoulab/yuxinghai/zjU/anno/ce11
DESDIR=/data3/zhoulab/yuxinghai/zjU/anno/ce11
gtf=${RAWDIR}/ce11_ws245.gtf
fa=${RAWDIR}/ce11.fa
STAR --runThreadN 10 --runMode genomeGenerate --genomeDir ${RAWDIR}/genome --genomeFastaFiles ${fa} --sjdbGTFfile ${gtf} --sjdbOverhang 149 --genomeSAindexNbases 12 --outFileNamePrefix ${DESDIR}/genome/ce11_ws245 
