#!/bin/bash
#SBATCH -J normalWigData 
#SBATCH -o %AoutNormalWig%A_%a.out 
#SBATCH -e %AerrNormalWig%A_%a.err

## $1 will be the wig name, have it be in same location at the script being ran. 
## note the header will be lost
## new file created with normalized values

total=$(awk '{s+=$1}END{print s}' $1)
echo $total

awk 'NR>1 {print $1/$total}' $1 > normalized$1


 
