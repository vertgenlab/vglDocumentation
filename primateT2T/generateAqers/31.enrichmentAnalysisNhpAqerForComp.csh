#!/bin/csh -ef

set tmp = /work/yl726/PrimateT2T_15way

# do this step outside, before running this script, because otherwise csh will say illegal variable name
#echo Method$'\t'State$'\t'Epigenome$'\t'Assemblies$'\t'LenElements1$'\t'LenElements2$'\t'OverlapCount$'\t'DebugCheck$'\t'ExpectedOverlap$'\t'Enrichment$'\t'EnrichPValue$'\t'DepletePValue > /work/yl726/PrimateT2T_15way/frozenNhpaqerChromhmmEnrichments/nhpAqerChromHmmForComp.txt

foreach file ($tmp/frozenNhpaqerChromhmmEnrichments/*.merged.txt)
        set filebase = `basename $file`
        set prefix = $filebase:r:r
        echo "Working on" $prefix
        cat $file | grep -v \#Method | sed 's/hg38.showHuman.bed/hg38.showHuman/g' | sed 's/hg38.showNhp.bed/hg38.showNhp/g' | sed 's/hs1Tohg38.browser.bed/hs1Tohg38.browser/g' | sed 's/\/hpc\/group\/vertgenlab\/publicDataSets\/RoadmapEpigenomics\/15stateChromHmm\/ByState\///g' | sed 's/_15_coreMarks_hg38lift_mnemonics.*.bed//g' | sed 's/\/work\/yl726\/PrimateT2T_15way\/nhp-aqerOverlapSets\///g' | sed 's/\//\t/g' >> /work/yl726/PrimateT2T_15way/frozenNhpaqerChromhmmEnrichments/nhpAqerChromHmmForComp.txt
end

echo DONE
