import os,sys

def gene_parser(bed):
    '''Extract Intron regions from input bed file (must be 12-column).  output is 6-column Tab
    separated bed file, each row represents one intron'''

    ret_lst = []
    with open(bed,"r") as f:
        for line in f:

            try:
                if line.startswith('#'): continue
                if line.startswith('track'): continue
                if line.startswith('browser'): continue

                # Parse fields from gene tabls
                fields = line.split("\t")
                chrom = fields[0]
                tx_start = int(fields[1])
                tx_end = int(fields[2])
                geneName = fields[3]
                strand = fields[5]
                exon_num = int(fields[9])
                block_sizes = map(int, fields[10].rstrip(',\n').split(','))
                block_start = map(int, fields[11].rstrip(',\n').split(','))
                exon_starts = map((lambda x: x + tx_start), block_start)
                exon_ends = map((lambda x, y: x + y), exon_starts, block_sizes)
                exon_len=sum(block_sizes)
                # intron_start = exon_ends[:-1]
                # intron_end = exon_starts[1:]
                # intron_len = map((lambda x, y: x - y), intron_end, intron_start)
                # max_length = max(intron_len)

                # FO.write(chrom + "\t" + str(st) + "\t" + str(end) + "\t" + geneName + "_intron_" + str(intronNum) + "\t0\t" + strand + '\n')
                # intronNum -= 1
                #print(exon_starts[1],exon_ends[1])

                ret_lst.append([chrom, geneName, strand, exon_len, exon_starts,exon_ends,])

            except:
                print >> sys.stderr, "[NOTE:input bed must be 12-column] skipped this line: " + line,
                continue
    return(ret_lst)


def feature_filter(new):

    list1=[]
    for gene in new:
        #print(gene)
        #exit(0)
        featurezip=zip(gene[4], gene[5])
        for start, end in featurezip:
            list1.append([gene[0],start,end,gene[1],gene[3],gene[2]])
            # chrom,exon_Start,exon_end,genename,exon_num,strand
    return(list1)



def exon_overlap(featureA,featureB):

    with open(sys.argv[2],"w") as f:
        for A in featureA:
            for B in featureB:
                if (A[0] == B[0]) and (max(A[1], B[1]) < min(A[2], B[2])):
                    if (A[1]==B[1]) and (A[2]== B[2]):
                        len=A[2]-A[1]
                    else:
                        len = min(A[2], B[2]) - max(A[1], B[1])
                    new_A=map(str,A)
                    new_B = map(str, B)
                    output = "\t".join(new_A)+"\t"+"\t".join(new_B)+"\t" + str(len) + "\n"

                    f.write(output)





def main():
    gene_list=gene_parser(sys.argv[1])
    feature_list=feature_filter(gene_list)
    exon_overlap(feature_list,feature_list)


main()



















