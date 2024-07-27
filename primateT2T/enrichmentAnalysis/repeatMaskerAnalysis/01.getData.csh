#!/bin/csh -evf

set bigBedToBed = /hpc/group/vertgenlab/cl454/bin/x86_64/bigBedToBed 
set faSize = /hpc/group/vertgenlab/cl454/bin/x86_64/faSize

#download repeatmasker annotations
wget https://genomeark.s3.amazonaws.com/species/Gorilla_gorilla/mGorGor1/assembly_curated/repeats/mGorGor1_v2.0.RepeatMasker_v1.2.bb
wget https://genomeark.s3.amazonaws.com/species/Pan_paniscus/mPanPan1/assembly_curated/repeats/mPanPan1_v2.0.RepeatMasker_v1.2.bb
wget https://genomeark.s3.amazonaws.com/species/Pan_troglodytes/mPanTro3/assembly_curated/repeats/mPanTro3_v2.0.RepeatMasker_v1.2.bb
wget https://hgdownload.soe.ucsc.edu/hubs/GCA/009/914/755/GCA_009914755.4/bbi/GCA_009914755.4_T2T-CHM13v2.0.t2tRepeatMasker/chm13v2.0_rmsk.bb
mv mGorGor1_v2.0.RepeatMasker_v1.2.bb gorilla.RepeatMasker.bb
mv mPanPan1_v2.0.RepeatMasker_v1.2.bb bonobo.RepeatMasker.bb
mv mPanTro3_v2.0.RepeatMasker_v1.2.bb chimpanzee.RepeatMasker.bb
mv chm13v2.0_rmsk.bb human.RepeatMasker.bb

#download ref genomes
wget https://genomeark.s3.amazonaws.com/species/Pan_troglodytes/mPanTro3/assembly_curated/mPanTro3.pri.cur.20231122.fasta.gz
wget https://genomeark.s3.amazonaws.com/species/Pan_paniscus/mPanPan1/assembly_curated/mPanPan1.pri.cur.20231122.fasta.gz
wget https://genomeark.s3.amazonaws.com/species/Gorilla_gorilla/mGorGor1/assembly_curated/mGorGor1.pri.cur.20231122.fasta.gz
cp /hpc/group/vertgenlab/RefGenomes/chm13v2.0/chm13v2.0.fasta .
mv mPanTro3.pri.cur.20231122.fasta.gz chimpanzee.fa.gz
mv mPanPan1.pri.cur.20231122.fasta.gz bonobo.fa.gz
mv mGorGor1.pri.cur.20231122.fasta.gz gorilla.fa.gz
mv chm13v2.0.fasta human.raw.fa
~/go/bin/faFormat -trimName human.raw.fa human.fa.gz
rm human.raw.fa

#make noGap
foreach f (*.fa.gz)
	set fPrefix = $f:r:r
	~/go/bin/faFormat -noGapBed $fPrefix.noGap.bed $f /dev/null
	$faSize -detailed $f > $fPrefix.chrom.sizes
end

# process repeatMasker bigBeds
foreach bb (*.bb)
	set bbPrefix = $bb:r
	$bigBedToBed $bb $bbPrefix.bed
end

echo DONE
