library('forecast')
#insert new forecast into p_csi_tbs_t.fl_dly_mGMBforecast
# teradataInsert <- function(system="vivaldi", user="", password="", database="access_views", 
#                            table, df, pi = NULL, set = "MULTISET", safe = TRUE, 
#                            cleanup = FALSE)

st.year <- as.integer(format(minDate.lim,"%Y")); st.year
st.dayofYear <- as.integer(format(minDate.lim,"%j")); st.dayofYear

##################################
#mobile arima
mobile.ts <- ts(mobileAgg[,2], frequency=52*7, start=c(st.year, st.dayofYear))
system.time(mobile.arima <- auto.arima(mobile.ts, seasonal=TRUE))
system.time(mobile.fcst <- data.frame(forecast(mobile.arima)))
trans_dt <- c(maxDate)+sequence(fcstLeng)
mobile.fcst.df <- data.frame(trans_dt,"Mobile",mobile.fcst$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(mobile.fcst.df) <- c("trans_dt","slice","gmb","model_dt"); head(mobile.fcst.df)

mobile.actl <- data.frame(mobileAgg$created_dt,"Mobile",mobileAgg$gmb,"1900-01-01")
colnames(mobile.actl) <- c("trans_dt","slice","gmb","model_dt")
mobileGMB <- rbind(mobile.fcst.df,mobile.actl)
mobileGMB <- mobileGMB[with(mobileGMB, order(trans_dt)), ]
write.csv(mobileGMB,"mobileGMB.csv")

#country arima
splits <- list(mobile.DateCntry$country)
split <- split(mobile.DateCntry,splits)
cntry.ts <- lapply(split, function(x) ts(x[,3], frequency=52*7, start=c(st.year, st.dayofYear)))
system.time(cntry.arima <- lapply(cntry.ts, function(x) auto.arima(x, seasonal=TRUE)))
system.time(cntry.fcst <- lapply(cntry.arima, function(x) data.frame(forecast(x))))

#platform arima
splits <- list(mobile.DatePlat$platform)
split <- split(mobile.DatePlat,splits)
plat.ts <- lapply(split, function(x) ts(x[,3], frequency=52*7, start=c(st.year, st.dayofYear)))
system.time(plat.arima <- lapply(plat.ts, function(x) auto.arima(x, seasonal=TRUE)))
system.time(plat.fcst <- lapply(plat.arima, function(x) data.frame(forecast(x))))

#create fcst data.frame
fcstLeng <- 400
trans_dt <- c(maxDate)+sequence(fcstLeng)
##countries
au.fcst <- data.frame(trans_dt,"AU",cntry.fcst$AU$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(au.fcst) <- c("trans_dt","country","gmb","model_dt"); head(au.fcst)
ca.fcst <- data.frame(trans_dt,"CA",cntry.fcst$CA$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(ca.fcst) <- c("trans_dt","country","gmb","model_dt"); head(ca.fcst)
de.fcst <- data.frame(trans_dt,"DE",cntry.fcst$DE$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(de.fcst) <- c("trans_dt","country","gmb","model_dt"); head(de.fcst)
other.fcst <- data.frame(trans_dt,"Other",cntry.fcst$Other$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(other.fcst) <- c("trans_dt","country","gmb","model_dt"); head(other.fcst)
uk.fcst <- data.frame(trans_dt,"UK",cntry.fcst$UK$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(uk.fcst) <- c("trans_dt","country","gmb","model_dt"); head(uk.fcst)
us.fcst <- data.frame(trans_dt,"US",cntry.fcst$US$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(us.fcst) <- c("trans_dt","country","gmb","model_dt"); head(us.fcst)

#together
cntry.fcst.df <- rbind(au.fcst, ca.fcst, other.fcst, uk.fcst, us.fcst, de.fcst); head(cntry.fcst)

#w/ actuals
cntry.actl <- data.frame(mobile.DateCntry$created_dt,mobile.DateCntry$country,mobile.DateCntry$gmb,"1900-01-01")
colnames(cntry.actl) <- c("trans_dt","country","gmb","model_dt")
cntryGMB <- rbind(cntry.fcst.df,cntry.actl)
cntryGMB <- cntryGMB[with(cntryGMB, order(trans_dt)), ]
  
##platform forecast
###[1] "AndroidApp"   "FSoM"         "iPad App"     "iPhone App"   "Mobile Web"   "Other Mobile"
android.fcst <- data.frame(trans_dt,"Android",plat.fcst$AndroidApp$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(android.fcst) <- c("trans_dt","plat","gmb","model_dt"); head(android.fcst)
fsom.fcst <- data.frame(trans_dt,"FSoM",plat.fcst$FSoM$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(fsom.fcst) <- c("trans_dt","plat","gmb","model_dt"); head(fsom.fcst)
ipad.fcst <- data.frame(trans_dt,"iPad",plat.fcst$'iPad App'$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(ipad.fcst) <- c("trans_dt","plat","gmb","model_dt"); head(ipad.fcst)
iphone.fcst <- data.frame(trans_dt,"iPhone",plat.fcst$'iPhone App'$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(iphone.fcst) <- c("trans_dt","plat","gmb","model_dt"); head(iphone.fcst)
mweb.fcst <- data.frame(trans_dt,"mWeb",plat.fcst$'Mobile Web'$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(mweb.fcst) <- c("trans_dt","plat","gmb","model_dt"); head(mweb.fcst)
other.fcst <- data.frame(trans_dt,"other",plat.fcst$'Other Mobile'$Point.Forecast[1:fcstLeng],Sys.Date())
colnames(other.fcst) <- c("trans_dt","plat","gmb","model_dt"); head(other.fcst)

#together
plat.fcst.df <- rbind(android.fcst,fsom.fcst,ipad.fcst,iphone.fcst,mweb.fcst,other.fcst)
plat.actl <- data.frame(mobile.DatePlat$created_dt,mobile.DatePlat$platform,mobile.DatePlat$gmb,"1900-01-01")
colnames(plat.actl) <- c("trans_dt","plat","gmb","model_dt")
platGMB <- rbind(plat.fcst.df,plat.actl)
platGMB <- platGMB[with(platGMB, order(trans_dt)), ]
##################################


#country
splits <- list(mobile.DateCntry$country)

cntry.split <- split(mobile.DateCntry,splits)
cntry.ts <- lapply(cntry.split, function(x) ts(x[,3], frequency=52*7, start=c(st.year, st.dayofYear)))

system.time(cntry.arima <- lapply(cntry.ts, function(x) auto.arima(x, seasonal=TRUE)))
#system.time(cntry.arima2 <- sapply(cntry.ts, function(x) auto.arima(x, seasonal=TRUE)))

system.time(cntry.fcst <- lapply(cntry.arima, function(x) data.frame(forecast(x))))
write.csv(cntry.fcst,"test.csv")

#platform
splits <- list(mobile.DatePlat$platform)
plat.split <-split(mobile.DatePlat,splits)
plat.ts <- lapply(plat.split, function(x) ts(x[,3], frequency=52*7, start=c(st.year, st.dayofYear)))


##############################################################
#mobile.PlatCntry
start <- proc.time()
splits <- list(mobile.PlatCntry$country,mobile.PlatCntry$platform)
platCntry.split <- split(mobile.PlatCntry, splits)
platCntry.ts <- lapply(platCntry.split, function(x) ts(x[,4], frequency=52*7, start=c(st.year,st.dayofYear)))
proc.time()-start

system.time(platCntry.arima <- lapply(platCntry.ts, function(x) auto.arima(x,seasonal=TRUE)))
system.time(platCntry.fcst <- lapply(platCntry.arima, function(x) data.frame(forecast(x))))