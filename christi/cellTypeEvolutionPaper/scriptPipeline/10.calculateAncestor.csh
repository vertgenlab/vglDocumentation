#!/bin/csh -exf
set db = "hg38"
#db is our reference
set allSpecies = /hpc/group/vertgenlab/christi/vertCons/60way/allSpeciesBeds/$db.allSpecies.bed
set dataFile=humanAtlas.4colUnique.bed
set speciesNodeFile=/hpc/group/vertgenlab/christi/vertCons/60way/speciesNodeFiles/$db.speciesNodes.list
set threshold = 0.33
mkdir -p coverageCalls.$db
rm -rf coverageCalls.$db
mkdir coverageCalls.$db

#you will need an installation of kentutils for this version, and instead of this first part where we give our absolute path to overlapSelect you will need to use yours, same with the rest of the paths to files. Keep the coverageCalls.hg38 directory creation above and its usage throughout. 

/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/overlapSelect -nonOverlapping $allSpecies $dataFile $db.specific.bed
 /hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/overlapSelect -mergeOutput $allSpecies $dataFile stdout \
| ./helper.punchHolesInBed.pl /dev/stdin coverageCalls.$db/tmp.a.bed

 foreach x (`cat $speciesNodeFile`)

	set species = $x:r
        set node = $x:e
        echo $species $node

        /hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/overlapSelect -aggregate -overlapThreshold=$threshold /work/cf189/runPairwiseAlignments/60way/$db.wholeGenomeAlignments/$db.$species.bed coverageCalls.$db/tmp.a.bed coverageCalls.$db/tmp.out.bed

        cat coverageCalls.$db/tmp.out.bed >> coverageCalls.$db/node"$node".bed
        cat coverageCalls.$db/tmp.out.bed | cut -f 4 | awk -v "NODE=$node" '{ print $1"\t"NODE }' >> coverageCalls.$db/cneNode.tsv 

        /hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/overlapSelect -nonOverlapping coverageCalls.$db/node"$node".bed coverageCalls.$db/tmp.a.bed coverageCalls.$db/tmp.b.bed

        mv coverageCalls.$db/tmp.b.bed coverageCalls.$db/tmp.a.bed

        rm coverageCalls.$db/tmp.out.bed
end
  
mv coverageCalls.$db/tmp.a.bed coverageCalls.$db/refSpecific.bed
wc -l coverageCalls.$db/refSpecific.bed

echo DONE

