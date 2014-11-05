#load data
SQltable <- 'p_csi_tbs_t.fl_mGMBforecast_v1'

c <- teradataConnect()
sqlPath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Rproj/appVersGMB/GMB_appVers_Date.sql'

sqlQuery <- paste(readLines(sqlPath), collapse=" ")
df <- dbGetQuery(c,sqlQuery)
df2 <- df
##autorefresh numbers