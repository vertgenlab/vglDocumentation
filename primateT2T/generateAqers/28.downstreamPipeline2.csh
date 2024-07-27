#!/bin/csh -evf

set lift = /hpc/group/vertgenlab/cl454/bin/x86_64/liftOver
set intervalOverlap = ~/go/bin/intervalOverlap
set bedMerge = ~/go/bin/bedMerge

#set tmp = /work/yl726/PrimateT2T_15way
set tmp = /datacommons/vertgenlab/raven/PrimateT2T_15way # temporarily use /datacommons folder as tmp
mkdir -p $tmp/nhp-aqer

set target = "humanT2T"
set queries = ("chimpT2Tpri" "gorillaT2Tpri" "bonoboT2Tpri" "chimpT2Talt" "gorillaT2Talt" "bonoboT2Talt")

set minMatch = 0.7

#set humanNoGap = $tmp/Bed/$target.noGap.bed

foreach q ($queries)
        set aqerRaw = $tmp/nhp-aqer/$q.aqer.raw.$target.bed
        set humanToNhpChain = $tmp/liftOver/$target.$q.splitChains.inNet.refilter.over.chain.gz
        #set nhpToHumanChain = $tmp/liftOver/$q.$target.over.chain.gz
        set nhpNoGap = $tmp/Bed/$q.noGap.bed
        #cat $aqerRaw | cut -f 1-5 | $lift -minMatch=$minMatch stdin $humanToNhpChain $tmp/nhp-aqer/$q.aqer.raw.$q.bed $tmp/nhp-aqer/$q.aqer.raw.$q.err
        #$intervalOverlap $nhpNoGap $tmp/nhp-aqer/$q.aqer.raw.$q.bed $tmp/nhp-aqer/$q.aqer.filtered.unmerged.$q.bed
        
        #sort -k 4,4 $aqerRaw > $tmp/nhp-aqer/$q.aqer.raw.sortedByName.bed
        #sort -k 4,4 $tmp/nhp-aqer/$q.aqer.filtered.unmerged.$q.bed > $tmp/nhp-aqer/$q.aqer.filtered.unmerged.$q.sortedByName.bed
        #join -1 4 -2 4 $tmp/nhp-aqer/$q.aqer.raw.sortedByName.bed $tmp/nhp-aqer/$q.aqer.filtered.unmerged.$q.sortedByName.bed > $tmp/nhp-aqer/$q.aqer.filteredByName.$target.txt
        #awk 'BEGIN {OFS="\t"} {print $2, $3, $4, $1}' $tmp/nhp-aqer/$q.aqer.filteredByName.$target.txt > $tmp/nhp-aqer/$q.aqer.filteredByName.$target.bed

        $bedMerge $tmp/nhp-aqer/$q.aqer.filtered.unmerged.$q.bed $tmp/nhp-aqer/$q.aqer.filtered.$q.bed

        #rm $tmp/nhp-aqer/$q.aqer.raw.$q.bed $tmp/nhp-aqer/$q.aqer.filtered.unmerged.$q.bed
        #$lift -minMatch=$minMatch $tmp/nhp-aqer/$q.aqer.filtered.$q.bed $nhpToHumanChain $tmp/nhp-aqer/$q.aqer.filtered.unmerged.$target.bed /dev/null
        #$bedMerge $tmp/nhp-aqer/$q.aqer.filtered.unmerged.$target.bed $tmp/nhp-aqer/$q.aqer.filtered.$target.bed
end

echo DONE
