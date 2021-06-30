#!/usr/bin/env python3

import os
import sys
import argparse
from pathlib import Path
import pathlib
import subprocess

parser = argparse.ArgumentParser(description = "Split a single chromosome vcf file into populations.")
parser.add_argument("chr", type = str, help = "Select chromosome for splitting")
parser.add_argument("vcf", type = str, help = "Input vcf for splitting")
parser.add_argument("poplists_dir", type = str, help = "Directory containing files with population names which contain individuals belonging to population (one per line)")
# parse arguments
args = parser.parse_args()
chromosome = args.chr
# declare vcf and pop dir
full_vcf = Path( args.vcf )
population_lists_dir = Path( args.poplists_dir )
# declare pop lists
pop_lists = list( population_lists_dir.glob("*.tab") )

sys.stdout.write("############# SPLIT INTO POPULATIONS ##################\n")

# input vcf variable change 
chromosome_vcf = full_vcf 
# create chr directory
pathlib.Path(chromosome).mkdir(parents=True, exist_ok=True)
counter = 0
for i in pop_lists:
    counter +=1 
    pop_name = i.stem
    pop_file = i

    outfile = Path(chromosome) / Path( pop_name + ".vcf.gz" )

    command = [ "bcftools",
            "view", 
            "-S", 
            str(pop_file) ,
            "--force-samples",
            "-O",
            "z",
            "--threads", 
            "10",
            str(chromosome_vcf) ,
            "-o",
            str(outfile) ]
    
    message = "---> {0}/{1} populations parsed for chromosome {2}\n".format(counter,len(pop_lists), chromosome )
    sys.stdout.write("\r{0}".format( message ) )
    sys.stdout.flush()




    subprocess.run(command, capture_output = True )




sys.stdout.write("##############  DONE  ######################\n")
