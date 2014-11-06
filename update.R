#pull existing table for base
source("load.R")
head(df,20)

#load existing data
#SQltable <- 'p_csi_tbs_t.fl_mGMBforecast_v1'
sqlPath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Forecast/ForecastModel/mForecast/dly_mGMB_s1.sql'
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
