vectorization <- function(humans, viroms, entity, lens = NULL) { 
  phague_list <- list()
  
  for (i in 1:length(entity)) {
    humans_list <- c()
    for (j in 1:length(humans)) {
      t <- subset(viroms, viroms$file_name == humans[j] & viroms$title == entity[i])
      if (nrow(t) == 1) {
        if (is.null(lens)) {
          humans_list <- c(humans_list, t$number)
        } else {
          l <- lens[lens$title == entity[i], ]$len/1000
          humans_list <- c(humans_list, t$number/1000000/l)
        }
      } else if (nrow(t) == 0) {
        humans_list <- c(humans_list, 0)
      } else {
        message("not unique human phague pair", entity[i], humans[j])
        print(t)
      }
    }
    phague_list[entity[i]] <- list(humans_list)
  }
  
  return(phague_list)
}

merge_elements_by_prefix <- function(elements_vector, prefix) {
  titles <- names(elements_vector)
  repeated_titles <- titles[str_detect(titles, paste0(prefix, ".*"))]
  
  merged_bact <- rep(0, length(elements_vector[repeated_titles][[1]]))
  for (i in 1:length(repeated_titles)) {
    merged_bact <- merged_bact + elements_vector[repeated_titles][[i]]
  }
  
  updated_elements_vector <- elements_vector[titles[!str_detect(titles, paste0(prefix, ".*"))]]
  updated_elements_vector[[prefix]] <- merged_bact
}

calculate_correlation <- function(phages_titles, phages_vector, bacts_titles, bacts_vector) {
  correl <- expand.grid(phages = phages_titles, bacts = bacts_titles)
  correl$value <- 0
  
  for (i in 1:length(phages_vector)) {
    for (j in 1:length(bacts_vector)) {
      correl$value[correl$phages == phages_titles[i] & correl$bacts == bacts_titles[j]] <- 
        cor.test(unlist(phages_vector[i]), unlist(bacts_vector[j]))$statistic
    }
  }
}