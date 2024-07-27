#!/bin/bash
#SBATCH -J normalWigData 
#SBATCH -o %AoutNormalWig%A_%a.out 
#SBATCH -e %AerrNormalWig%A_%a.err

## $1 will be the wig name, have it be in same location at the script being ran. 

total=$(awk '{s+=$1}END{print s}' $1)
echo $total



 
