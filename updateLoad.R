library(plyr); library(dplyr)

#pull existing table for base
source("load.R")
head(df)
minDate
maxDate
days

#remove, reload
daysReload <- 31
reloadStart <- maxDate-31; reloadStart
reloadStart <- paste0("'", reloadStart ,"'"); reloadStart
reloadEnd <- Sys.Date()-2; reloadEnd
reloadEnd <- paste0("'", reloadEnd ,"'"); reloadEnd

##remove
removePath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Forecast/ForecastModel/mForecast/SQL/dly_mGMB_s1_remove.sql'
removeQuery <- paste(readLines(removePath), collapse=" ")
removeQuery <- gsub(':start_dt',reloadStart,removeQuery); removeQuery
removed <- dbSendQuery(c,removeQuery)
##reload
reloadPath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Forecast/ForecastModel/mForecast/SQL/dly_mGMB_s1_reload.sql'
reloadQuery <- paste(readLines(reloadPath), collapse=" ")
reloadQuery <- gsub(':start_dt',reloadStart,reloadQuery)
reloadQuery <- gsub(':end_dt',reloadEnd,reloadQuery); reloadQuery
reloaded <- dbSendQuery(c,reloadQuery)

#pull new data
source("load.R")
head(df,20)
minDate
maxDate
days