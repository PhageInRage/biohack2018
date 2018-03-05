library(dplyr)
library(stringr)
library(ggplot2)

source("correlation_funcs.R")

phages_viroms <- read.csv("phages.csv", sep = "\t", stringsAsFactors = F)
bacteria_viroms <- read.csv("bact.csv", sep = "\t", stringsAsFactors = F)
phages_references_lengths <- read.csv("len_phages.csv", sep ="\t")
bacteria_references_lengths <- read.csv("len_bacts.csv", sep ="\t")

phages <- unique(phages_viroms$title)
bacteria <- unique(bacteria_viroms$title)
humans <- unique(phages_viroms$file_name)

phages_vector <- vectorization(humans, phages_viroms, phages, phages_references_lengths)
bacteria_vector <- vectorization(humans, bacteria_viroms, bacteria, bacteria_references_lengths)
bacteria_vector <- merge_elements_by_prefix(bacteria_vector, "Burkholderia cenocepacia J2315")

correl <- calculate_correlation(phages, phages_vector, names(bacteria_vector), bacteria_vector)

ggplot(data = data.frame(correl), aes(x = phages, y = bacteria)) +
  geom_tile(aes(fill = value)) 