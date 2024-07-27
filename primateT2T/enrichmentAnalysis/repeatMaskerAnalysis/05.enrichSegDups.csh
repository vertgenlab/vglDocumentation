#!/bin/csh -evf

set segDupDir = /hpc/group/vertgenlab/cl454/haqerT2T/segDups/downloadData

mkdir -p segDups
cat $segDupDir/bonobo.SDs.bed | cut -f1-3 | ~/go/bin/bedMerge stdin segDups/bonobo.segDup.bed
cat $segDupDir/chimp.SDs.bed | cut -f1-3 | ~/go/bin/bedMerge stdin segDups/chimpanzee.segDup.bed
cat $segDupDir/gorilla.SDs.bed | cut -f1-3 | ~/go/bin/bedMerge stdin segDups/gorilla.segDup.bed
cp /datacommons/vertgenlab/primateT2THAQER/internal/repeats/ByState/SegDups2024/segDups_2024.bed segDups/human.segDup.bed

mkdir -p segDupEnrichments

~/go/bin/overlapEnrichments -trimToRefGenome normalApproximate segDups/bonobo.segDup.bed aqer/bonobo.bed bonobo.noGap.bed segDupEnrichments/bonobo.SD.txt
~/go/bin/overlapEnrichments -trimToRefGenome normalApproximate segDups/chimpanzee.segDup.bed aqer/chimpanzee.bed chimpanzee.noGap.bed segDupEnrichments/chimpanzee.SD.txt
~/go/bin/overlapEnrichments -trimToRefGenome normalApproximate segDups/gorilla.segDup.bed aqer/gorilla.bed gorilla.noGap.bed segDupEnrichments/gorilla.SD.txt
~/go/bin/overlapEnrichments -trimToRefGenome normalApproximate segDups/human.segDup.bed aqer/human.bed human.noGap.bed segDupEnrichments/human.SD.txt

cat segDupEnrichments/*.txt | grep -v '#' > segDupEnrichment.Summary.txt

echo DONE
