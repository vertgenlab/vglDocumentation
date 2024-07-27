#!/bin/bash



awk 'BEGIN{FS="\t"; OFS=FS} {print $1, $2, $3, $8, $8-$3}' /hpc/group/vertgenlab/crs70/projects/eSTRs/eSTRs/raw/master/Brain-Cerebellum_master.tab > lengthSTR-Brain-Cerebellum_master.tab


echo "Max length:"

MAX=$( \
	sort -k 5nr lengthSTR-Brain-Cerebellum_master.tab | \
	head -n1 | \
	awk '{print $5}' \
	)
echo $MAX

echo "Min length:"

MIN=$( \
        sort -k 5nr lengthSTR-Brain-Cerebellum_master.tab | \
        tail -n2 | \
	head -n1 | \
        awk '{print $5}' \
        )
echo $MIN
