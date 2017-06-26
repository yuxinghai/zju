#!/usr/bin/bash
DESDIR=/data3/zhoulab/yuxinghai/zjU/file/02_mapping/sorted
NAMES=(2 5 6)
bed=/data3/zhoulab/yuxinghai/zjU/anno/ce11/ce11_ws245.bed
numSamples=${#NAMES[@]}
for (( i=0; i<${numSamples}; i++ )); do
    name=${NAMES[$i]}
    #bam file is sorted include multimapping reads
    f_bam=${DESDIR}/${name}.bam
    f_unique=${DESDIR}/${name}unique.bam
    f_unique_sort=${DESDIR}/${name}unique_Sort.bam
    f_output=${DESDIR}/${name}
    samtools view -@ 8 -h -bF 4 ${f_bam} > ${f_unique}
    samtools sort -@ 8 ${f_unique} -o ${f_unique_sort}
    samtools index ${f_unique_sort}
    geneBody_coverage.py -r ${bed}  -i ${f_unique_sort} -o ${f_output}

done

