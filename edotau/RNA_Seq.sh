#!/bin/sh
#SBATCH --mem=16G
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --nodes=1
#SBATCH --time=2-0
#SBATCH --job-name=Snps.RNA-Seq
#SBATCH --exclude=dl-01
set -e
module load GATK/4.1.0.0-gcb01 java/1.8.0_45-fasrc01 samtools/1.9-gcb01 fastqc/0.11.5-fasrc01 STAR/2.7.2b-gcb01
picard=/data/lowelab/edotau/software/picard.jar

#RGPU=EA02
#library=atac

#PREFIX=$(echo $i | sed 's/.bam//')

#star_ref=/data/lowelab/RefGenomes/gasAcu1/STARindex
#ref=/data/lowelab/RefGenomes/gasAcu1/gasAcu1.fa
star_ref=/data/lowelab/edotau/toGasAcu1.5/idx/STAR_2

REF=/data/lowelab/edotau/toGasAcu1.5/idx/stickleback_v5_assembly.fa
input1=$1
input2=$2

PREFIX=$(echo $input1 | cut -d '_' -f 1)
bn=$PREFIX
opdir=$bn".RNA-Seq"
mkdir -p $opdir

READ1=$opdir/${PREFIX}_R1.fastq.gz
READ2=$opdir/${PREFIX}_R2.fastq.gz

fastqc -t $SLURM_CPUS_ON_NODE $input1 $input2 -o $opdir
#Preprocessing
#Trimming adaptors
/data/lowelab/edotau/bin/github.com/bbmap/bbduk.sh \
	in1=$input1 \
	in2=$input2 \
	out1=$READ1 \
	out2=$READ2 \
	minlen=25 qtrim=rl trimq=10 ktrim=r k=25 mink=11 hdist=1 \
	ref=/data/lowelab/edotau/bin/github.com/bbmap/resources/adapters.fa

#MAPPING

echo -e "["$(date)"]\tAligning.."
STAR --outFileNamePrefix $opdir/$bn --outSAMtype BAM Unsorted --outSAMstrandField intronMotif --outSAMattrRGline ID:$bn CN:Gonomics LB:PairedEnd PL:Illumina PU:HiSeqX SM:$bn --genomeDir $star_ref --runThreadN $SLURM_CPUS_ON_NODE --readFilesCommand zcat --readFilesIn $READ1 $READ2 --twopassMode Basic

echo -e "["$(date)"]\tSorting.."
samtools sort -@ $SLURM_CPUS_ON_NODE -o $opdir/$bn"_sorted.bam" $opdir/$bn"Aligned.out.bam"
rm $opdir/$bn"Aligned.out.bam"

echo -e "["$(date)"]\tIndexing.."
samtools index -@ $SLURM_CPUS_ON_NODE $opdir/$bn"_sorted.bam"

echo -e "["$(date)"]\tMarking duplicates.."
java -Xmx12G -jar $picard MarkDuplicates I=$opdir/$bn"_sorted.bam" O=$opdir/$bn"_dupMarked.bam" M=$opdir/$bn"_dup.metrics" CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT 2>$opdir/$bn.MarkDuplicates.log
rm $opdir/$bn"_sorted.bam"
rm $opdir/$bn"_sorted.bam.bai"
echo "RNA transcript ASSEMBLY...(stringtie)"

module add StringTie/2.1.1-gcb01
gtf=/data/lowelab/edotau/toGasAcu1.5/RNA-Seq/stickleback_f1_hybrid.gtf
#/data/lowelab/edotau/toGasAcu1.5/idx/stickleback_v5_maker_genes_nath2020.gff3
stringtie $opdir/$bn"_dupMarked.bam" -p $SLURM_CPUS_ON_NODE -G $gtf -o ${PREFIX}.RNA-Seq.gtf -l ${PREFIX^^} -v

#SplitNCigarReads
echo -e "["$(date)"]\tSpliting reads.."
gatk SplitNCigarReads --java-options "-Xmx12G" --input $opdir/$bn"_dupMarked.bam" --output $opdir/$bn"_split.bam" --reference $REF 2>$opdir/$bn.SplitNCigarReads.log
samtools index -@ $SLURM_CPUS_ON_NODE $opdir/$bn"_split.bam"
#gvcf="gvcf"
#/data/lowelab/edotau/toGasAcu1.5/RNA-Seq/garrett/scripts/haplotype.sh $opdir/$bn"_split.bam" $REF

submit=${PREFIX}.gatk.txt
#/data/lowelab/edotau/toGasAcu1.5/scripts/gatkToText.sh $opdir/$bn"_split.bam" $REF $submit
#/data/lowelab/edotau/toGasAcu1.5/scripts/array.gatk.sh $submit
#mkdir -p $gvcf
#for i in $list
#do 
#	output=$gvcf/${bn}.${i}.g.vcf.gz
#	sbatch --mem=16G --exclude=dl-01,c1-10-3 --cpus-per-task=4 --nodes=1 --time=1-12 --job-name=SNPsGarret_$PREFIX --wrap="gatk HaplotypeCaller --input $opdir/${bn}_split.bam --dont-use-soft-clipped-bases true --output $output --reference $REF -G StandardAnnotation -G AS_StandardAnnotation -G StandardHCAnnotation -ERC GVCF -L $i"
#done


exit 0


#gatk VariantFiltration --java-options "-Xmx8g" --variant $opdir/${PREFIX}.haplotypecaller.vcf --output $opdir/${bn}.ASE.final.vcf --cluster-window-size 35 --cluster-size 3 --filter-name FS --filter-expression "FS > 30.0" --filter-name QD --filter-expression "QD < 2.0" 2>$opdir/$bn.VariantFilter.log
