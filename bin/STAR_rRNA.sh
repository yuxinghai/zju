#!/usr/bin/bash
RAWDIR=/data3/zhoulab/yuxinghai/zjU/data/zju/Cleandata
DESDIR=/data3/zhoulab/yuxinghai/zjU/file/02_mapping/rRNA
NAMES=(2 5 6)
star_index=/data3/zhoulab/yuxinghai/zjU/anno/ce11/rRNA
#chrom_size=/data/zhoulab/yuxinghai/ChenshiLab/hg38.chrom.sizes_chr
numSamples=${#NAMES[@]}
for (( i=0; i<${numSamples}; i++ )); do
    name=${NAMES[$i]}
    f_fastq1=${RAWDIR}/${name}/${name}_R1.fq.gz
    f_fastq2=${RAWDIR}/${name}/${name}_R2.fq.gz
    STAR --genomeDir ${star_index} --readFilesIn ${f_fastq1} ${f_fastq2} --readFilesCommand gunzip -c --runThreadN 20 --outFileNamePrefix ${DESDIR}/${name} --outReadsUnmapped Fastx --outFilterMatchNmin 40 --outFilterScoreMinOverLread 0 --outFilterMatchNminOverLread 0

done

:<<!
    f_sam=${name}_Aligned.out.sam
    f_unique_bam=${name}_unique.bam
    f_input_sort=${name}_unique_by_cord.bam
    samtools view -@ 8 -h -bF 4 ${f_sam} > ${f_unique_bam}
    samtools sort -@ 8 ${f_unique_bam} -o ${f_input_sort}
    samtools index ${f_input_sort}
    bam2wig.py -i ${f_input_sort} -o ${name} -t 1000000000 -s ${chrom_size} -u

done

!
