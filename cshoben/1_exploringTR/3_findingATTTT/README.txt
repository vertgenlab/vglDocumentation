last updated: 11/17/22
Goal: Find all instances of ATTTT repeat in the human genome. 

Steps:
1. Make fake fasta of (ATTTT)10 
2. Download hg38 and t2t. Make sure all uppercase. 

use gonomics/cmd/fasta ToUpper() to create a hg38.fa that is all uppercase. 

3. Run blast, turn off any repeat or low-complexity filters. 

create a database of the reference genome to use as the 'subject'
module load NCBI_BLAST/2.7.1

4. Results are in 'result_fakeATTTT_hg38.out'


## blast result tab separated file with the following
## 1. query seq ID
## 2. subject seq ID
## 3. percentage of identical matches
## 4. length of seq overlap
## 5. number of mismatches
## 6. number of gap openings
## 7. start of alignment in query
## 8. end of alignment in query
## 9. start of alignment in subject
## 10. end of alignment in subject
## 11. evalue
## 12. bitscore

## see: https://www.metagenomics.wiki/tools/blast/blastn-output-format-6



Future: Explore these regions further. Do they overlap with chromatin patterns of gene regulators? Instances of an ATTTC inside of any of them? Are they in promoter regions or genes? Can we look at population data to determine how variable they are? 
