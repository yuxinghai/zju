#!/usr/bin/bash
RAWDIR=/data3/zhoulab/yuxinghai/zjU/anno/ce11
DESDIR=/data3/zhoulab/yuxinghai/zjU/anno/ce11
gtf=${RAWDIR}/ce11_rRNA.gtf
fa=${RAWDIR}/ce11_rRNA.fa
STAR --runThreadN 10 --runMode genomeGenerate --genomeDir ${RAWDIR}/rRNA --genomeFastaFiles ${fa} --genomeSAindexNbases 6 --outFileNamePrefix ${DESDIR}/rRNA/ce11_rRNA
