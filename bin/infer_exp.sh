#!/bin/bash
infer_experiment.py -s 2000000 -r /data/zhoulab/yuxinghai/annotiation/hg38_gencodev24_knowngene.bed -i TTseq_2_unique.bam
infer_experiment.py -s 200000 -r /data/zhoulab/yuxinghai/annotiation/hg38_gencodev24_knowngene.bed -i SRR5243202_unique.bam 
