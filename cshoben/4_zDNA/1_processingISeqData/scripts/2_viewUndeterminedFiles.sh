#!/bin/bash

#Saving this code. Originally ran from the terminal. Will need tweaked for use. 

zcat Undetermined_S0_L001_I2_001.fastq.gz | grep -v ‘+’ | grep -v ‘@’ | grep -v ‘E’ | head -n100000 | sort | uniq -c | sort -k1 -g
