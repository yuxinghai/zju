#!/usr/bin/bash
dir=/data3/zhoulab/yuxinghai/zjU/anno/ce11/exon_overlap
python ../script/exon_overlap_get.py ../anno/ce11/ce11_ws245.coding.bed ${dir}/0623ce11_ws245.coding.otput
awk -v OFS="\t" '{if(!($1==$7 && $2==$8 && $3==$9 && $4==$10 && $5==$11 && $6==$12)) print $0}' ${dir}/0623ce11_ws245.coding.otput > ${dir}/0623ce11_ws245.coding.otput_1
awk -v OFS="\t" '{if(!($4==$10)) print $0}' ${dir}/0623ce11_ws245.coding.otput_1 > ${dir}/0623ce11_ws245.coding.otput_2
awk '{if($6 != $12) print $0}' ${dir}/0623ce11_ws245.coding.otput_2 |sort -k 4,4 >${dir}/0623ce11_ws245.coding.otput_3

#previous bad script
#sed -r 's/\.[0-9]+/&\t/g' 0623ce11_ws245.coding.otput_2 >0623ce11_ws245.coding.otput_3

#awk -F"\t" '{print NF}' 0623ce11_ws245.coding.otput_3|sort -u

#15
#16
#17
#awk -F"\t" '{if(NF==17) print $0}' 0623ce11_ws245.coding.otput_3|head -n 10|cat -A
#awk -v OFS="\t" -F"\t" '{if(NF==15) print $1,$2,$3,$4,$6,$7,$8,$9,$10,$11,$13,$14,$15}' 0623ce11_ws245.coding.otput_3| sort -u -k 1,1 -k 2,2n -S 4G>0623ce11_ws245.coding.otput_4a

#awk -v OFS="\t" -F"\t" '{if(NF==16 && $6=="") print $1,$2,$3,$4,$7,$8,$9,$10,$11,$12,$14,$15,$16; if(NF==16 && $6!="") print $1,$2,$3,$4,$6,$7,$8,$9,$10,$11,$14,$15,$16;}' 0623ce11_ws245.coding.otput_3| sort -u -k 1,1 -k 2,2n -S 4G>0623ce11_ws245.coding.otput_4b

#awk -v OFS="\t" -F"\t" '{if(NF==17) print $1,$2,$3,$4,$7,$8,$9,$10,$11,$12,$15,$16,$17}' 0623ce11_ws245.coding.otput_3>0623ce11_ws245.coding.otput_4c

#cat 0623ce11_ws245.coding.otput_4a 0623ce11_ws245.coding.otput_4b 0623ce11_ws245.coding.otput_4c |sort -u -k 1,1 -k 2,2n -S 4G >0623ce11_ws245.coding.otput_4

#awk '{if($6 != $12) print $0}' 0623ce11_ws245.coding.otput_4 >0623ce11_ws245.coding.otput_5

