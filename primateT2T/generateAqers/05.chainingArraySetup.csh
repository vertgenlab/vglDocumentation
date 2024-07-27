#!/bin/csh -ef

set tmp = /work/yl726/PrimateT2T_15way

set queries = (chimpT2Tpri bonoboT2Tpri gorillaT2Tpri orangutanT2Tpri borangutanT2Tpri gibbonT2Tpri chimpT2Talt bonoboT2Talt gorillaT2Talt orangutanT2Talt borangutanT2Talt gibbonT2Talt)
#set queries = (humanGapped chimpGapped bonoboGapped gorillaGapped orangutanGapped)
#set queries = ("HG002mat" "HG002pat" "YAOmat" "YAOpat" "Han1" "CN1mat" "CN1pat")
set target = "humanT2T"

set faFormat = ~/go/bin/faFormat

mkdir -p $tmp/Bed

# for target
$faFormat -noGapBed $tmp/Bed/$target.noGap.bed $tmp/$target.fa.gz /dev/null

# for queries
foreach q ($queries)
        $faFormat -noGapBed $tmp/Bed/$q.noGap.bed $tmp/$q.fa.gz /dev/null
        touch $tmp/$q.chaining_jobs.txt
        rm $tmp/$q.chaining_jobs.txt
        set noGap = $tmp/Bed/$q.noGap.bed
        foreach qLine (`cat $noGap | tr '\t' '.'`) #foreach ungapped region
                echo "./support.runAxtSwapAndSplit.csh $qLine $q" >> $tmp/$q.chaining_jobs.txt
        end
end

echo DONE
