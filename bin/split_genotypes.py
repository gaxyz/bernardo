#!/usr/bin/env python3

import os
import sys
import argparse
from pathlib import Path
import pathlib
import subprocess

parser = argparse.ArgumentParser(description = "Split a vcf file into chromosomes and populations, in that order.")
parser.add_argument("vcf", type = str, help = "Input vcf for splitting")
parser.add_argument("poplists_dir", type = str, help = "Directory containing files with population names which contain individuals belonging to population (one per line)")

args = parser.parse_args()

full_vcf = Path( args.vcf )
population_lists_dir = Path( args.poplists_dir )


pop_lists = list( population_lists_dir.glob("*.tab") )



chromosomes = list(range(1,23))

for idx, item in enumerate(chromosomes): chromosomes[idx] = str(item) 

chromosomes.extend(["X","Y","MT"])
# First, split into chromosomes

sys.stdout.write("######### SPLIT INTO CHROMOSOMES ########\n")
i = 0
for chromosome in chromosomes:
    i += 1

    pathlib.Path(chromosome).mkdir(parents=True, exist_ok=True)
    chrompath = Path(chromosome)
    outfile = Path(chromosome) / Path( chromosome + ".vcf.gz" )
    command = ["bcftools",
            "view",
            "--regions",
            str(chromosome),
            "-O",
            "z",
            "--threads",
            "10", 
            str(full_vcf) , 
            "-o",
            str(outfile)
            ]
    
    message = "---> {0}/{1} chromosomes parsed".format(i,len(chromosomes))
    sys.stdout.write("\r{0}".format( message ) )
    sys.stdout.flush()

    subprocess.run(command, capture_output = True)
            
sys.stdout.write("#################  DONE  #####################\n")
# Now, split into populations


sys.stdout.write("############# SPLIT INTO POPULATIONS ##################\n")




for chromosome in chromosomes:
    counter=0
    chromosome_vcf = Path(chromosome) / Path( chromosome + ".vcf.gz" ) 

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
