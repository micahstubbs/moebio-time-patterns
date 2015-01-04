require(Quandl)

symbolList <- c("AMZN","GOOG", "MSFT", "AAPL", "GLW", "HAL")

data <- data.frame("Date" = c(),
                   "Effective Tax Rate" = c(),
                   "Earnings Before Interest and Taxes" = c(),
                   "symbol" = c())

for(symbol in symbolList){
  effectiveTaxRate = Quandl(paste0("DMDRN/", symbol, "_EFF_TAX"), trim_start="2003-01-01", trim_end="2014-12-31")
  EBIT = Quandl(paste0("DMDRN/", symbol, "_EBIT"), trim_start="2003-01-01", trim_end="2014-12-31")
  tmp_data <- merge(effectiveTaxRate,EBIT,by=c("Date"))
  tmp_data$symbol <- symbol
  data <- rbind(data, tmp_data)
  bp <- barplot(tail(table(data$symbol), 50), xaxt="n")
  labs <- names(table(data$symbol))
  text(x=bp, y=-1.25, labels=labs, xpd=TRUE, srt=0)
}