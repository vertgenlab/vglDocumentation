#!/bin/csh -ef

set out = hg38.Rand_1mb.bed

/home/rjm60/go/bin/simulateBed -L 1000 -N 1000 /data/lowelab/RefGenomes/hg38/Bed/hg38.nogap.bed $out

echo DONE

