#!/bin/csh -efv

set faFilter = $GOBIN/faFilter
set faBin = $GOBIN/faBin
foreach line (`cat /work/cf189/runPairwiseAlignments/species.list | tail -22`)
set genome=/work/cf189/runPairwiseAlignments/genomes/$line/$line.fa

#set dir = /hpc/group/vertgenlab/vertebrateConservation/pairwise
set dir = /work/cf189/runPairwiseAlignments/pairwise
mkdir -p $dir/$line.byChrom

zcat $genome.gz | $faFilter -minSize=20000 stdin stdout | $faBin -minSize=100000000 -assembly=$line stdin $dir/$line.byChrom/
echo $genome
end
echo DONE

