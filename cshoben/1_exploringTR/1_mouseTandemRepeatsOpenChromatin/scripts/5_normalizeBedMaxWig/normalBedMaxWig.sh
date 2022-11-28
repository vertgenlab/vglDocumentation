#!/bin/bash
#SBATCH -J normBedMaxWigData 
#SBATCH -o %AoutNormBMW%A_%a.out 
#SBATCH -e %AerrNormBMW%A_%a.err

## $1 will be the wig data, have in same location at this script
## $2 bedMaxWig name, have it be in same location at the script being ran. 
## note the header will be lost
## new file created with normalized values

total=$(awk '{s+=$1}END{print s}' $1)
echo $total

awk -v total=$total '{print $1, $2, $3, $7/total}' $2 > norm$2


 
