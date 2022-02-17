#!/bin/csh -ef
echo "started okay"
# query and target are referring to chromosomes that are aligning not the species
touch lastz_jobs.txt
rm lastz_jobs.txt
set outDir = hg38mm39Pairwise


set querydir=/gpfs/fs1/data/lowelab/RefGenomes/Cetaceans/balMus1/byChrom
set lastz=/data/lowelab/edotau/software/lastz-distrib-1.04.00/src/lastz
set matrix=/data/lowelab/RefGenomes/hg38/lastzFiles/human_chimp_v2.mat
set targetdir=/gpfs/fs1/data/lowelab/RefGenomes/Cetaceans/turTru1/byChrom
mkdir -p $outDir
echo "starting the loop"
foreach t (`ls -1 $targetdir`)
	echo $t
	set tNAME = $t:r
	mkdir -p $outDir/$tNAME
	foreach q (`ls -1 $querydir`)
		echo $q
		set qNAME = $q:r
		echo "$lastz $targetdir/$t $querydir/$q --output=$outDir/$tNAME/$qNAME.$tNAME.axt --scores=$matrix --format=axt O=600 E=150 T=2 M=254 K=4500 L=4500 Y=15000" >> lastz_jobs.txt
	end
end

echo DONE

