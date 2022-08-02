library('ggplot2')
library('ggpubr')

data <- read.csv('Lowe_Lab/haqer_project/final_gwas_ld_haqeroverlaps_data/final_gwas_ld_overlapdata.csv', header=TRUE, sep=",")

haqerColor="#F64C3C"
randColor="#2B3964"
harColor="#F1D26A"
myPalette <- c(haqerColor, randColor, harColor)

my_comparisons <- list(c("HAQER", "HAR"), c("HAQER", "RAND"), c("HAR", "RAND"))
myTheme <- theme(axis.title.x=element_blank(), axis.text.x=element_text(face="bold", color=myPalette), axis.title.y=element_text(face="bold"), axis.text.y=element_text(face="bold"), strip.background = element_blank(), strip.text=element_text(face="bold"), legend.position='none', axis.ticks=element_blank(), panel.border=element_blank())

p <- ggviolin(data, x = "REGION", y = "MEAN_DIST", color="REGION", fill="REGION", palette=myPalette, alpha=0.5)
q <- ggviolin(data, x = "REGION", y = "MEDIAN_DIST", color = "REGION", fill = "REGION", palette = myPalette, alpha = 0.5)
r <- ggscatter(data, x="MEAN_DIST", y="MEDIAN_DIST", color="REGION", fill="REGION", palette = myPalette, add='reg.line')

# pdf("Lowe_Lab/haqer_project/final_gwas_ld_haqeroverlaps_data/final_gwas_ldsnp_meandist.pdf", height=5, width=5)
# p + myTheme + stat_compare_means(comparisons = my_comparisons, label="p.signif")
# pdf("Lowe_Lab/haqer_project/final_gwas_ld_haqeroverlaps_data/final_gwas_ldsnp_mediandist.pdf", height=5, width=5)
# q + myTheme + stat_compare_means(comparisons = my_comparisons, label = "p.signif")
# pdf("Lowe_Lab/haqer_project/final_gwas_ld_haqeroverlaps_data/final_meandist_vs_mediandist.pdf", height=5, width=5)
# r + myTheme
# dev.off()

logscale_snpnum <- ggviolin(data, x="REGION", y="SNP_NUM", color="REGION", fill="REGION", palette=myPalette, alpha=0.5)+ yscale("log10")
pdf("Lowe_Lab/haqer_project/final_gwas_ld_haqeroverlaps_data/final_gwas_ldsnpnum.pdf", height=5, width=5)
logscale_snpnum + myTheme + stat_compare_means(comparisons=my_comparisons, label="p.signif")
dev.off()


