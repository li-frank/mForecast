#pull existing table for base
source("load.R")
head(df,20)
minDate
maxDate
days

#remove, reload
sqlPath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Forecast/ForecastModel/mForecast/dly_mGMB_s1_remove.sql'
sqlQuery <- paste(readLines(sqlPath), collapse=" ")
sqlQuery <- gsub(':start_dt',sqlTable,sqlQuery); sqlQuery
remove <- dbGetQuery(c,sqlQuery)
df2 <- df

#update PET table

maxDaysLoad <- 300
minLoadDate <- '2010-01-01'
maxLoadDate <- Sys.Date()-2

PETload <- function(days,maxDate){
  
  sqlQuery <- paste(readLines(sqlPath), collapse " ")
}
