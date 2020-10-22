#!/usr/bin/env python3

import sys

"""
This script splits a tped file into len(tped)/windowOffset files for LDMAP calculation.

It uses a sliding window approach, so the closer the windowOffset is, the greater the number of files that it produces
"""

tped_path = sys.argv[1]
windowSize = int(sys.argv[2])
windowOffset = int(sys.argv[3])

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
        fileName = "{0}_split_offset_{1}.tped".format("genotypes",offsetCounter)
        
        with open(fileName, 'w') as outFile:
            for item in tped:
                outFile.write("{}\n".format(item))
        
        tped = []

    tped.append( tped_list[snpNumber] )
    sizeCounter += 1
    snpNumber += 1

