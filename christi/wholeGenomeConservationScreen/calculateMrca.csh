#!/bin/csh -exf
set db = "galGal6"
set threshold = 0.33
mkdir -p coverageCalls
rm -rf coverageCalls
mkdir coverageCalls


 overlapSelect -mergeOutput /data/lowelab/christi/innCon/multipleAlignment/allSpecies.bed conservedElementsUniqueNames.bed stdout \
 | /data/lowelab/christi/innCon/multipleAlignment/punchHolesInBed.pl /dev/stdin coverageCalls/tmp.a.bed

 foreach x (`cat speciesNode.list`)

	set species = $x:r
        set node = $x:e
        echo $species $node

        overlapSelect -aggregate -overlapThreshold=$threshold /data/lowelab/christi/innCon/multipleAlignment/coverage/$species.bed coverageCalls/tmp.a.bed coverageCalls/tmp.out.bed

        cat coverageCalls/tmp.out.bed >> coverageCalls/node"$node".bed
        cat coverageCalls/tmp.out.bed | cut -f 4 | awk -v "NODE=$node" '{ print $1"\t"NODE }' >> coverageCalls/cneNode.tsv 

        overlapSelect -nonOverlapping coverageCalls/node"$node".bed coverageCalls/tmp.a.bed coverageCalls/tmp.b.bed

        mv coverageCalls/tmp.b.bed coverageCalls/tmp.a.bed

        rm coverageCalls/tmp.out.bed
end
  
mv coverageCalls/tmp.a.bed coverageCalls/refSpecific.bed
wc -l coverageCalls/refSpecific.bed

echo DONE
