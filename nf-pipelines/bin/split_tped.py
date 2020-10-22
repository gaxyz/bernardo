#!/usr/bin/env python3


import argparse


parser = argparse.ArgumentParser( description = 'This script splits a tped file into len(tped)/windowOffset files for LDMAP calculation. It uses a sliding window approach, so the closer the windowOffset is, the greater the number of files that it produces')
parser.add_argument("inputTPED", type = str, help = "Input tped file" )
parser.add_argument("outPrefix", type = str, help = "Output file prefix") 
parser.add_argument("windowSize", type = str, help = "Window size for output tped" )
parser.add_argument("windowOffset", type = str , help = "Window offset for output tped")

args = parser.parse_args()
tped_path = args.inputTPED
prefix = args.outPrefix
windowSize = int(args.windowSize)
windowOffset = int(args.windowOffset)

sizeCounter = 0
offsetCounter = 0


handle = open(tped_path, 'r' ) 
tped_list = handle.read().split('\n')
handle.close()

tped = []

snpNumber = 0
while snpNumber < len(tped_list):


    if sizeCounter == windowSize:
        sizeCounter = 0
        offsetCounter += 1
        newStart = snpNumber - windowOffset
        snpNumber = newStart
        fileName = "{0}_{1}.tped".format(prefix,offsetCounter)
        
        with open(fileName, 'w') as outFile:
            for item in tped:
                outFile.write("{}\n".format(item))
        
        tped = []

    tped.append( tped_list[snpNumber] )
    sizeCounter += 1
    snpNumber += 1

