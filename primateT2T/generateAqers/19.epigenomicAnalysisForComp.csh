#!/bin/csh -ef

set tmp = /work/yl726/PrimateT2T_15way

# do this step outside, before running this script, because otherwise csh will say illegal variable name
#echo Method$'\t'State$'\t'Epigenome$'\t'Assemblies$'\t'LenElements1$'\t'LenElements2$'\t'OverlapCount$'\t'DebugCheck$'\t'ExpectedOverlap$'\t'Enrichment$'\t'EnrichPValue$'\t'DepletePValue > /work/yl726/PrimateT2T_15way/frozenChromhmmEnrichments/chromHmmForComp.txt

foreach file ($tmp/frozenChromhmmEnrichments/*.merged.txt)
        set filebase = `basename $file`
        set prefix = $filebase:r:r
        echo "Working on" $prefix
        cat $file | grep -v \#Method | sed 's/shared.hg38.showT2T.bed/shared.hg38.showT2T/g' | sed 's/shared.hg38.showGapped.bed/shared.hg38.showGapped/g' | sed 's/haqer.hg38.bed/haqer.hg38/g' | sed 's/haqer.hs1Tohg38.browser.bed/haqer.hs1Tohg38.browser/g' | sed 's/\/hpc\/group\/vertgenlab\/publicDataSets\/RoadmapEpigenomics\/15stateChromHmm\/ByState\///g' | sed 's/_15_coreMarks_hg38lift_mnemonics.*.bed//g' | sed 's/\/hpc\/group\/vertgenlab\/publicDataSets\/PrimateT2T_15way\/setsToFreeze\/hg38\///g' | sed 's/\//\t/g' >> /work/yl726/PrimateT2T_15way/frozenChromhmmEnrichments/chromHmmForComp.txt
end

echo DONE
