#?source("load.R")

c <- teradataConnect()

#load table
sqlTable <- 'p_csi_tbs_t.fl_dly_mGMBforecast_s1'
sqlQuery <- 'select * from :table'
sqlQuery <- gsub(sqlQuery,':table',sqlTable)



#load existing data
#SQltable <- 'p_csi_tbs_t.fl_mGMBforecast_v1'
sqlPath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Forecast/ForecastModel/mForecast/dly_mGMB.sql'
sqlQuery <- paste(readLines(sqlPath), collapse=" ")
df <- dbGetQuery(c,sqlQuery)
df2 <- df

#update PET table

maxDaysLoad <- 300
minLoadDate <- '2010-01-01'
maxLoadDate <- Sys.Date()-2

PETload <- function(days,maxDate){
  
  sqlQuery <- paste(readLines(sqlPath), collapse " ")
}
