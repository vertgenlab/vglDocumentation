#!/usr/bin/env Rscript --vanilla

## Load the tidyverse package
suppressWarnings(suppressMessages(library(tidyverse)))

## Parse in arguments from command line: 1=input.tsv, 2=output.png
args <- commandArgs(TRUE)
if (length(args) != 2) stop("Require 2 arguments: input_name (.tsv), output_name (.png)")

# Read the input tsv
# Get rid of comments starting with #
# col_types setting helps specify that the ancestral allele column is character
# (If all ancestral alleles are T, R detects as logical type [aka boolean]
freqs <- read_tsv(args[1], 
                  comment="#", 
                  col_types=cols(
                      Ancestral = col_character(),
                      Site = col_number(),
                  ), 
                  show_col_types = FALSE) %>% 
    pivot_longer(cols=c("Freq.A", "Freq.C", "Freq.G", "Freq.T"), names_to = "Allele",
                 names_prefix = "Freq.", values_to = "Freq") %>% # This line combines all Freq columns into one and make another column for allele
    mutate(State = case_when(Allele == Ancestral ~ "ancestral", 
                             Allele != Ancestral ~ "derived"), # This line makes a new column keeping ancestral/derived state
           Site = factor(Site))

## When there are more than one line, it is easier to see when the lines are more transparent.
if (length(unique(freqs$Site)) == 1) {
    size <- 1.5
    alpha <- 1
} else {
    size <- 1
    alpha <- 0.45
}

## Call the ggplot
p <- ggplot(freqs) +
    geom_line(aes(x=Gen, y=Freq, col=Allele, linetype=State), alpha = alpha, size = size) +
    theme_classic() + ylim(0,1) +
    labs(title="Allele Frequencies Simulation", x = "Generation", y= "Frequencies") +
    theme(plot.title = element_text(hjust = 0.5, size = 20),
          axis.text=element_text(size=20), #change font size of axis text
          axis.title=element_text(size=20), #change font size of axis titles
          legend.text=element_text(size=20), #change font size of legend text
          legend.title=element_text(size=20))

## Save to png
png(args[2], width = 2000, height = 1000)
print(p)
invisible(dev.off())