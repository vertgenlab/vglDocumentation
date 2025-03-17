#!/bin/csh -e
set lastz=/hpc/group/vertgenlab/softwareShared/lastz-master/src/lastz
set m=true
set pairwise=/work/cf189/aligned
set speciesList=/work/cf189/runPairwiseAlignments/species.list
set refList=/work/cf189/ runPairwiseAlignments /ref.list
set allDists=/work/cf189/2 runPairwiseAlignments /60wayTree.dists.txt
set out=lastZJobs60.txt
set lastZWriter=$GOBIN/lastZWriter
$lastZWriter $lastz $pairwise $speciesList $refList $allDists $out

