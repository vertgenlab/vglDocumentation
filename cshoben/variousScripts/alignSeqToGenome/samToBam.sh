#!/bin/bash


module load samtools/1.10

samtools sort $1.sam | samtools view -b > $1.sorted.bam
