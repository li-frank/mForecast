library('ebaytd')
c <- teradataConnect()

#setup query & table
sqlTable <- 'p_csi_tbs_t.fl_dly_mGMBforecast_s1'
sqlQuery <- 'select * from :table'
sqlQuery <- gsub(':table',sqlTable,sqlQuery); sqlQuery

#load data
df <- dbGetQuery(c,sqlQuery)
df.bk <- df

#check
df$created_dt <- as.Date(df$created_dt)
minDate <- min(df$created_dt); minDate
maxDate <- max(df$created_dt); maxDate
days <- as.numeric(maxDate - minDate + 1); days


#incomplete- load query directly from github
#library(RCurl)
#wklyGMBurl <- 'https://github.com/li-frank/mForecast/blob/master/wkly_mGMB.sql'
#test <- getURL(wklyGMBur)



##autorefresh numbers

