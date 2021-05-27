#!/bin/csh -ef

sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR726412/SRR726412.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR726413/SRR726413.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR726415/SRR726415.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR726416/SRR726416.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR726411/SRR726411.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR726410/SRR726410.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR726409/SRR726409.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR726408/SRR726408.1"


echo DONE
