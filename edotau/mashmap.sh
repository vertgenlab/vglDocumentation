#!/bin/sh
/data/lowelab/edotau/bin/github.com/mashmap-Linux64-v2.0/mashmap -r $1 -q $2 -f one-to-one -o $3 -t $SLURM_CPUS_ON_NODE
