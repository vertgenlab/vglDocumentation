#!/bin/bash
#SBATCH -J takeAvgFirstRow

awk '{sum += $1; n++} END {print "Average: " sum/NR}' SRR8119850NoHeaders.wig
