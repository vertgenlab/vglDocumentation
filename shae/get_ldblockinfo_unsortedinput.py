if __name__ == "__main__":
    # Read in data from input file as list
    with open('copy_gwas_all_chrs_filt_r2_7.ld', 'r') as f:
        ld_data = f.readlines()
        ld_data = [line.strip().split('\t') for line in ld_data]
        f.close()

    # Make dictionary to collect info for each GWAS SNP ['CHR', 'FIRST_LD_SNP', 'LAST_LD_SNP', 'GWAS_SNP', 'NUM_LD_SNPS']
    snp_dict = dict()

    # Iterate through LD data and add data about each GWAS SNP to dictionary
    for item in ld_data:
        # Add previously unseen GWAS SNPs to dictionary as keys
        if item[2] not in snp_dict:
            snp_dict[item[2]] = [item[0], int(item[4]), int(item[4]), item[2], 1]

        # Add 1 to the number of SNPs in LD with the current GWAS SNP, update running minimum and maximum LD SNP position
        else:
            snp_dict[item[2]][4] += 1
            if int(item[4]) < snp_dict[item[2]][1]:
                snp_dict[item[2]][1] = int(item[4])
            if int(item[4]) > snp_dict[item[2]][2]:
                snp_dict[item[2]][2] = int(item[4])

    # Open output file and write data as tab-delimited bed file
    with open('ldblockdata_unsortedinput.bed', 'w') as f:
        for key in snp_dict:
            snp_dict[key][1] = str(snp_dict[key][1])
            snp_dict[key][2] = str(snp_dict[key][2])
            snp_dict[key][4] = str(snp_dict[key][4])
            f.write('\t'.join(snp_dict[key]) + '\n')
        f.close()
