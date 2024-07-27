#!/bin/bash

## Index bam files to view on UCSC
## Creates .bai files

module load samtools/1.10
samtools index $1
