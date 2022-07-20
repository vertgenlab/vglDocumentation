if __name__ == "__main__":

    import sys
    
    # Read in data from input file as list
    with open('copy_sorted_gwas_all_chrs_filt_r2_7.ld', 'r') as f:
        ld_data = f.readlines()
        ld_data = [line.strip().split('\t') for line in ld_data]
        f.close()

    # Create variable to catch desired data, columns will be ['CHR', 'FIRST_LD_SNP', 'LAST_LD_SNP', 'GWAS_SNP', 'NUM_LD_SNPS']
    filtered_ld_data = []

    # Initialize variables for GWAS SNP, leftmost LD SNP, number of SNPs in LD with the GWAS SNP
    gwas_SNP = ld_data[0][2]
    first_LD_SNP = ld_data[0][4]
    num_LD_SNPs = 0

    # Sublist to catch data for each GWAS SNP
    data_bySNP = ['', first_LD_SNP, '', gwas_SNP, '']

    # Iterate through LD data list
    for i in range(1, len(ld_data)):
        num_LD_SNPs += 1

        if ld_data[i][2] != data_bySNP[3]:
            # Subtract 1 from the number of SNPs in LD with this variant because you've moved onto the first SNP of the next GWAS variant
            num_LD_SNPs -= 1

            # Assign values to data_bySNP and append to overall list of LD data (one list of data for each GWAS SNP)
            data_bySNP[0] = ld_data[i-1][0]
            data_bySNP[2] = ld_data[i-1][4]
            data_bySNP[4] = str(num_LD_SNPs)
            
            if int(data_bySNP[2]) - int(data_bySNP[1]) < 0:
                print(data_bySNP)
                sys.exit()

            filtered_ld_data.append(data_bySNP)

            # Reset data_bySNP to catch values for next GWAS SNP
            data_bySNP = ['', ld_data[i][4], '', ld_data[i][2], '']
            num_LD_SNPs = 1

        # Handle last GWAS SNP in list (edge case)
        if i == len(ld_data) - 1:
            data_bySNP[0] = ld_data[i][0]
            data_bySNP[2] = ld_data[i][4]
            data_bySNP[4] = str(num_LD_SNPs)
            filtered_ld_data.append(data_bySNP)


    # Open output file and write data as tab-delimited bed file
    with open('ldblockdata.bed', 'w') as f:
        for list in filtered_ld_data:
            f.write('\t'.join(list) + '\n')
        f.close()
