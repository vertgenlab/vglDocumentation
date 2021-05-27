#!/bin/csh -ef

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -ancestral -iterations 30000 -muZero 0.01 -sigmaZero 1 $v McmcTrace/$prefix.trace0.01.ancestral.txt"
	sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -ancestral -iterations 30000 -muZero -4 -sigmaZero 1 $v McmcTrace/$prefix.trace.minus4.ancestral.txt"
	sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -ancestral -iterations 30000 -muZero 4 -sigmaZero 1 $v McmcTrace/$prefix.trace.4.ancestral.txt"
end


echo DONE
