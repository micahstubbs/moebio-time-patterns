library(plyr)

# Set the working directory
setwd("~/workspace/d3-project-folder/moebio-time-patterns")

# read in the two csv files we would like to work with
quandl_dmdrn_data <- read.csv(file="data.csv",head=TRUE,sep=",")
sp500_companies <- read.csv(file="SP500_Companies.csv", head=TRUE,sep=",")

# make a new dataframe from the quandl data
vis_data <- quandl_dmdrn_data

# rename columns to d3js friendly formats
colnames(vis_data)[c(1,2,3)] <- c("financialsDate", "effectiveTaxRate",
                                  "earningsBeforeInterestAndTaxes") 

# add the year from financialsDate as a new column
# with the year formatted as a number
vis_data$financialsYear <- as.numeric(substr(vis_data$financialsDate,1,4))

# create a new list full empty 'NA' values that is the length of our
# vis_data dataframe's row count
company <- rep(NA, nrow(vis_data))

# create a new dataframe called vis_data by combining the company list we just created
# with existing dataframe called vis_data
vis_data <- data.frame(vis_data, company)

# fill the company column of our vis_data dataframe with the matching values from 
# the sp500_companies dataframe using the common symbol column to link the two 
# dataframes
vis_data$company <- sp500_companies$ShortName[match(vis_data$symbol, sp500_companies$Symbol)]

# use the same lookup process to get append the Sector column from the sp500_companies 
# dataframe to the vis_data dataframe
sector <- rep(NA, nrow(vis_data))
vis_data <- data.frame(vis_data, sector)
vis_data$sector <- sp500_companies$Sector[match(vis_data$symbol, sp500_companies$Symbol)]

# export the vis_data dataframe as a csv file we can visualize with d3js
write.csv(vis_data, file="vis_data.csv", row.names=FALSE)
