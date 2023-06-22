library(udpipe)
library(readtext)
library(tidyverse)


# load language model (switch to appropriate dir)
udmodel <- udpipe_load_model(file = "C:\\LabeWork\\udpipe.models.ud.2.5-master\\inst\\udpipe-ud-2.5-191206\\french-gsd-ud-2.5-191206.udpipe")

# make vector of file names (switch to appropriate dir)
setwd("C:\\LabeWork\\texts\\modernSpellings")
files.v <- dir(pattern = ".txt")

# read txt file from disk
t <- readtext(file = files.v[1])

# run language model
x <- udpipe_annotate(udmodel, t$text)

# convert to data frame
x <- as.data.frame(x, detailed = TRUE)

write.csv(x,"C:\\LabeWork\\csvs\\ScèveModernSpelling.csv", row.names = TRUE)





