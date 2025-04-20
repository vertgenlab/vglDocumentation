#!/bin/csh -evf

# paths

# tools
set faFormat = ~/go/bin/faFormat

# parameters
set target = "gasAcu1"
set q = "rabsTHREEspine"

# make noGap.bed
$faFormat -noGapBed $target.noGap.bed $target.fa /dev/null
$faFormat -noGapBed $q.noGap.bed $q.fa /dev/null

# write chaining_jobs.txt
touch $target.$q.chaining_jobs.txt
rm $target.$q.chaining_jobs.txt
set noGap = $q.noGap.bed
foreach qLine (`cat $noGap | tr '\t' '.'`) #for each query ungapped region
    echo "./support.runAxtSwapAndSplit.csh $qLine $q $target" >> $target.$q.chaining_jobs.txt
end

echo DONE
