#!/bin/csh -ef

# T2T non-hs1 Humans
# HG002
#sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/HG002/assemblies/hg002v1.0.1.fasta.gz"
# YAO
#sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://download.cncb.ac.cn/gwh/Animals/Homo_sapiens_v1.1_GWHDQZJ00000000/GWHDQZJ00000000.genome.fasta.gz"
#sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://download.cncb.ac.cn/gwh/Animals/Homo_sapiens_ChTY001.v1.1_pat_GWHDOOG00000000/GWHDOOG00000000.genome.fasta.gz"
# Han1
#sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://bit.ly/3JylfV3"
# CN1, go to https://genome.zju.edu.cn/Downloads/, download locally mat and pat, then upload

# T2T Alt nhp x 6 (from Genomeark)
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Pan_troglodytes/mPanTro3/assembly_curated/mPanTro3.alt.cur.20231122.fasta.gz"
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Pan_paniscus/mPanPan1/assembly_curated/mPanPan1.alt.cur.20231122.fasta.gz"
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Gorilla_gorilla/mGorGor1/assembly_curated/mGorGor1.alt.cur.20231122.fasta.gz"
# (2023 Thanksgiving orangutan in this line no longer exists, use 2023 December in below line) sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Pongo_abelii/mPonAbe1/assembly_curated/mPonAbe1.alt.cur.20231122.fasta.gz"
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Pongo_abelii/mPonAbe1/assembly_curated/mPonAbe1.alt.cur.20231205.fasta.gz"
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Pongo_pygmaeus/mPonPyg2/assembly_curated/mPonPyg2.alt.cur.20231122.fasta.gz"
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Symphalangus_syndactylus/mSymSyn1/assembly_curated/mSymSyn1.alt.cur.20231205.fasta.gz"

# T2T Primary x 7 (human is from UCSC fixed, nhp are from Genomeark updated)
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Pan_troglodytes/mPanTro3/assembly_curated/mPanTro3.pri.cur.20231122.fasta.gz"
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Pan_paniscus/mPanPan1/assembly_curated/mPanPan1.pri.cur.20231122.fasta.gz"
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Gorilla_gorilla/mGorGor1/assembly_curated/mGorGor1.pri.cur.20231122.fasta.gz"
# (2023 Thanksgiving orangutan in this line no longer exists, use 2023 December in below line) sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Pongo_abelii/mPonAbe1/assembly_curated/mPonAbe1.pri.cur.20231122.fasta.gz"
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Pongo_abelii/mPonAbe1/assembly_curated/mPonAbe1.pri.cur.20231205.fasta.gz"
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Pongo_pygmaeus/mPonPyg2/assembly_curated/mPonPyg2.pri.cur.20231122.fasta.gz"
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://genomeark.s3.amazonaws.com/species/Symphalangus_syndactylus/mSymSyn1/assembly_curated/mSymSyn1.pri.cur.20231205.fasta.gz"
sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://hgdownload.soe.ucsc.edu/goldenPath/hs1/bigZips/hs1.fa.gz"

# Gapped x 5 (from UCSC fixed)
#sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz"
#sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://hgdownload.soe.ucsc.edu/goldenPath/panTro6/bigZips/panTro6.fa.gz"
#sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://hgdownload.soe.ucsc.edu/goldenPath/gorGor5/bigZips/gorGor5.fa.gz"
#sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://hgdownload.soe.ucsc.edu/goldenPath/panPan2/bigZips/panPan2.fa.gz"
#sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="wget https://hgdownload.soe.ucsc.edu/goldenPath/ponAbe3/bigZips/ponAbe3.fa.gz"

echo DONE
