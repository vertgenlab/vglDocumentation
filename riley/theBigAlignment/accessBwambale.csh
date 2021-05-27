#!/bin/csh -ef

sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR726359/SRR726359.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR726358/SRR726358.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR726357/SRR726357.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR726356/SRR726356.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR726355/SRR726355.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR726354/SRR726354.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR726353/SRR726353.1"
sbatch --wrap="wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/SRR726352/SRR726352.1"

echo DONE
