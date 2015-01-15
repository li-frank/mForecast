library('ebaytd')
c <- teradataConnect()

#pull actuals
actualTable <- 'p_csi_tbs_t.fl_dly_mGMB_actuals'
actualQuery <- "select * from :table"
actualPull <- gsub(':table',actualTable,actualQuery); actualPull

#load data
actual0 <- dbGetQuery(c,actualPull)
actual0.bk <- actual0

#pull forecast
fcstTable <- 'p_csi_tbs_t.fl_mobileFcst'
fcstQuery <- "select * from :table where model_dt>'1900-01-01'"
fcstPull <- gsub(':table',fcstTable,fcstQuery); fcstPull
fcst0 <- dbGetQuery(c,fcstPull)
fcst0.bk <- fcst0

dbDisconnect(c)