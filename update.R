#pull existing table for base
source("load.R")

c <- teradataConnect()
head(actual0)

#check
actual0$trans_dt <- as.Date(actual0$trans_dt)
minDate <- min(actual0$trans_dt); minDate
maxDate <- max(actual0$trans_dt); maxDate
days <- as.numeric(maxDate - minDate + 1); days

#remove, reload
daysReload <- 31
reloadStart <- maxDate-31; reloadStart
reloadStart <- paste0("'", reloadStart ,"'"); reloadStart
reloadEnd <- Sys.Date()-2; reloadEnd
reloadEnd <- paste0("'", reloadEnd ,"'"); reloadEnd

##remove
removePath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Forecast/ForecastModel/mForecast/SQL/dly_mGMB_remove.sql'
removeQuery <- paste(readLines(removePath), collapse=" ")
removeQuery <- gsub(':start_dt',reloadStart,removeQuery); removeQuery
removeQuery <- gsub(':table',actualTable,removeQuery); removeQuery
removed <- dbSendQuery(c,removeQuery)

##reload
reloadPath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Forecast/ForecastModel/mForecast/SQL/dly_mGMB_reload.sql'
reloadQuery <- paste(readLines(reloadPath), collapse=" ")
reloadQuery <- gsub(':start_dt',reloadStart,reloadQuery)
reloadQuery <- gsub(':end_dt',reloadEnd,reloadQuery); reloadQuery
reloadQuery <- gsub(':table',actualTable,reloadQuery); reloadQuery
actual1 <- dbSendQuery(c,reloadQuery)

dbDisconnect(c)