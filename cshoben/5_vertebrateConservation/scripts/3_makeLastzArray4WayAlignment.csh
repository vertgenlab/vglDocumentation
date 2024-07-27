#!/bin/csh -ef
echo "started okay"

#touch lastzJobs.txt
#rm lastzJobs.txt
#touch speciesNo$1.list
#rm speciesNo$1.list
# remove old files 

set targetDir=/hpc/group/vertgenlab/vertebrateConservation/pairwise/$1.byChrom
#set reference to first argument: $1

grep -v $1 /hpc/group/vertgenlab/RefGenomes/vertCons/4WaySpecies.list > 4WaySpeciesNo$1.list
#make a species.list file that doesn't have the reference so you don't end up aligning reference against itself

foreach line (`cat 4WaySpeciesNo"$1".list`)
		set queryDir=/hpc/group/vertgenlab/vertebrateConservation/pairwise/$line.byChrom
		set lastz=/hpc/group/vertgenlab/softwareShared/lastz-master/src/lastz
		set matrix=/data/lowelab/RefGenomes/hg38/lastzFiles/human_chimp_v2.mat
		
		set outDir=/hpc/group/vertgenlab/vertebrateConservation/pairwise/$1.$line
		mkdir -p $outDir
		echo "starting the loop"
		foreach t (`ls -1 $targetDir | grep 'chr*'`)
			echo $t
			set tNAME = $t:r
			mkdir -p $outDir/$tNAME
			foreach q (`ls -1 $queryDir`)
				echo $q
				set qNAME = $q:r
				echo "$lastz $targetDir/$t $queryDir/$q --output=$outDir/$tNAME/$qNAME.$tNAME.axt --scores=$matrix --format=axt O=600 E=150 T=2 M=254 K=4500 L=4500 Y=15000" >> 4WayLastzJobs.txt
			end
		end
end
echo DONE
