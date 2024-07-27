#!/bin/bash
#SBATCH -J


filename='gtexEstrTissues.txt'
echo Start
while read p; do
	cd /work/crs70/runningBedMinimumDistanceName
	awk 'BEGIN {FS="\t"} {OFS = "\t"} {if ($26 > 0.3) print $1, $3, $8, $2}' /hpc/group/vertgenlab/crs70/publicData/eSTRs/raw/master/"$p"_master.tab > "$p"TempTopCaviar.bed
	sed -i '1d' "$p"TempTopCaviar.bed

	~/go/bin/bedMinimumDistanceName /work/crs70/runningBedMinimumDistanceName/"$p"TempTopCaviar.bed /hpc/group/vertgenlab/crs70/publicData/eSTRs/12_runningBedMinimumDistanceName/ensemblHg19GeneStartsIrregChrRemSorted.bed /hpc/group/vertgenlab/crs70/publicData/eSTRs/12_runningBedMinimumDistanceName/"$p"RunningBedMinimumDistanceOutput.bed

done < "$filename"
echo loopDone
