#!/bin/csh -ef

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -integralError 1e-5 -iterations 30000 -muZero 0.01 -sigmaZero 1 $v McmcTrace/$prefix.trace.Neutral.txt"
	sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -integralError 1e-5 -iterations 30000 -muZero -4 -sigmaZero 1 $v McmcTrace/$prefix.trace.Minus4.txt"
	sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -integralError 1e-5 -iterations 30000 -muZero 4 -sigmaZero 1 $v McmcTrace/$prefix.trace.4.txt"
end


echo DONE
