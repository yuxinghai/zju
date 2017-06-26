#!/usr/bin/Rscript
library(Rsubread)
gtf<- '/data3/zhoulab/yuxinghai/zjU/anno/ce11/ce11_ws245.gtf'
name <-c("2","5","6")
DESdir <-'/data3/zhoulab/yuxinghai/zjU/file/03_featurecount'
for (i in name) {
  bsname <-paste(i,"unique_sorted2.bam",sep = "_")
  filename <-paste(DESdir,i,bsname,sep = "/")
  fc_SE <- featureCounts(filename,annot.ext=NEAT1,isGTFAnnotationFile=T,isPairedEnd=TRUE,strandSpecific
                         =2,nthreads=6)
  write.table(fc_SE$counts,paste(DESdir,paste(i,"featureCounts.txt",sep = "_"),sep = "/"),quote = F,col.names = F,sep = "\t")
  write.table(fc_SE$stat,paste(DESdir,paste(i,"featureStat.log",sep = "_"),sep = "/"),quote = F,col.names = F,sep = "\t")
  
}

