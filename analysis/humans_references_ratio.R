library(data.table)
library(dplyr)

references_file <- "../bacterious.fasta"
viroms_prefixes_file <- "../viroms.txt"
viroms_folder <- "../results/"
output_csv_file <- "bact.csv"

readFile <- function(fileName) {
  con = file(fileName, "r")
  strings <- c()
  while (TRUE) {
    line = readLines(con, n = 1)
    strings <- c(strings, line)
    print(strings)
    if (length(line) == 0) break
  }
  close(con)
  return(strings)
}


con = file(references_file, "r")
strings <- list()
while (TRUE) {
  line = readLines(con, n = 1)
  
  if(length(line) > 0 && grepl(">", line)) {
    line <- sub(">", "", line) %>% 
      strsplit(., split=' ', fixed=TRUE)
    strings[line[[1]][1]] <- paste0(line[[1]][2:length(line[[1]])], collapse=" ")
    print(line)
  }
  if (length(line) == 0) break
}
close(con)


data <- data.table()

peoplePhages <- readFile(viroms_prefixes_file)
for (i in 1:length(peoplePhages)) {
  person <- readFile(paste0(viroms_folder, peoplePhages[i], ".txt"))
  for (j in 1:length(person)) {
    file_name <- sub(".*/", "", peoplePhages[i]) %>% 
      sub(".txt", "", .)
    phague <- sub("\\s*", "", person[j]) %>% 
      strsplit(., split=' ', fixed=TRUE)
    line <- list()
    if (length(phague) > 0 && phague[[1]][2] %in% names(strings)) {
      
      line <- list("file_name"=file_name, "phague"=phague[[1]][2], 
                   "number"=phague[[1]][1], "title"=strings[phague[[1]][2]][[1]])
    }
    
    if (length(line) > 0)
      data <- bind_rows(data, line)
  }
}

write.table(data, output_csv_file, sep="\t", row.names = F)
