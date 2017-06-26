#!/usr/bin/bash
RAWDIR=/data3/zhoulab/yuxinghai/zjU/file/02_mapping/rRNA
DESDIR=/data3/zhoulab/yuxinghai/zjU/file/02_mapping/sorted
NAMES=(2 5 6)
anno_bed=/data3/zhoulab/yuxinghai/zjU/anno/ce11/ce11_ws245.bed
numSamples=${#NAMES[@]}

for (( i=0; i<${numSamples}; i++ )); do
    name=${NAMES[$i]}
    f_sam=${DESDIR}/${name}_SortAligned.out.sam
    f_bam=${DESDIR}/${name}.bam
    f_input_sort=${name}_sort.bam
    samtools view -@ 8 -h ${f_sam} > ${f_bam}
    samtools sort -@ 8 ${f_bam} -o ${f_input_sort}
    #samtools index ${f_input_sort}
    #bam2wig.py -i ${f_input_sort} -o ${name} -t 1000000000 -s ${chrom_size} -u
    #infer_experiment.py -s 200000 -r ${anno_bed} -i ${f_unique_bam}

done

