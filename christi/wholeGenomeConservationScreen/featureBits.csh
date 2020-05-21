#!/bin/csh -ex


foreach b (*.bed)
	set prefix = $b:r
	sbatch --mem=100GB --wrap="featureBits -or galGal6 $b -bed=../allSpecies.bed"
	echo $prefix
end

echo Done
