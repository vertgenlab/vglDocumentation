# Pull out info about leftmost and rightmost SNP in LD with each GWAS catalogued SNP (from get_ldblockinfo_unsortedinput.py) and mean / median distance to each SNP in LD with each GWAS SNP (from get_ldsnp_distanceinfo.py)
# Dictionary structure form get_ldsnp_distanceinfo.py intact – switched out position info to refer to first and last SNP in LD with the GWAS SNP instead of the GWAS SNP position itself

import statistics

if __name__ == "__main__":
    with open('gwas_all_chrs_first10000.ld', 'r') as f:
        ld_data = f.readlines()
        ld_data = [line.strip().split('\t') for line in ld_data]
        f.close()

    # Remove header –– DELETE WHEN UPLOADING TO CLUSTER
    ld_data = ld_data[1:]

    # Make dictionary to collect information for each GWAS SNP – this will feed into output file
    snp_dict = dict()

    # Make dictionary to collect distance to each SNP in LD for each GWAS SNP
    ldsnp_distances = dict()

    # Iterate through LD data and add distances to dictionary
    for item in ld_data:

        # If GWAS SNP not already in dictionary, add it to both dictionaries with corresponding values
        if item[2] not in snp_dict:
            snp_dict[item[2]] = [item[0], int(item[4]), int(item[4]), item[2], "", ".", "", ""]
            ldsnp_distances[item[2]] = [abs(int(item[1]) - int(item[4]))]

        else:
            distance = abs(int(item[1]) - int(item[4]))
            ldsnp_distances[item[2]].append(distance)
            if int(item[4]) < snp_dict[item[2]][1]:
                snp_dict[item[2]][1] = int(item[4])
            if int(item[4]) > snp_dict[item[2]][2]:
                snp_dict[item[2]][2] = int(item[4])

    # Add LD distance information to snp_dict
    for key in ldsnp_distances:

        # Calculate summary statistics for each LD block
        avg_distance = statistics.mean(ldsnp_distances[key])
        median_length = statistics.median(ldsnp_distances[key])
        num_snps = len(ldsnp_distances[key])

        # Add this data into the snp_dict
        snp_dict[key][4] = str(num_snps)
        snp_dict[key][6] = str(avg_distance)
        snp_dict[key][7] = str(median_length)

    # Open output file and write data as tab-delimited bed file
    with open('gwassnp_ld_allinfo.bed', 'w') as f:
        for key in snp_dict:
            snp_dict[key][1] = str(snp_dict[key][1])
            snp_dict[key][2] = str(snp_dict[key][2])
            f.write('\t'.join(snp_dict[key]) + '\n')
        f.close()