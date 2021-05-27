#!/bin/csh -ef

sbatch --wrap=32G --wrap="~/go/bin/selectionMCMC -integralError 1e-5 -iterations 20000 -muZero 0.01 -sigmaZero 0.01 -muStep 0.2 -sigmaStep 0.01 -setSeed 10 all.HAR.vcf McmcTrace/HAR.trace.txt"
sbatch --wrap=32G --wrap="~/go/bin/selectionMCMC -integralError 1e-5 -iterations 20000 -muZero 0.01 -sigmaZero 0.01 -muStep 0.2 -sigmaStep 0.01 -setSeed 20 all.Rand.N1000.vcf McmcTrace/Rand.trace.txt"
sbatch --wrap=32G --wrap="~/go/bin/selectionMCMC -integralError 1e-5 -iterations 20000 -muZero 0.01 -sigmaZero 0.01 -muStep 0.2 -sigmaStep 0.01 -setSeed 30 -ancestral all.UCE.vcf McmcTrace/ancestral.UCE.trace.txt"
sbatch --wrap=32G --wrap="~/go/bin/selectionMCMC -integralError 1e-5 -iterations 20000 -muZero 0.01 -sigmaZero 0.01 -muStep 0.2 -sigmaStep 0.01 -setSeed 40 -derived all.HAQER.N1000.vcf McmcTrace/derived.HAQER.trace.txt"


echo DONE
