#!/bin/csh -ef

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -derived -iterations 30000 -muZero 0.01 -sigmaZero 1 $v McmcTrace/$prefix.trace0.01.derived.txt"
	sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -derived -iterations 30000 -muZero -4 -sigmaZero 1 $v McmcTrace/$prefix.trace.minus4.derived.txt"
	sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -derived -iterations 30000 -muZero 4 -sigmaZero 1 $v McmcTrace/$prefix.trace.4.derived.txt"
end


echo DONE
