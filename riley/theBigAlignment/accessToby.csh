#!/bin/csh -ef

sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR748162/SRR748162.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR748161/SRR748161.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR748164/SRR748164.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR748163/SRR748163.1"

echo DONE
