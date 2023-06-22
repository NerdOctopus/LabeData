require(tidyverse)
require(clusterCons)

files.v <- dir(pattern = ".RDS")

holder.l <- vector(mode = "list", length(files.v))
for (i in seq_along(files.v)){
  
  working.df <- readRDS(files.v[i])
  a <- which(str_detect(colnames(working.df), "_ISA_"))
  b <- working.df[, a] %>%
    colSums()
  holder.l[[i]] <- b / nrow(working.df)
  
  print(paste("file", i))
  
}

result.df <- do.call(bind_rows, holder.l) #this should be more or less the product on which all clustering will be done


file.path("C:", "LabeWork", "rds", "parsed_expanded", "binary_valued", "results")

file_name <- "results.RDS" # add file type to file name for saving

# ! make sub directory in current working directory called "binary_valued." Otherwise the following lines will not work!
fp <- file.path("C:", "LabeWork", "rds", "parsed_expanded", "binary_valued", "results", file_name) # file path for save

saveRDS(result.df, file = fp) # save one-hot file to disk

##### unique sampling GO

files.v <- dir(pattern = ".RDS")

for (i in seq_along(files.v)){
  
  working.df <- readRDS(files.v[1])
  a <- which(str_detect(colnames(working.df), "_ISA_"))
  b <- working.df[, a]
  
  sample1.df <- b[sample(1:nrow(b), 900, replace = TRUE)] #too tired to figure out this sampling right now, very close to just taking two random samples and double dipping

  
    file.path("C:", "LabeWork", "rds", "parsed_expanded", "binary_valued", "results", "binary_valued_500")
    
    file_name <- files.v[i]
    file_name_1 <- paste0(file_name, "_sample1") # add file type to file name for saving
    file_name_2 <- paste0(file_name, "_sample2")
    # ! make sub directory in current working directory called "binary_valued." Otherwise the following lines will not work!
    fp1 <- file.path("C:", "LabeWork", "rds", "parsed_expanded", "binary_valued", "results", "binary_valued_500", file_name_1) # file path for save
    fp2 <- file.path("C:", "LabeWork", "rds", "parsed_expanded", "binary_valued", "results", "binary_valued_500", file_name_2) # file path for save
    
    saveRDS(result.df, file = fp1) # save one-hot file to disk
    saveRDS(result.df, file = fp2) # save one-hot file to disk
    
}



##### other code

cm <- cluscomp(as.data.frame(result.df), clmin = 5, clmax = 1, algorithms = list("kmeans", "agnes"))


slotNames(cm)
names(cm)
cm$e1_kmeans_k10
s <- slot(cm$e2_agnes_k25, "cm")


ag.c <- cluster::agnes(result.df)
cluster::plot.agnes(ag.c)