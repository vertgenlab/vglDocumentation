library(ggpubr)
library(dplyr)
library(tidyr)
library(gridExtra)

data1 <- read.csv("gappedRepeatEnrichments.txt", header=FALSE, sep="\t")
data2 <- read.csv("merged.enrichmentResults.repeatMaskerAcrossPrimates.txt", header=FALSE, sep="\t")
data3 <- read.csv("segDupEnrichment.Summary.txt", header=FALSE, sep="\t")
data1 <- subset(data1, select = c(V2, V5, V11, V12, V13))
data2 <- subset(data2, select = -c(V1, V4, V5, V6, V7, V8))
data3 <- subset(data3, select = -c(V1, V4, V5, V6, V7, V8))
colnames(data1) <- c("FileName1", "FileName2", "Enrichment", "pEnrich", "pDeplete")
colnames(data2) <- c("FileName1", "FileName2", "Enrichment", "pEnrich", "pDeplete")
colnames(data3) <- c("FileName1", "FileName2", "Enrichment", "pEnrich", "pDeplete")
data <- rbind(data1, data2, data3)
data$Region <- sapply(strsplit(data$FileName2, "/"), function(x) sub(".bed", "", tail(x,1)))
data$Class <- sapply(strsplit(data$FileName1, "/"), function(x) sub(".bed", "", tail(x, 1)))
data$log2Enrich <- log2(data$Enrichment)
data$pAdj <- p.adjust(pmin(data$pEnrich, data$pDeplete), method="fdr")
data$minusLog10pAdj <- -log10(data$pAdj+1e-300)

data <- data %>%
  mutate(Region = case_when(
     Region == "allGapped.hs1" ~ "Gapped",
     TRUE ~ Region
   )) %>%
   mutate(Class = case_when(
     Class == "Rmsk_SINE" ~ "SINE",
     Class == "Rmsk_SimpleRepeat" ~ "Simple Repeat",
     Class == "Simple_repeat" ~ "Simple Repeat",
     Class == "Rmsk_Satellite" ~ "Satellite",
     Class == "Rmsk_LINE" ~ "LINE",
     Class == "Rmsk_LTR" ~ "LTR",
     Class == "Rmsk_RetroposonSVA" ~ "SVA",
     Class == "gorilla.segDup" ~ "Segmental Duplication",
     Class == "chimpanzee.segDup" ~ "Segmental Duplication",
     Class == "bonobo.segDup" ~ "Segmental Duplication",
     Class == "human.segDup" ~ "Segmental Duplication",
     Class == "SegDups2024" ~ "Segmental Duplication",
     TRUE ~ Class
   )) %>%
   filter(Class %in% c("SINE", "Simple Repeat", "Satellite", "LINE", "LTR", "SVA", "Segmental Duplication"))
   
gappedData <- data %>%
	select("log2Enrich", "Region", "Class") %>%
	filter(Region %in% c("Gapped", "human")) %>%
	pivot_wider(values_from="log2Enrich", names_from="Region")
	
nhpData <- data %>%
	filter(Region %in% c("gorilla", "chimpanzee", "bonobo"))

myPalette <- c("#e76f51", "#f4a261", "#e9c46a", "#8ab17d", "#2a9d8f", "#287271", "#264653")

a <- ggscatter(gappedData, "Gapped", "human", color="Class", label="Class", palette = myPalette, size=5)+geom_abline(intercept=0, linetype="dashed", slope=1)+geom_vline(xintercept=0)+geom_hline(yintercept=0)+ylim(-2.5,3)+theme(legend.position="none")+xlab("log2Enrich - Gapped Human Assembly (hg38)") +ylab("log2Enrich - T2T Human Assembly (CHM13.v2)")
b <- ggscatter(nhpData, x="Region", y="log2Enrich", label="Class", color="Class", palette = myPalette, size=5)+geom_hline(yintercept=0)+ylim(-2.5, 3)+theme(legend.position="none")+xlab("Species")+ylab("log2Enrich - T2T Primate Assembly")

pdf("rawRepeatPanel.pdf", height=5, width=8)
grid.arrange(b, a, nrow=1)
dev.off()