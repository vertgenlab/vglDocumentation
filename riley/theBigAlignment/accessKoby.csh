#!/bin/csh -ef

sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR748084/SRR748084.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR748083/SRR748083.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR748082/SRR748082.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR748081/SRR748081.1"


echo DONE
