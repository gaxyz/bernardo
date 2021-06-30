#!/usr/bin/env python3

import glob
import argparse
import pandas as pd


parser = argparse.ArgumentParser(description='Read averaged LDMAP file together with tped for ordered output including position and chromosome.')
parser.add_argument("ldmap_file", type=str, help="average ldmap file")
parser.add_argument("tped", type=str, help="corresponding tped file")
parser.add_argument("outFile", type=str, help="Output file name")

args = parser.parse_args()
ldmap_file = args.ldmap_file
tped = args.tped
output_name = args.outFile

## Read average ldmap 
ldmap = pd.read_csv(ldmap_file, index_col=0, sep = " " )
## Read tped (only metadata columns)
colnames = ["chr","SNPid","cM","pos"]
tped = pd.read_csv(tped, names=colnames, sep=" ", usecols=[0,1,2,3], index_col=1)
## Join them
joined=tped.join(ldmap, on = "SNPid", how="right").sort_values(by="pos")
joined.to_csv(output_name, index_label = True, na_rep="NA" )








