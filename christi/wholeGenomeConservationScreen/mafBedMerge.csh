#!/bin/csh -ex
#db = reference
 set db = "galGal6"

 set mafDir = /data/lowelab/christi/innCon/multipleAlignment/maf

 set tmpDir = /data/lowelab/christi/innCon/multipleAlignment/tmp
 mkdir $tmpDir
 
 set mafSpeciesSubset = /data/lowelab/cl454/bin/x86_64/mafSpeciesSubset
 set mafRanges = /data/lowelab/cl454/bin/x86_64/mafRanges

 foreach species (`cat species.list | grep -v $db`)
	echo $species

	echo "$db" > $tmpDir/$db.$species.species
	echo "$species" >> $tmpDir/$db.$species.species

	cat $mafDir/*.maf | grep -v -e '^i' -e '^e'\
	| $mafSpeciesSubset stdin $tmpDir/$db.$species.species stdout \
	| $mafRanges -otherDb=$species stdin $db stdout \
	> $tmpDir/output.bed 
	bedtools sort -chrThenSizeA -i $tmpDir/output.bed \
	> $tmpDir/output.sorted.bed
	bedMerge $tmpDir/output.sorted.bed $tmpDir/output.sortedMerged.bed
	mv $tmpDir/output.sortedMerged.bed $species.bed
	rm $tmpDir/$db.$species.species

end
