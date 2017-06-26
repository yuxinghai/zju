#!/usr/bin/bash
intergenic_region=/data3/zhoulab/yuxinghai/zjU/anno/ce11/cell_ws245.intergenic.bed
gene_region=/data3/zhoulab/yuxinghai/zjU/anno/ce11/ce11_ws245.bed3
raw_Dir=/data3/zhoulab/yuxinghai/zjU/file/02_mapping/sorted
NAMES=(2 5 6)
numSamples=${#NAMES[@]}
for (( i=0; i<${numSamples}; i++ )); do
    name=${NAMES[$i]}
    bam=${raw_Dir}/${name}_sort.bam
    bedtools intersect -a ${gene_region} -b ${bam} -wo -bed >${raw_Dir}/${name}gene_reads.bed
    bedtools intersect -a ${intergenic_region} -b ${bam} -wo -bed >${raw_Dir}/${name}intergenic_reads.bed
done
