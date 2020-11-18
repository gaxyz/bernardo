#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Oct 22 12:19:20 2020

@author: gaston
"""
import multiprocessing
import subprocess
import argparse
import glob

parser = argparse.ArgumentParser( description = 'This script performs LDMAP computations in a parallel manner for a given set of tped files.')
parser.add_argument("LDMAP", type = str, help = "LDMAP binaries path" )
parser.add_argument("tpedPrefix", type = str, help = "TPED prefix for running LDMAP" )
parser.add_argument("ncpus", type = str, help = "Number of cpus to use")

args = parser.parse_args()
LDMAP = args.LDMAP
prefix = args.tpedPrefix
ncpus = int(args.ncpus)

# List tped files ----------
tpeds = glob.glob( prefix + "_*" + ".tped")


jobfile = "job.job"
# Write LDMAP config file ------
with open( jobfile , 'w') as job:    
    job.write( "PA(E=0.009424,M=0.5)\n" )
    job.write( "IT(E)\n" )
    job.write( "IT(E,M)\n" )                                                                         
    job.write( "IT(E,M)\n")
    job.write( "CC"  )
    

def run_ldmap(tped):
    
    index = tped.split("_")[-1].split(".")[0]
    
    command = [LDMAP,
               tped,
               "{0}_{1}_intermediate.tmp".format(prefix,index),
               "job.job",
               "{0}_{1}.map".format(prefix, index),
               "{0}_{1}.log".format(prefix, index),
               "0.05",
               "0.001"]
    
    subprocess.run(command)
    
    
        
    
pool = multiprocessing.Pool(ncpus)
r = pool.map_async( run_ldmap , tpeds )
r.wait()
    
    
    
    
