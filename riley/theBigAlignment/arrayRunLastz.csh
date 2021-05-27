#!/bin/csh -e
touch lastz_jobs.txt
rm lastz_jobs.txt
set querydir=/gpfs/fs1/data/lowelab/RefGenomes/Great_Ape_Diversity/Toby_Ellioti/Toby_Ellioti_partition
set lastz=/data/lowelab/edotau/software/lastz-distrib-1.04.00/src/lastz
set refdir=/gpfs/fs1/data/lowelab/RefGenomes/hg38/hg38_chrom/
mkdir -p alignments
foreach t (`ls -1 /gpfs/fs1/data/lowelab/RefGenomes/hg38/hg38_chrom/*.fa | grep -v 'chrM' | grep -v 'chrUn' | grep -v 'alt' | grep -v 'random' `)
	set tNAME = $t:t:r
	set tPREFIX = $t:r
	mkdir -p alignments/$tNAME
	foreach q (`ls -1 Toby_Ellioti_partition/*.fa`)
		set qPREFIX = $q:r
		set qNAME = $q:t:r
		sbatch --mem=32G --wrap="$lastz $t $q --output=alignments/$tNAME/$qNAME.$tNAME.axt --scores=/gpfs/fs1/data/lowelab/RefGenomes/1000_Human_Genomes_Project/genomes/pairwise/human_chimp.v2.q --format=axt O=600 E=150 T=2 M=254 K=4500 L=4500 Y=15000"
	end
end

echo DONE

