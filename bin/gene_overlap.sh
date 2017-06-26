#!/usr/bin/bash
raw_dir=/data3/zhoulab/yuxinghai/zjU/anno/ce11
dir=/data3/zhoulab/yuxinghai/zjU/anno/ce11/gene_overlap
script_dir=/data3/zhoulab/yuxinghai/zjU/script
#get coding gene bed
#awk '{if(!($2 == $7 && $3 == $8 || $7==$8)) print $0}' ${raw_dir}/ce11_ws245.bed> ${raw_dir}/ce11_ws245.coding.bed
sort -u ${raw_dir}/ce11_ws245.coding.bed|sort -k 1,1 -k 2,2 >${dir}/ce11_ws245.coding_Sort.bed
python  ${script_dir}/gene_overlap_estimate.py -r  ${dir}/ce11_ws245.coding_Sort.bed -o  ${dir}/coding_gene_overlap.bed
sort -u ${dir}/coding_gene_overlap.bed|sort -k 4,4 >${dir}/coding_gene_overlap_Sorted.bed
awk -v OFS="\t" '{print $1,$2,$3,$4,$5,$6}' ${dir}/coding_gene_overlap_Sorted.bed > ${dir}/0625ce11_ws245_coding.bed6
bedtools intersect -a  ${dir}/0625ce11_ws245_coding.bed6 -b  ${dir}/0625ce11_ws245_coding.bed6 -wo > ${dir}/0625ce11_ws245.gene_overlap.txt
awk '{if($4 != $10 && $6 != $12) print $0}'  ${dir}/0625ce11_ws245.gene_overlap.txt > ${dir}/0625ce11_ws245.gene_overlap.txt_1
:<<!
#merge transcipt to a gene,part2 needn't merge
sed -r 's/\.[0-9]+/&\t/'  ${dir}/ce11_ws245.coding.bed > ${dir}/test
awk -F"\t" '{if(NF==13) print $1,$2,$3,$4,$6,$7,$8,$9,$10,$11,$12,$13}'  ${dir}/test> ${dir}/part1
awk -F"\t" -v OFS="\t" '{if(NF==12) print $0}'  ${dir}/test> ${dir}/part2

sort -u -k4  ${dir}/part1> ${dir}/part1_1
python  ${script_dir}/gene_overlap_estimate.py -r  ${dir}/part1_1 -o  ${dir}/part1.output
cat  ${dir}/part1.output  ${dir}/part2> ${dir}/0722ce11_ws245.gene.bed6
sort -u -k4  ${dir}/0722ce11_ws245.gene.bed6> ${dir}/0722ce11_ws245.gene.bed6_1
awk -v OFS="\t" '{print $1,$2,$3,$4,$5,$6}'  ${dir}/0722ce11_ws245.gene.bed6_1> ${dir}/0722ce11_ws245.bed6
bedtools intersect -a  ${dir}/0722ce11_ws245.bed6 -b  ${dir}/0722ce11_ws245.bed6 -wo > ${dir}/0722ce11_ws245.gene_overlap.txt
awk '{if($4 != $10 && $6 != $12) print $0}'  ${dir}/0722ce11_ws245.gene_overlap.txt > ${dir}/0722ce11_ws245.gene_overlap.txt_1
!
