#!/bin/bash

~/go/bin/sequelOverlap tsv2kbPromoterEnsembleGeneHg19.bed hg19HipsterReference.bed hipstrPromoterSequelOverlapOutput.bed

echo "Promoter STR count is:"
wc -l hipstrPromoterSequelOverlapOutput.bed
