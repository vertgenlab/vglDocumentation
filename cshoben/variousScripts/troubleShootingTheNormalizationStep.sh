#!/bin/bash
#SBATCH -J trobNromStep
#SBATCH -o normtroubleNorm%A.out
#SBATCH -e normTroubNorm%A.err


total=$(awk '{s+=$1}END{print s}' $1$2.wig)
echo "total wig hits is $total"
##awk -v total=$total '{print $1, $2, $3, $7/total}' $1$2BedMaxWig.bed > $1$2$4$5$6$7$8NormBedMaxWig.bed


##awk '{print $1, $2, $3}' $1$2BedMaxWig.bed > $1$2$4$5$6$7$8NormBedMaxWig.bed


##from the tested code normalBed
total=$(awk '{s+=$1}END{print s}' $1)
echo $total

awk -v total=$total '{print $1, $2, $3, $7/total}' $2 > norm$2

