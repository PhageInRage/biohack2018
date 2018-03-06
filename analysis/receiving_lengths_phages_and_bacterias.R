library(dplyr)
library(data.table)

read_files <- function(fileName, kind, csv_name) {
  data <- data.table()
  
  con = file(fileName, "r")
  lenPhages <- list()
  while (TRUE) {
    line = readLines(con, n = 1)
    
    if(length(line) > 0 && grepl(">", line)) {
      line <- sub(">", "", line) %>% 
        strsplit(., split=' ', fixed=TRUE)
      
      if (kind == "phages" || kind == "backt" && !grepl("NZ_", line[[1]][1])) {
        title <- sub(" \t", "", paste0(line[[1]][3:length(line[[1]])-1], collapse=" "))
        len <- as.numeric(sub("\t", "", line[[1]][length(line[[1]])]))
        lenPhages[title] <- len
        data <- bind_rows(data, c(title=title, len=len))
      }
    }
    if (length(line) == 0) break
  }
  write.table(data, paste(csv_name,".csv",sep=""), sep="\t", row.names = F)
  close(con)
  
  return(lenPhages)
}

lenPhages <- read_files("Phage_lengths", "phages", "len_phages")
lenBacts <- read_files("Bacterial_lengths.full", "backt", "len_bacts")