#!/bin/csh -ef

set tmp = /work/yl726/PrimateT2T_15way
mkdir -p $tmp/neutralModel
set phastBin = "/hpc/group/vertgenlab/cl454/src/phast/phast/bin"
set kentBin = "/hpc/group/vertgenlab/cl454/bin/x86_64"
set mafDir = $tmp/outputb

# process humanT2T genome gene annotation
#wget https://hgdownload.soe.ucsc.edu/goldenPath/hs1/bigZips/genes/catLiftOffGenesV1.gtf.gz # now no longer exists
#wget https://hgdownload.soe.ucsc.edu/goldenPath/hs1/bigZips/genes/hs1.ncbiRefSeq.gtf.gz # actually just get gp directly
#wget https://hgdownload.soe.ucsc.edu/goldenPath/hs1/bigZips/genes/hs1.ncbiRefSeq.gp.gz
#mv hs1.ncbiRefSeq.gtf.gz $tmp/neutralModel/hs1.ncbiRefSeq.gtf.gz
#mv hs1.ncbiRefSeq.gp.gz $tmp/neutralModel/hs1.ncbiRefSeq.gp.gz
#gunzip $tmp/neutralModel/hs1.ncbiRefSeq.gtf.gz
#gunzip $tmp/neutralModel/hs1.ncbiRefSeq.gp.gz
#$kentBin/gtfToGenePred $tmp/neutralModel/hs1.ncbiRefSeq.gtf.gz $tmp/neutralModel/hs1.ncbiRefSeq.gtf.gp
#$kentBin/genePredSingleCover $tmp/neutralModel/hs1.catLiftOffGenesV1.gp $tmp/neutralModel/hs1.catLiftOffGenesV1.singleCov.gp
#$kentBin/genePredSingleCover $tmp/neutralModel/hs1.ncbiRefSeq.gp $tmp/neutralModel/hs1.ncbiRefSeq.singleCov.gp

# if alignments are referenced on hg38
# humanGapped genome gene annotation
#$kentBin/genePredToGtf hg38 knownGene $tmp/neutralModel/kg.hg38.gtf
#$kentBin/gtfToGenePred $tmp/neutralModel/kg.hg38.gtf $tmp/neutralModel/kg.hg38.gp
#$kentBin/genePredSingleCover $tmp/neutralModel/kg.hg38.gp $tmp/neutralModel/kg.singleCov.hg38.gp

#foreach f ($mafDir/*.maf)
        #set chr = $f:t:r
        #echo $chr
        #/bin/awk -v C=$chr '$2 == C {print}' $tmp/neutralModel/hs1.ncbiRefSeq.singleCov.gp | sed -e "s/\t$chr\t/\thumanT2T.$chr\t/" > $tmp/neutralModel/$chr.gp
        #$phastBin/msa_view $f --in-format MAF --4d --features $tmp/neutralModel/$chr.gp -o SS > $tmp/neutralModel/$chr.codons.ss
        #$phastBin/msa_view $tmp/neutralModel/$chr.codons.ss --in-format SS --out-format SS --tuple-size 1 > $tmp/neutralModel/$chr.sites.ss
#end

$phastBin/msa_view --out-format SS --unordered-ss --aggregate "humanT2T,chimpT2Tpri,chimpT2Talt,bonoboT2Tpri,bonoboT2Talt,gorillaT2Tpri,gorillaT2Talt,orangutanT2Tpri,orangutanT2Talt,borangutanT2Tpri,borangutanT2Talt,gibbonT2Tpri,gibbonT2Talt" $tmp/neutralModel/chr*.sites.ss > $tmp/neutralModel/all-4d.sites.ss
$phastBin/phyloFit --tree "((((humanT2T,((chimpT2Tpri,chimpT2Talt),(bonoboT2Tpri,bonoboT2Talt))),(gorillaT2Tpri,gorillaT2Talt)),((orangutanT2Tpri,orangutanT2Talt),(borangutanT2Tpri,borangutanT2Talt))),(gibbonT2Tpri,gibbonT2Talt))" --msa-format SS --out-root allT2T-4d $tmp/neutralModel/all-4d.sites.ss
#$phastBin/phyloFit --tree "(((((humanT2T),((chimpT2Tpri,chimpT2Talt),(bonoboT2Tpri,bonoboT2Talt))),(gorillaT2Tpri,gorillaT2Talt)),((orangutanT2Tpri,orangutanT2Talt),(borangutanT2Tpri,borangutanT2Talt))),(gibbonT2Tpri,gibbonT2Talt))" --msa-format SS --out-root allT2T-4d $tmp/neutralModel/all-4d.sites.ss
#old tree that worked: "(((humanT2T,((chimpT2Tpri,chimpT2Talt),(bonoboT2Tpri,bonoboT2Talt))),(gorillaT2Tpri,gorillaT2Talt)),(orangutanT2Tpri,orangutanT2Talt))"

# phyloFit generates 4d.mod

echo DONE
