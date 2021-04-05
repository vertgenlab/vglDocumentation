#!/bin/csh -ef

set genome = balMus1.fa
set prefix = $genome:r

mkdir -p byChrom

faSize -detailed $genome > $prefix.chrom.sizes
faToTwoBit $genome $prefix.2bit
faSplit byname $genome byChrom/

echo DONE

