#!/bin/csh -ef

sbatch --mem=64G --wrap="/home/rjm60/go/bin/sequelOverlap -nonOverlap All.Human.HCA.vcf all.HAQER.vcf HAQER.NonDivergent.vcf"

sbatch --mem=64G --wrap="/home/rjm60/go/bin/sequelOverlap All.Human.HCA.vcf all.HAQER.vcf HAQER.Divergent.vcf"

sbatch --mem=64G --wrap="/home/rjm60/go/bin/sequelOverlap All.Human.HCA.vcf all.HAR.vcf HAR.Divergent.vcf"

sbatch --mem=64G --wrap="/home/rjm60/go/bin/sequelOverlap -nonOverlap All.Human.HCA.vcf all.HAR.vcf HAR.NonDivergent.vcf"

sbatch --mem=64G --wrap="/home/rjm60/go/bin/sequelOverlap All.Human.HCA.vcf all.UCE.vcf UCE.Divergent.vcf"

sbatch --mem=64G --wrap="/home/rjm60/go/bin/sequelOverlap -nonOverlap All.Human.HCA.vcf all.UCE.vcf UCE.NonDivergent.vcf"

sbatch --mem=64G --wrap="/home/rjm60/go/bin/sequelOverlap All.Human.HCA.vcf all.Rand.vcf Rand.Divergent.vcf"

sbatch --mem=64G --wrap="/home/rjm60/go/bin/sequelOverlap -nonOverlap All.Human.HCA.vcf all.Rand.vcf Rand.NonDivergent.vcf"

echo DONE
