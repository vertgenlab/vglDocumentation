#!/bin/csh -evf

mkdir -p /work/yl726/PrimateT2T_15way
set tmp = /work/yl726/PrimateT2T_15way

# for HG002, split into mat and pat
#set HG002Fa = hg002v1.0.1.fasta.gz
#set faFilter = ~/go/bin/faFilter
#$faFilter -nameContains="_MATERNAL" $HG002Fa HG002mat.fasta.gz
#$faFilter -nameContains="_PATERNAL" $HG002Fa HG002pat.fasta.gz
#rm $HG002Fa

# for YAO, rename fa names
#set YAOFaMat = GWHDQZJ00000000.genome.fasta.gz
#set YAOFaPat = GWHDOOG00000000.genome.fasta.gz
#zcat $YAOFaMat | sed 's/ /_/g' | sed 's/\t/_/g' | sed 's/_.*//g' > YAOmatModHeader.fa
#gzip YAOmatModHeader.fa
#mv YAOmatModHeader.fa.gz $YAOFaMat
#zcat $YAOFaPat | sed 's/ /_/g' | sed 's/\t/_/g' | sed 's/_.*//g' > YAOpatModHeader.fa
#gzip YAOpatModHeader.fa
#mv YAOpatModHeader.fa.gz $YAOFaPat

# Before running this script: update names of species assembly fa after new download
set humanFaT2T = hs1.fa.gz
set chimpFaT2Tpri = mPanTro3.pri.cur.20231122.fasta.gz
set bonoboFaT2Tpri = mPanPan1.pri.cur.20231122.fasta.gz
set gorillaFaT2Tpri = mGorGor1.pri.cur.20231122.fasta.gz
#set orangutanFaT2Tpri = mPonAbe1.pri.cur.20231122.fasta.gz
set orangutanFaT2Tpri = mPonAbe1.pri.cur.20231205.fasta.gz
set borangutanFaT2Tpri = mPonPyg2.pri.cur.20231122.fasta.gz
set gibbonFaT2Tpri = mSymSyn1.pri.cur.20231205.fasta.gz
set chimpFaT2Talt = mPanTro3.alt.cur.20231122.fasta.gz
set bonoboFaT2Talt = mPanPan1.alt.cur.20231122.fasta.gz
set gorillaFaT2Talt = mGorGor1.alt.cur.20231122.fasta.gz
#set orangutanFaT2Talt = mPonAbe1.alt.cur.20231122.fasta.gz
set orangutanFaT2Talt = mPonAbe1.alt.cur.20231205.fasta.gz
set borangutanFaT2Talt = mPonPyg2.alt.cur.20231122.fasta.gz
set gibbonFaT2Talt = mSymSyn1.alt.cur.20231205.fasta.gz
#set humanFaGapped = hg38.fa.gz
#set chimpFaGapped = panTro6.fa.gz
#set bonoboFaGapped = panPan2.fa.gz
#set gorillaFaGapped = gorGor5.fa.gz
#set orangutanFaGapped = ponAbe3.fa.gz
#set HG002FaMat = HG002mat.fasta.gz
#set HG002FaPat = HG002pat.fasta.gz
#set YAOFaMat = GWHDQZJ00000000.genome.fasta.gz
#set YAOFaPat = GWHDOOG00000000.genome.fasta.gz
#set Han1Fa = /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/3JylfV3 #could mv to rename to Han1_v1.2.fasta
#set CN1FaMat = /work/yl726/PrimateT2T_15way/v0.8_CN1_mat.v0.8.fasta.gz
#set CN1Fapat = /work/yl726/PrimateT2T_15way/v0.8_CN1_pat.v0.8.fasta.gz

mv $chimpFaT2Tpri $tmp/chimpT2Tpri.fa.gz
mv $bonoboFaT2Tpri $tmp/bonoboT2Tpri.fa.gz
mv $gorillaFaT2Tpri $tmp/gorillaT2Tpri.fa.gz
mv $orangutanFaT2Tpri $tmp/orangutanT2Tpri.fa.gz
mv $borangutanFaT2Tpri $tmp/borangutanT2Tpri.fa.gz
mv $gibbonFaT2Tpri $tmp/gibbonT2Tpri.fa.gz
mv $chimpFaT2Talt $tmp/chimpT2Talt.fa.gz
mv $bonoboFaT2Talt $tmp/bonoboT2Talt.fa.gz
mv $gorillaFaT2Talt $tmp/gorillaT2Talt.fa.gz
mv $orangutanFaT2Talt $tmp/orangutanT2Talt.fa.gz
mv $borangutanFaT2Talt $tmp/borangutanT2Talt.fa.gz
mv $gibbonFaT2Talt $tmp/gibbonT2Talt.fa.gz
mv $humanFaT2T $tmp/humanT2T.fa.gz
#mv $chimpFaGapped $tmp/chimpGapped.fa.gz
#mv $bonoboFaGapped $tmp/bonoboGapped.fa.gz
#mv $gorillaFaGapped $tmp/gorillaGapped.fa.gz
#mv $orangutanFaGapped $tmp/orangutanGapped.fa.gz
#mv $humanFaGapped $tmp/humanGapped.fa.gz
#mv $HG002FaMat $tmp/HG002mat.fa.gz
#mv $HG002FaPat $tmp/HG002pat.fa.gz
#mv $YAOFaMat $tmp/YAOmat.fa.gz
#mv $YAOFaPat $tmp/YAOpat.fa.gz
#mv $Han1Fa $tmp/Han1.fa.gz
#mv $CN1FaMat $tmp/CN1mat.fa.gz
#mv $CN1FaPat $tmp/CN1pat.fa.gz

set faSize = /hpc/group/vertgenlab/cl454/bin/x86_64/faSize
set faToTwoBit = /hpc/group/vertgenlab/cl454/bin/x86_64/faToTwoBit
set faSplit = /hpc/group/vertgenlab/cl454/bin/x86_64/faSplit
set faFilter = ~/go/bin/faFilter

set minSize = 20_000

foreach genome ($tmp/*.fa.gz)
        set gFile = `basename $genome`
        echo $gFile
        set prefix = $gFile:r:r
        mkdir -p $tmp/$prefix.byChrom
        $faFilter -minSize $minSize $genome $genome
        $faSize -detailed $genome > $tmp/$prefix.chrom.sizes
        $faToTwoBit $genome $tmp/$prefix.2bit
        $faSplit byname $genome $tmp/$prefix.byChrom/
end

echo DONE
