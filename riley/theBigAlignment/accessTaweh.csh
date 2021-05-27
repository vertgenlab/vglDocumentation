#!/bin/csh -ef

sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-2/SRR748157/SRR748157.2"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-2/SRR748156/SRR748156.2"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-2/SRR748159/SRR748159.2"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-2/SRR748158/SRR748158.2"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR748160/SRR748160.1"

echo DONE
