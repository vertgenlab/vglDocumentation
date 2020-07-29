#!/bin/sh
#SBATCH --mem=16G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --parsable
#SBATCH --job-name=vcfSitesOnly
set -e
module add GATK
VCF=$1
PREFIX=$(basename $VCF .vcf.gz)
echo $PREFIX
gatk SelectVariants --sites-only-vcf-output -V $VCF -O ${PREFIX}.sitesonly.vcf.gz
