#!/bin/bash

cat tsvEnsemblMartGeneTssHg19.bed | awk '{print $1, $2-2000, $3+2000, $4}' | tr " " "\t" > tsv2kbPromoterEnsembleGeneHg19.bed
