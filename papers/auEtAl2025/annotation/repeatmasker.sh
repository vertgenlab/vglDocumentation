#!/bin/bash
#SBATCH -c 4
#SBATCH --mem=50G

/hpc/group/vertgenlab/seth/software/RepeatMasker/RepeatMasker -pa 4 -species Vertebrata -xsmall -dir . /datacommons/vertgenlab/rabsTHREEspine2/rabsTHREEspine.fa

echo DONE
