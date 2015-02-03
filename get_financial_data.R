require(Quandl)

# a nice guide to storing API keys as R environment variables
# http://stat545-ubc.github.io/bit003_api-key-env-var.html
#
auth_token <- Sys.getenv("QUANDL_AUTH_TOKEN") 
Quandl.auth(auth_token)  

# Set the working directory
setwd("~/workspace/d3-projects/moebio-time-patterns")

SP500 <- read.csv(file="SP500_Companies.csv", head=TRUE, sep=",")
symbolList <- SP500$Symbol

# some crude error handling by removing problem symbols from the list
problem_symbols <- c("BRKB", "CTXS", "JOY", "NWSA", "NU", "PSX", "TRIP")
symbolList <- symbolList[!(symbolList %in% problem_symbols)]

data <- data.frame("Date" = c(),
                   "Effective Tax Rate" = c(),
                   "Earnings Before Interest and Taxes" = c(),
                   "symbol" = c())

# Query Quandl for the latest data
for(symbol in symbolList){
    
    Sys.sleep(2)
    effectiveTaxRate = try(Quandl(paste0("DMDRN/", symbol, "_EFF_TAX")), silent = FALSE)
    Sys.sleep(2)
    EBIT = try(Quandl(paste0("DMDRN/", symbol, "_EBIT")), silent = FALSE)
    tmp_data <- merge(effectiveTaxRate, EBIT, by = "Date")
    tmp_data$symbol <- symbol
    data <- rbind(data, tmp_data)
    
    #plot the results of the API call as they are returned
    #this shows the count of rows per symbol, where each row is a year
    barplot(tail(table(data$symbol), 50))
}

# Write CSV in R
write.csv(data, file = "data.csv", row.names = FALSE, na = "")

