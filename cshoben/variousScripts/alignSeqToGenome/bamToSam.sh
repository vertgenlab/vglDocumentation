#!/bin/bash

## $1 is the bam to be converted to a sam

samtools view -h -out out.sam $1
