#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#Data Import and Cleaning
raw_df <- read.csv("~/Desktop/psy8712-week3/data/week3.csv")
raw_df$timeStart <- as.POSIXct(raw_df$timeStart)
raw_df$timeEnd <- as.POSIXct(raw_df$timeEnd)
clean_df <- subset(raw_df, raw_df$timeStart > "2017-06-30 23:59:59")
clean_df <- subset(clean_df, clean_df$q6 == 1)

#Analysis
clean_df$timeSpent <- difftime(clean_df$timeStart, clean_df$timeEnd, units="secs")
hist(as.numeric(clean_df$timeSpent))
frequency_tables_list <- lapply(clean_df[,5:14],table)
lapply(frequency_tables_list,barplot)
print(sum((clean_df$q1>=clean_df$q2) & (clean_df$q2 != clean_df$q3)))
for(f in frequency_tables_list){
  print(barplot(f))
}