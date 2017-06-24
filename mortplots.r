library(dplyr)
library(data.table)
library(ggplot2)
library(ggthemes)

# read exported table into dataframe
# mort_file = 'BighornMort.txt'
# morts = read.csv(mort_file, header=TRUE, stringsAsFactors=F)
# 
# # get collared morts by looking at Animal ID
# cmorts = morts[grep("S", morts$Animal_ID, perl=T),]


# read lacy's mort summary excel:
mort_file = 'mortsummary.csv'
raw_morts = read.csv(mort_file, header=T, stringsAsFactors=F)
morts = raw_morts

# Ad-hoc data manipulations for clarity: 
# replace empty causes (censured) with "unknown"
morts[morts$Cause_Mort == "", ]$Cause_Mort = "Unknown" 
# Combine 'Unknown' and 'Unknown Poss Predation'
morts[morts$Cause_Mort == "Unknown Poss Predation" , ]$Cause_Mort = "Unknown"
# Combine Hypothermia into 'Other'
morts[morts$Cause_Mort == "Hypothermia", ]$Cause_Mort = "Other" 
# Remove 2016/17 data:
morts = morts[morts$AY != 2016, ]

# Filled bar chart 
# (each year scaled to 1)
ggplot(morts) + 
  stat_count(aes(factor(AY), fill=Cause_Mort), position = "fill",colour='black', width=0.95) +
  scale_fill_brewer(palette="Set3") +
  xlab('Year') + ylab('fraction of Morts') +
  ggtitle('Mortality Cause Composition', subtitle='(annual totals scaled to 1)') + 
  theme_bw()

# Stacked bar chart
# (each year raw values)
ggplot(morts) +
  stat_count(aes(factor(AY), fill=Cause_Mort), position = "stack",colour='black', width=0.95) +
  scale_fill_brewer(palette="Set3") + 
  xlab('Year') + ylab('# of Morts') +
  ggtitle('Mortalities') +
  theme_bw()

