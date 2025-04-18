#!/bin/bash

# Author: Katharina J. hoff
# Contact: katharina.hoff@uni-greifswald.de
# Date: Jan 12th 2023

# Copy this script into the folder where you want to execute it, e.g.:
# singularity exec -B $PWD:$PWD braker3.sif cp /opt/BRAKER/example/singularity-tests/test3.sh .
# Then run "bash test3.sh".

# Check whether braker3.sif is available

if [[ -z "${BRAKER_SIF}" ]]; then
    echo ""
    echo "Variable BRAKER_SIF is undefined."
    echo "First, build the sif-file with \"singularity build braker3.sif docker://teambraker/braker3:latest\""
    echo ""
    echo "After building, export the BRAKER_SIF environment variable on the host as follows:"
    echo ""
    echo "export BRAKER_SIF=\$PWD/braker3.sif"
    echo ""
    echo "You will have to modify the export statement if braker3.sif does not reside in \$PWD."
    echo ""
    exit 1
fi

# Check whether singularity exists

if ! command -v singularity &> /dev/null
then
    echo "Singularity could not be found."
    echo "On some HPC systems you can load it with \"module load singularity\"."
    echo "If that fails, please install singularity."
    echo "Possibly you misunderstood how to run this script. Before running it, please copy it to the directory where you want to execute it by e.g.:"
    echo "singularity exec -B \$PWD:\$PWD braker3.sif cp /opt/BRAKER/example/singularity-tests/test3.sh ."
    echo "Then execute on the host with \"bash test3.sh\"".
    exit 1
fi

# remove output directory if it already exists

wd=runFull

if [ -d $wd ]; then
    rm -r $wd
fi

singularity exec -B ${PWD}:${PWD} ${BRAKER_SIF} braker.pl --genome=/hpc/group/vertgenlab/cl454/marineAssembly/braker/genomeSeq/rabsTHREEspine.fa --prot_seq=/hpc/group/vertgenlab/cl454/marineAssembly/braker/proteinSeq/sticklebackProteins.fa --bam=/hpc/group/vertgenlab/cl454/marineAssembly/braker/mappedRnaSeq/merged.sorted.bam --workingdir=${wd} --AUGUSTUS_CONFIG_PATH=/hpc/group/vertgenlab/cl454/marineAssembly/braker/configFull \
	    --threads 24 --busco_lineage eukaryota_odb10 &> runFull.log

	    # Important: the options --gm_max_intergenic 10000 --skipOptimize should never be applied to a real life run!!!                                   
        # They were only introduced to speed up the test. Please delete them from the script if you use it for real data analysis. 
