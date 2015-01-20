##remove
removePath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Forecast/ForecastModel/mForecast/SQL/dly_mGMB_remove.sql'
removeQuery <- paste(readLines(removePath), collapse=" ")
removeQuery <- gsub(':start_dt',reloadStart,removeQuery); removeQuery
removeQuery <- gsub(':table',actualTable,removeQuery); removeQuery
removed <- dbSendQuery(c,removeQuery)