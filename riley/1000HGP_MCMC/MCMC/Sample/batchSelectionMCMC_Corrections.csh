#!/bin/csh -ef

sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -integralError 1e-5 -iterations 50000 -muZero 0.01 -sigmaZero 0.01 -ancestral HAQER.NonAscertainment.N1000.vcf McmcTrace/HAQER.NonAscertainment.Ancestral.N1000.trace.txt"
sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -integralError 1e-5 -iterations 50000 -muZero 0.01 -sigmaZero 0.01 -ancestral UCE.vcf McmcTrace/UCE.Ancestral.trace.txt"
sbatch --mem=32G --wrap="~/go/bin/selectionMCMC -integralError 1e-5 -iterations 50000 -muZero 0.01 -sigmaZero 0.01 -derived HAQER.N1000.vcf McmcTrace/HAQER.N1000.Derived.trace.txt "

echo DONE
