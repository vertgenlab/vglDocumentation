#!/bin/csh -evf

mkdir -p enrichmentResults
mkdir -p aqer

set aqerDir = /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/20240717_cl454/aqer/finalSets
~/go/bin/bedMerge $aqerDir/haqers.hs1.bed aqer/human.bed
~/go/bin/bedMerge $aqerDir/chimpAQERs.chimpT2Tpri.bed aqer/chimpanzee.bed
~/go/bin/bedMerge $aqerDir/bonoboAQERs.bonoboT2Tpri.bed aqer/bonobo.bed
~/go/bin/bedMerge $aqerDir/gorillaAQERs.gorillaT2Tpri.bed aqer/gorilla.bed

set species = ("human" "chimpanzee" "gorilla" "bonobo")
#set species = ("bonobo")

foreach s ($species)
	mkdir -p enrichmentResults/$s
	#foreach rep (bedSplit/$s.RepeatMaskerClass/*.bed)
	#	set repPrefix = $rep:t:r
	#	~/go/bin/overlapEnrichments -trimToRefGenome normalApproximate $rep aqer/$s.bed $s.noGap.bed enrichmentResults/$s/$repPrefix.enrichment.txt
	#end
	~/go/bin/overlapEnrichments -trimToRefGenome normalApproximate bedSplit/$s.RepeatMaskerFamily/SVA.bed aqer/$s.bed $s.noGap.bed enrichmentResults/$s/SVA.enrichment.txt
	#foreach rep (bedSplit/$s.RepeatMaskerFamily/*.bed)
	#	set repPrefix = $rep:t:r
	#	~/go/bin/overlapEnrichments -trimToRefGenome normalApproximate $rep aqer/$s.bed $s.noGap.bed enrichmentResults/$s/$repPrefix.enrichment.txt
	#end
	cat enrichmentResults/$s/*.txt > enrichmentResults/$s.merged.txt
end

cat enrichmentResults/*.merged.txt | grep -v '#' > merged.enrichmentResults.repeatMaskerAcrossPrimates.txt

echo DONE
