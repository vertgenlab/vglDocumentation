#!/bin/csh -ef

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -integralError 1e-5 -iterations 30000 -muZero 0.01 -sigmaZero 0.01 -sigmaStep 0.1 $v McmcTrace/$prefix.trace.Neutral.Uncorrected.txt"
end


echo DONE
