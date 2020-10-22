#!/usr/bin/env python3
import sys
import glob
"""
This script averages LDMAP results from a sliding window approach.
LDMAP values (LDUs) estimated from only one value are discarded and tagged as NAs.
"""

def ldmap_to_dict( input_file, dictionary ):
    """
    Read an ldmap file into a dictionary. 
    SNPid as key
    values is a list of LDU values that is updated as new files are read.
    """
    with open(input_file, 'r' ) as ldmap_file:

        for line in ldmap_file:
            if not line.startswith("#"):
                SNPid = line.split[0]
                kb_map = line.split[1]
                LDU = line.split[2].rstrip()
                try:
                    dictionary[key]
                except KeyError:
                    dictionary[key] = [LDU]
                else:
                    dictionary[key].append( LDU )
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
            handle.write( "{0} {1}\n".format(key, average_ldmap)



file_prefix = sys.argv[1] # File prefix of ldmap files
output_name = sys.argv[2] # Output file name

loci_dict = {} # dictionary for holding values

file_list = glob.glob( file_prefix + "*.ldmap" )

for ldmap_file in file_list:
    ldmap_to_dict(ldmap_file, loci_dict)



average_and_write( loci_dict, output_name )



