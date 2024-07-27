#!/bin/csh -ef

set faSplit = /hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/faSplit
set faFilter = $GOBIN/faFilter
foreach line (`cat /hpc/group/vertgenlab/RefGenomes/vertCons/species.list`)
set genome=/hpc/group/vertgenlab/RefGenomes/vertCons/$line/$line.fa

set dir = /hpc/group/vertgenlab/vertebrateConservation/pairwise
set mbDir = /work/cf189/pairwise/mbByChroms
set testDir = /work/cf189/pairwise/testingBins
mkdir -p $mbDir/$line.byChrom

#faSize -detailed $genome > $prefix.chrom.sizes
#faToTwoBit $genome $prefix.2bit
zcat $genome.gz | $faFilter -minSize=1000000 stdin stdout | $faSplit byname stdin $mbDir/$line.byChrom/
#zcat $genome.gz | $faSplit sequence stdin 10 $testDir/$line.10Bin/
echo $genome
end
echo DONE
#echo "inputs: " $prefix
