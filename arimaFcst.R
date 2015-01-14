library('forecast')
#insert new forecast into p_csi_tbs_t.fl_dly_mGMBforecast
# teradataInsert <- function(system="vivaldi", user="", password="", database="access_views", 
#                            table, df, pi = NULL, set = "MULTISET", safe = TRUE, 
#                            cleanup = FALSE)

st.year <- as.integer(format(minDate.lim,"%Y")); st.year
st.dayofYear <- as.integer(format(minDate.lim,"%j")); st.dayofYear

##############################################################
#mobile.PlatCntry
start1 <- proc.time()
splits <- list(mobile.PlatCntry$country,mobile.PlatCntry$platform)
platCntry.split <- split(mobile.PlatCntry, splits)
platCntry.ts <- lapply(platCntry.split, function(x) ts(x[,4], frequency=52*7, start=c(st.year,st.dayofYear)))
proc.time()-start1

#start1 <- proc.time()
#system.time(platCntry.arima <- lapply(platCntry.ts, function(x) auto.arima(x,seasonal=TRUE,D=1)))
#system.time(platCntry.fcst <- lapply(platCntry.arima, function(x) data.frame(forecast(x))))
#proc.time()-start1

######
start1 <- proc.time()
fcstLeng <- 400
trans_dt <- c(maxDate)+sequence(fcstLeng)
cntrys <- unique(mobile.PlatCntry$country) 
pltfrms <- unique(mobile.PlatCntry$platform)

fcst <- NULL
actual <- NULL
combined <- NULL

for (i in cntrys){
  for (j in pltfrms){
   # fcst <- data.frame(trans_dt,
    #                   i,j,
     #                  platCntry.fcst[[paste0(i,".",j)]]$Point.Forecast[1:fcstLeng],
      #                 Sys.Date())
    #colnames(fcst) <- c("trans_dt","country","platform","gmb","model_dt")
    actual <- data.frame(subset(mobile.PlatCntry, (country==i) & (platform==j))$created_dt,
                         i,j,
                         subset(mobile.PlatCntry, (country==i) & (platform==j))$gmb,
                         "1900-01-01")
    colnames(actual) <- c("trans_dt","country","platform","gmb","model_dt")
    combined <-  rbind(fcst,actual,combined)
  }
}
proc.time()-start1