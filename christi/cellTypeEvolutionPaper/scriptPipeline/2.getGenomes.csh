#!/bin/csh -evf

mkdir -p genomes

foreach name (`cat species.list`)

sbatch --mem=8GB --wrap="wget -nc -P /work/cf189/runPairwiseAlignments/genomes/$name/ https://hgdownload.soe.ucsc.edu/goldenPath/$name/bigZips/$name.fa.gz"
wget -nc -P /work/cf189/runPairwiseAlignments/genomes/$name/ https://hgdownload.soe.ucsc.edu/goldenPath/$name/bigZips/$name.chrom.sizes

echo $name

end

echo DONE 

