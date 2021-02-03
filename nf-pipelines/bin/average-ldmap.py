#!/usr/bin/env python3

import glob
import argparse



parser = argparse.ArgumentParser( description = 'Averages LDMAP results from a sliding window approach. LDMAP values (LDUs) estimated from only one value are discarded and tagged as NAs.')
parser.add_argument("filePrefix", type = str, help = "File prefix of LDMAP files" )
parser.add_argument("outFile", type = str, help = "Output file name" )

args = parser.parse_args()
file_prefix = args.filePrefix
output_name = args.outFile



def ldmap_to_dict( input_file, dictionary ):
    """
    Read an ldmap file into a dictionary. 
    SNPid as key
    values is a list of LDU values that is updated as new files are read.
    """
    with open(input_file, 'r' ) as ldmap_file:
        next(ldmap_file)
        for line in ldmap_file:
             
            a = line
            if not a.startswith("#"):
                SNPid = a.split()[1]
                #kb_map = a.split[1]
                try:
                    LDU = float(a.split()[3].rstrip())
                except IndexError:
                    pass
                else:

                    try:
                        dictionary[SNPid]
                    except KeyError:
                        dictionary[SNPid] = [LDU]
                    else:
                        dictionary[SNPid].append( LDU )
            else:
                pass


def average_and_write(dictionary, outfile):
    """
    Read final dictionary, compute LDMAP values averages, and write to output file.
    Output file is not position-sorted, as no position information is present.
    """
    with open(outfile, 'w') as handle:
        handle.write("SNPid average_LDU\n")
        for key in dictionary:

            ldmap_values = dictionary[key]
            if len(ldmap_values) > 1:
                average_ldmap = sum(ldmap_values)/len(ldmap_values)
            else:
                average_ldmap = "NA"
            handle.write( "{0} {1}\n".format(key, average_ldmap))








loci_dict = {} # dictionary for holding values
file_list = glob.glob( file_prefix + "*.map" )

for ldmap_file in file_list:
    ldmap_to_dict(ldmap_file, loci_dict)



average_and_write( loci_dict, output_name )



