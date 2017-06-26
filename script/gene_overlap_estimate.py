import os,sys
from optparse import OptionParser




__author__ = "Xinghai YU"
__copyright__ = "Copyright 2017, ZhouLab"
__credits__ = []
__license__ = "GPL"
__version__ = "1.0.0"



if sys.version_info[0] != 2 or sys.version_info[1] != 7:
        print >>sys.stderr, "\nYou are using python" + str(sys.version_info[0]) + '.' + str(sys.version_info[1]) + " RSeQC needs python2.7!\n"
        sys.exit()



def gene_parser(bed):
    '''Extract Intron regions from input bed file (must be 12-column).  output is 6-column Tab
    separated bed file, each row represents one intron'''

    ret_lst = []
    with open(bed) as f:
        for line in f:

            try:
                if line.startswith('#'): continue
                if line.startswith('track'): continue
                if line.startswith('browser'): continue

                # Parse fields from gene tabls
                fields = line.split()
                chrom = fields[0]
                tx_start = int(fields[1])
                tx_end = int(fields[2])
                geneName = fields[3]
                strand = fields[5].replace(" ", "_")
                #cds_start = int(fields[6])
                #cds_end = int(fields[7])
                #gene_len=tx_end-tx_start



                #print cds_end
                #exit(0)
                '''
                exon_starts = map(int, fields[11].rstrip(',\n').split(','))
                exon_starts = map((lambda x: x + tx_start), exon_starts)
                exon_ends = map(int, fields[10].rstrip(',\n').split(','))
                exon_ends = map((lambda x, y: x + y), exon_starts, exon_ends)
                intron_start = exon_ends[:-1]
                intron_end = exon_starts[1:]
                intron_len = map((lambda x, y: x - y), intron_end, intron_start)
                max_length = max(intron_len)
                '''
                # FO.write(chrom + "\t" + str(st) + "\t" + str(end) + "\t" + geneName + "_intron_" + str(intronNum) + "\t0\t" + strand + '\n')
                # intronNum -= 1
                ret_lst.append([chrom,tx_start,tx_end,geneName,strand])



            except:
                print >> sys.stderr, "[NOTE:input bed must be 12-column] skipped this line: " + line,
                continue
        f.seek(0)
    return ret_lst


def main():
    usage = "%prog [options]" + "\n"
    parser = OptionParser(usage, version="%prog " + __version__)

    parser.add_option("-r", "--refgene", action="store", type="string", dest="ref_gene_model",
                      help="Reference gene model in bed format.")

    parser.add_option("-o", "--output", action="store", type="string", dest="output_file",
                      help="output file")
    (options, args) = parser.parse_args()

    if not os.path.exists(options.ref_gene_model):
        print >> sys.stderr, '\n\n' + options.ref_gene_model + " does NOT exists" + '\n'
        # parser.print_help()
        sys.exit(0)
    genename_list=[]
    genename=""
    tx_end1=0
    tx_start1=9999999999999999999999999999

    with open(options.output_file,"w") as output:
        for gene in gene_parser(options.ref_gene_model):
            # chrom,tx_start,tx_end,geneName,strand


            if gene[3] not in genename_list:

                if tx_end1 !=0 and genename !="":
                    output.write("\t".join([chrom, str(tx_start1), str(tx_end1), genename, str(0),strand]) + "\n")

                genename_list.append(gene[3])
                genename = gene[3]
                tx_start = gene[1]
                tx_end = gene[2]
                chrom = gene[0]
                strand = gene[4]
                tx_start1=gene[1]
                tx_end1=gene[2]
            else:
                #
                tx_start1 = min(gene[1], tx_start)
                tx_end1 = max(gene[2], tx_end)


if __name__ == '__main__':
    main()

