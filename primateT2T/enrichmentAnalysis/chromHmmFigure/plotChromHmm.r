library(ggpubr)
library(tidyr)
library(dplyr)
library(gridExtra)

########## data frame prep from file ################
data1 <- read.csv("chromHmm.Enrichment.summary.txt", header=FALSE, sep="\t")
data1 <- subset(data1, select = -c(V1, V4, V5, V6, V7, V8))
colnames(data1) <- c("FileName1", "FileName2", "Enrichment", "pEnrich", "pDeplete")
data1$Species <- sapply(strsplit(data1$FileName2, "/"), function(x) sub(".bed", "", tail(x,1)))
data1$State <- sapply(strsplit(sapply(strsplit(data1$FileName1, "/"), tail, 1), "\\."), function(x) x[2])
data1$Epigenome <- sapply(strsplit(sapply(strsplit(data1$FileName1, "/"), tail, 1), "\\."), function(x) sub("_15_coreMarks_hg38lift_mnemonics", "", x[1]))
data1 <- subset(data1, select = c("Enrichment", "pEnrich", "pDeplete", "Species", "State", "Epigenome"))

data2 <- read.csv("chromHmmForComp.txt", header=TRUE, sep="\t")
data2 <- data2 %>%
	subset(select = c("Enrichment", "EnrichPValue", "DepletePValue", "Assemblies", "State", "Epigenome")) %>%
	rename(Species = Assemblies) %>%
	rename(pEnrich = EnrichPValue) %>%
	rename(pDeplete = DepletePValue) %>%
	filter(Species == "haqer.hg38") 

data <- rbind(data1, data2)
data <- data %>%
	filter(Enrichment > 0) %>%
	mutate(State = case_when(
		State == "1_TssA" ~ "Active TSS",
		State == "4_Tx" ~ "Strong Transcription",
		State == "7_Enh" ~ "Active Enhancer",
		State == "8_ZNF" ~ "ZNF Genes + Repeats",
		State == "9_Het" ~ "Heterochromatin",
		State == "TssBiv" ~ "Bivalent/poised TSS",
		State == "12_EnhBiv" ~ "Bivalent Enhancer",
		State == "13_ReprPC" ~ "Repressed Polycomb",
		TRUE ~ State
	)) %>%
	filter(State %in% c("Active TSS", "Strong Transcription", "Active Enhancer", "ZNF Genes + Repeats", "Heterochromatin", "Bivalent/poised TSS", "Bivalent Enhancer", "Repressed Polycomb"))

data$State <- factor(data$Region, levels = c("Active TSS", "Strong Transcription", "Active Enhancer", "ZNF Genes + Repeats", "Heterochromatin", "Bivalent/poised TSS", "Bivalent Enhancer", "Repressed Polycomb"))
data$log2Enrich <- log2(data$Enrichment)
data$pAdj <- p.adjust(pmin(data$pEnrich, data$pDeplete), method="fdr")
data$minusLog10pAdj <- -log10(data$pAdj+1e-300)

########### subsetting data frame for panels #############
speciesData <- data %>%
	filter(data$Species %in% c("human", "chimpanzee", "bonobo", "gorilla"))
speciesData$State <- factor(speciesData$State, levels = c("Active TSS", "Strong Transcription", "Active Enhancer", "ZNF Genes + Repeats", "Heterochromatin", "Bivalent/poised TSS", "Bivalent Enhancer", "Repressed Polycomb"))	

	
sharedData <- data %>%
	filter(data$Species %in% c("human", "shared.hg38.showGapped", "haqer.hg38"))
sharedData$State <- factor(sharedData$State, levels = c("Active TSS", "Strong Transcription", "Active Enhancer", "ZNF Genes + Repeats", "Heterochromatin", "Bivalent/poised TSS", "Bivalent Enhancer", "Repressed Polycomb"))

############### setting up color palettes ##########
gappedColor <- "#d91f3a"
t2tColor <- "#4254a4"
sharedColor <- "#8e3e97"
sharedPalette <- c(gappedColor, t2tColor, sharedColor)

humanColor <- "#d6723c"
chimpanzeeColor <- "#52956b"
bonoboColor <- "#8c5383"
gorillaColor <- "#583618"
speciesPalette <- c(humanColor, chimpanzeeColor, bonoboColor, gorillaColor)

############# panels ################
a <- ggboxplot(sharedData, x="State", y="log2Enrich", color="Species", fill="Species", alpha=0.1, add="jitter", add.params=list(size=0.1), palette = sharedPalette)+theme(axis.text.x=element_text(angle=45, hjust=1, vjust=1))+geom_hline(yintercept=0, linetype="dashed")
b <- ggboxplot(speciesData, x="State", y="log2Enrich", color="Species", fill="Species", alpha=0.1, add="jitter", add.params=list(size=0.1), palette = speciesPalette)+theme(axis.text.x=element_text(angle=45, hjust=1, vjust=1))+geom_hline(yintercept=0, linetype="dashed")
pdf("chromHmmRaw.pdf", height=8, width=10)
grid.arrange(a, b)
dev.off()





