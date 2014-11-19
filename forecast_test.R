library('forecast')
library('parallel')
###############################################
#bootstrap
year <- as.integer(format(minDate.lim,"%Y"))
dayofYear <- as.integer(format(minDate.lim,"%j"))

mobile.ts <- ts(mobile.Date$gmb, frequency=52*7, start=c(year,dayofYear))
arima_mobile <- auto.arima(mobile.ts,seasonal=TRUE)

#data.frame(forecast(arima_mobile, h=4))

au <- ts(mobile.DateCntry[mobile.DateCntry$country=='AU',]$gmb,frequency=364,start=c(year,dayofYear))
de <- ts(mobile.DateCntry[mobile.DateCntry$country=='DE',]$gmb,frequency=364,start=c(year,dayofYear))
uk <- ts(mobile.DateCntry[mobile.DateCntry$country=='UK',]$gmb,frequency=364,start=c(year,dayofYear))
us <- ts(mobile.DateCntry[mobile.DateCntry$country=='US',]$gmb,frequency=364,start=c(year,dayofYear))
ca <- ts(mobile.DateCntry[mobile.DateCntry$country=='CA',]$gmb,frequency=364,start=c(year,dayofYear))
otherCntry <- ts(mobile.DateCntry[mobile.DateCntry$country=='Other',]$gmb,frequency=364,start=c(year,dayofYear))

iphone <- ts(mobile.DatePlat[mobile.DatePlat$platform=='iPhone App',]$gmb,frequency=364,start=c(year,dayofYear))
ipad <- ts(mobile.DatePlat[mobile.DatePlat$platform=='iPad App',]$gmb,frequency=364,start=c(year,dayofYear))
android <- ts(mobile.DatePlat[mobile.DatePlat$platform=='AndroidApp',]$gmb,frequency=364,start=c(year,dayofYear))
mweb <- ts(mobile.DatePlat[mobile.DatePlat$platform=='Mobile Web',]$gmb,frequency=364,start=c(year,dayofYear))
fsom <- ts(mobile.DatePlat[mobile.DatePlat$platform=='FSoM',]$gmb,frequency=364,start=c(year,dayofYear))
otherMob <- ts(mobile.DatePlat[mobile.DatePlat$platform=='Other Mobile',]$gmb,frequency=364,start=c(year,dayofYear))

au.arima <- auto.arima(au, seasonal=TRUE)
de.arima <- auto.arima(de, seasonal=TRUE)
uk.arima <- auto.arima(uk, seasonal=TRUE)
us.arima <- auto.arima(us, seasonal=TRUE)
ca.arima <- auto.arima(ca, seasonal=TRUE)
otherCntry.arima <- auto.arima(otherCntry, seasonal=TRUE)

iphone.arima <- auto.arima(iphone, seasonal=TRUE)
ipad.arima <- auto.arima(ipad, seasonal=TRUE)
android.arima <- auto.arima(android, seasonal=TRUE)
mweb.arima <- auto.arima(mweb, seasonal=TRUE)
fsom.arima <- auto.arima(fsom, seasonal=TRUE)
otherMob.arima <- auto.arima(otherMob, seasonal=TRUE)

###############################################


test <- do(mobile.cntryPlat, auto.arima(mobile.cntryPlat$gmb))

mobile.ts <- ts(mobile.Date$gmb, frequency=52*7, start=minDate.lim)


#########################################
mobile.ts <- ts(mobile.Date$gmb, frequency=52*7, start=c(2010,1,1))
plot_mobile.ts <- plot.ts(mobile.ts)

#mobile agg forecast
arima_mobile <- auto.arima(mobile.ts,seasonal=TRUE)
plot(forecast(arima_mobile))
arima_mobile.ts <- ts(arima_mobile, frequency=364,start=c(2010,1,1))
accuracy(arima_mobile)

#by platform and country
##dataset: mobile.cntryPlat
test.ts <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='AU' & mobile.cntryPlat$platform=='iPhone App',4],frequency=364,start=c(2010,1,1))

au.iphone <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='AU' & mobile.cntryPlat$platform=='iPhone App',]$gmb,frequency=364,start=c(2010,1,1))
au.fsom <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='AU' & mobile.cntryPlat$platform=='FSoM',]$gmb,frequency=364,start=c(2010,1,1))
au.and <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='AU' & mobile.cntryPlat$platform=='AndroidApp',]$gmb,frequency=364,start=c(2010,1,1))
au.ipad <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='AU' & mobile.cntryPlat$platform=='iPad App',]$gmb,frequency=364,start=c(2010,1,1))
au.mweb <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='AU' & mobile.cntryPlat$platform=='Mobile Web',]$gmb,frequency=364,start=c(2010,1,1))
au.other <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='AU' & mobile.cntryPlat$platform=='Other Mobile',]$gmb,frequency=364,start=c(2010,1,1))

au.iphone_arima <- auto.arima(au.iphone, seasonal=TRUE)
au.fsom_arima <- auto.arima(au.fsom, seasonal=TRUE)
au.and_arima <- auto.arima(au.and, seasonal=TRUE)
au.ipad_arima <- auto.arima(au.ipad, seasonal=TRUE)
au.mweb_arima <- auto.arima(au.mweb, seasonal=TRUE)
au.other_arima <- auto.arima(au.other, seasonal=TRUE)

ca.iphone <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='CA' & mobile.cntryPlat$platform=='iPhone App',]$gmb,frequency=364,start=c(2010,1,1))
ca.fsom <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='CA' & mobile.cntryPlat$platform=='FSoM',]$gmb,frequency=364,start=c(2010,1,1))
ca.and <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='CA' & mobile.cntryPlat$platform=='AndroidApp',]$gmb,frequency=364,start=c(2010,1,1))
ca.ipad <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='CA' & mobile.cntryPlat$platform=='iPad App',]$gmb,frequency=364,start=c(2010,1,1))
ca.mweb <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='CA' & mobile.cntryPlat$platform=='Mobile Web',]$gmb,frequency=364,start=c(2010,1,1))
ca.other <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='CA' & mobile.cntryPlat$platform=='Other Mobile',]$gmb,frequency=364,start=c(2010,1,1))

ca.iphone_arima <- auto.arima(ca.iphone, seasonal=TRUE)
ca.fsom_arima <- auto.arima(ca.fsom, seasonal=TRUE)
ca.and_arima <- auto.arima(ca.and, seasonal=TRUE)
ca.ipad_arima <- auto.arima(ca.ipad, seasonal=TRUE)
ca.mweb_arima <- auto.arima(ca.mweb, seasonal=TRUE)
ca.other_arima <- auto.arima(ca.other, seasonal=TRUE)

us.iphone <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='US' & mobile.cntryPlat$platform=='iPhone App',]$gmb,frequency=364,start=c(2010,1,1))
us.fsom <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='US' & mobile.cntryPlat$platform=='FSoM',]$gmb,frequency=364,start=c(2010,1,1))
us.and <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='US' & mobile.cntryPlat$platform=='AndroidApp',]$gmb,frequency=364,start=c(2010,1,1))
us.ipad <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='US' & mobile.cntryPlat$platform=='iPad App',]$gmb,frequency=364,start=c(2010,1,1))
us.mweb <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='US' & mobile.cntryPlat$platform=='Mobile Web',]$gmb,frequency=364,start=c(2010,1,1))
us.other <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='US' & mobile.cntryPlat$platform=='Other Mobile',]$gmb,frequency=364,start=c(2010,1,1))

us.iphone_arima <- auto.arima(us.iphone, seasonal=TRUE)
us.fsom_arima <- auto.arima(us.fsom, seasonal=TRUE)
us.and_arima <- auto.arima(us.and, seasonal=TRUE)
us.ipad_arima <- auto.arima(us.ipad, seasonal=TRUE)
us.mweb_arima <- auto.arima(us.mweb, seasonal=TRUE)
us.other_arima <- auto.arima(us.other, seasonal=TRUE)

de.iphone <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='DE' & mobile.cntryPlat$platform=='iPhone App',]$gmb,frequency=364,start=c(2010,1,1))
de.fsom <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='DE' & mobile.cntryPlat$platform=='FSoM',]$gmb,frequency=364,start=c(2010,1,1))
de.and <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='DE' & mobile.cntryPlat$platform=='AndroidApp',]$gmb,frequency=364,start=c(2010,1,1))
de.ipad <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='DE' & mobile.cntryPlat$platform=='iPad App',]$gmb,frequency=364,start=c(2010,1,1))
de.mweb <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='DE' & mobile.cntryPlat$platform=='Mobile Web',]$gmb,frequency=364,start=c(2010,1,1))
de.other <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='DE' & mobile.cntryPlat$platform=='Other Mobile',]$gmb,frequency=364,start=c(2010,1,1))

de.iphone_arima <- auto.arima(de.iphone, seasonal=TRUE)
de.fsom_arima <- auto.arima(de.fsom, seasonal=TRUE)
de.and_arima <- auto.arima(de.and, seasonal=TRUE)
de.ipad_arima <- auto.arima(de.ipad, seasonal=TRUE)
de.mweb_arima <- auto.arima(de.mweb, seasonal=TRUE)
de.other_arima <- auto.arima(de.other, seasonal=TRUE)

other.iphone <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='Other Mobile' & mobile.cntryPlat$platform=='iPhone App',]$gmb,frequency=364,start=c(2010,1,1))
other.fsom <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='Other Mobile' & mobile.cntryPlat$platform=='FSoM',]$gmb,frequency=364,start=c(2010,1,1))
other.and <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='Other Mobile' & mobile.cntryPlat$platform=='AndroidApp',]$gmb,frequency=364,start=c(2010,1,1))
other.ipad <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='Other Mobile' & mobile.cntryPlat$platform=='iPad App',]$gmb,frequency=364,start=c(2010,1,1))
other.mweb <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='Other Mobile' & mobile.cntryPlat$platform=='Mobile Web',]$gmb,frequency=364,start=c(2010,1,1))
other.other <- ts(mobile.cntryPlat[mobile.cntryPlat$country=='Other Mobile' & mobile.cntryPlat$platform=='Other Mobile',]$gmb,frequency=364,start=c(2010,1,1))

other.iphone_arima <- auto.arima(other.iphone, seasonal=TRUE)
other.fsom_arima <- auto.arima(other.fsom, seasonal=TRUE)
other.and_arima <- auto.arima(other.and, seasonal=TRUE)
other.ipad_arima <- auto.arima(other.ipad, seasonal=TRUE)
other.mweb_arima <- auto.arima(other.mweb, seasonal=TRUE)
other.other_arima <- auto.arima(other.other, seasonal=TRUE)

test.arima <- do(auto.arima(ts(test$gmb,frequency=364,start=c(2010,1,1))))
arima.slice <- function(x){
  group_by()
}
#######################################
unique(mobile.cntryPlat$country)
unique(mobile.cntryPlat$platform)

test <- subset(mobile.cntryPlat, created_dt >= 2012-11-01 
               & (country=='US'|country=='AU')
               & (platform=='iPhone App'))
test_AU <- subset(test,country=='AU')
test_AU.ts <- ts(test_AU$gmb, frequency=52*7, start=c(2010,1,1))
test_AU.arima <- auto.arima(test_AU.ts,seasonal=TRUE)

test.gb <- group_by(test,created_dt,country, platform)

test_AU.gb <- group_by(test_AU,created_dt)

testarima <- summarise(test.gb, gmb=auto.arima(gmb_plan))
#########################################
au.fsom <- subset(mobile.cntryPlat, country=='AU' & platform=='FSoM',select=c(gmb))
au.and <- subset(mobile.cntryPlat, country=='AU' & platform=='AndroidApp',select=c(gmb))
au.ipad <- subset(mobile.cntryPlat, country=='AU' & platform=='iPad App',select=c(gmb))
au.iphone <- subset(mobile.cntryPlat, country=='AU' & platform=='iPhone App',select=c(gmb))
au.mweb <- subset(mobile.cntryPlat, country=='AU' & platform=='Mobile Web',select=c(gmb))
au.other <- subset(mobile.cntryPlat, country=='AU' & platform=='Other Mobile',select=c(gmb))

ca.fsom <- subset(mobile.cntryPlat, country=='CA' & platform=='FSoM',select=c(gmb))
ca.and <- subset(mobile.cntryPlat, country=='CA' & platform=='AndroidApp',select=c(gmb))
ca.ipad <- subset(mobile.cntryPlat, country=='CA' & platform=='iPad App',select=c(gmb))
ca.iphone <- subset(mobile.cntryPlat, country=='CA' & platform=='iPhone App',select=c(gmb))
ca.mweb <- subset(mobile.cntryPlat, country=='CA' & platform=='Mobile Web',select=c(gmb))
ca.other <- subset(mobile.cntryPlat, country=='CA' & platform=='Other Mobile',select=c(gmb))

us.fsom <- subset(mobile.cntryPlat, country=='US' & platform=='FSoM',select=c(gmb))
us.and <- subset(mobile.cntryPlat, country=='US' & platform=='AndroidApp',select=c(gmb))
us.ipad <- subset(mobile.cntryPlat, country=='US' & platform=='iPad App',select=c(gmb))
us.iphone <- subset(mobile.cntryPlat, country=='US' & platform=='iPhone App',select=c(gmb))
us.mweb <- subset(mobile.cntryPlat, country=='US' & platform=='Mobile Web',select=c(gmb))
us.other <- subset(mobile.cntryPlat, country=='US' & platform=='Other Mobile',select=c(gmb))

de.fsom <- subset(mobile.cntryPlat, country=='DE' & platform=='FSoM',select=c(gmb))
de.and <- subset(mobile.cntryPlat, country=='DE' & platform=='AndroidApp',select=c(gmb))
de.ipad <- subset(mobile.cntryPlat, country=='DE' & platform=='iPad App',select=c(gmb))
de.iphone <- subset(mobile.cntryPlat, country=='DE' & platform=='iPhone App',select=c(gmb))
de.mweb <- subset(mobile.cntryPlat, country=='DE' & platform=='Mobile Web',select=c(gmb))
de.other <- subset(mobile.cntryPlat, country=='DE' & platform=='Other Mobile',select=c(gmb))

uk.fsom <- subset(mobile.cntryPlat, country=='UK' & platform=='FSoM',select=c(gmb))
uk.and <- subset(mobile.cntryPlat, country=='UK' & platform=='AndroidApp',select=c(gmb))
uk.ipad <- subset(mobile.cntryPlat, country=='UK' & platform=='iPad App',select=c(gmb))
uk.iphone <- subset(mobile.cntryPlat, country=='UK' & platform=='iPhone App',select=c(gmb))
uk.mweb <- subset(mobile.cntryPlat, country=='UK' & platform=='Mobile Web',select=c(gmb))
uk.other <- subset(mobile.cntryPlat, country=='UK' & platform=='Other Mobile',select=c(gmb))

other.fsom <- subset(mobile.cntryPlat, country=='Other' & platform=='FSoM',select=c(gmb))
other.and <- subset(mobile.cntryPlat, country=='Other' & platform=='AndroidApp',select=c(gmb))
other.ipad <- subset(mobile.cntryPlat, country=='Other' & platform=='iPad App',select=c(gmb))
other.iphone <- subset(mobile.cntryPlat, country=='Other' & platform=='iPhone App',select=c(gmb))
other.mweb <- subset(mobile.cntryPlat, country=='Other' & platform=='Mobile Web',select=c(gmb))
other.other <- subset(mobile.cntryPlat, country=='Other' & platform=='Other Mobile',select=c(gmb))

au.fsom <- auto.arima(au.fsom,seasonal=TRUE)
au.and <- auto.arima(au.and,seasonal=TRUE)
au.ipad <- auto.arima(au.ipad,seasonal=TRUE)
au.iphone <- auto.arima(au.iphone,seasonal=TRUE)
au.mweb <- auto.arima(au.mweb,seasonal=TRUE)
au.other <- auto.arima(au.other,seasonal=TRUE)

ca.fsom <- auto.arima(ca.fsom,seasonal=TRUE)
ca.and <- auto.arima(ca.and,seasonal=TRUE)
ca.ipad <- auto.arima(ca.ipad,seasonal=TRUE)
ca.iphone <- auto.arima(ca.iphone,seasonal=TRUE)
ca.mweb <- auto.arima(ca.mweb,seasonal=TRUE)
ca.other <- auto.arima(ca.other,seasonal=TRUE)

us.fsom <- auto.arima(us.fsom,seasonal=TRUE)
us.and <- auto.arima(us.and,seasonal=TRUE)
us.ipad <- auto.arima(us.ipad,seasonal=TRUE)
us.iphone <- auto.arima(us.iphone,seasonal=TRUE)
us.mweb <- auto.arima(us.mweb,seasonal=TRUE)
us.other <- auto.arima(us.other,seasonal=TRUE)

de.fsom <- auto.arima(de.fsom,seasonal=TRUE)
de.and <- auto.arima(de.and,seasonal=TRUE)
de.ipad <- auto.arima(de.ipad,seasonal=TRUE)
de.iphone <- auto.arima(de.iphone,seasonal=TRUE)
de.mweb <- auto.arima(de.mweb,seasonal=TRUE)
de.other <- auto.arima(de.other,seasonal=TRUE)

uk.fsom <- auto.arima(uk.fsom,seasonal=TRUE)
uk.and <- auto.arima(uk.and,seasonal=TRUE)
uk.ipad <- auto.arima(uk.ipad,seasonal=TRUE)
uk.iphone <- auto.arima(uk.iphone,seasonal=TRUE)
uk.mweb <- auto.arima(uk.mweb,seasonal=TRUE)
uk.other <- auto.arima(uk.other,seasonal=TRUE)

other.fsom <- auto.arima(other.fsom,seasonal=TRUE)
other.and <- auto.arima(other.and,seasonal=TRUE)
other.ipad <- auto.arima(other.ipad,seasonal=TRUE)
other.iphone <- auto.arima(other.iphone,seasonal=TRUE)
other.mweb <- auto.arima(other.mweb,seasonal=TRUE)
other.other <- auto.arima(other.other,seasonal=TRUE)

#########################################
#forecast models in order of increasing MAPE
stlf_mobile_BC <- stlf(mobile.ts,lambda=BoxCox.lambda(mobile.ts))
plot(stlf_mobile.ts_BC)
stlf_mobile_BC$model
accuracy(stlf_mobile_BC)

#with robust options to remove outliers
stlf_mobile.ts_BC_rb <- stlf(mobile.ts,lambda=BoxCox.lambda(mobile.ts),robust=TRUE)
plot(stlf_mobile.ts_BC_rb)
stlf_mobile.ts_BC_rb$model
accuracy(stlf_mobile.ts_BC_rb)



stlf_mobile <- stlf(mobile.ts)
plot(stlf_mobile.ts)
stlf_mobile$model
accuracy(stlf_mobile)

#breakdown
stl_mobile.ts <- stl(mobile.ts,s.window="periodic",robust=TRUE)
plot(stl_mobile.ts)

#not working
hw_mobile <- HoltWinters(mobile.ts)
plot(mobile.ts,xlim=c(2010,2018),ylim=c(0,140000000))
lines(predict(hw_mobile,n.ahead=900),col=2)

###########################################
#cross validation
##forward chain
startYear <- as.numeric(format(minDate, "%Y"))
endYear <- as.numeric(format(maxDate, "%Y"))
years <- endYear - startYear + 1

for (i in 1:years-3)){
  trainStart <- 364*(i-1)+1
  trainEnd <- start + 364*2
  testEnd <- length(mobile.ts)
  
  mobile_cv.train <- ts(mobile.ts[trainStart:trainEnd],frequency=364)
  mobile_cv.test <- ts(mobile.ts[(trainEnd+1):testEnd],frequency=364)
  
  stlf_mobile_BC.cv <- stlf(mobile_cv.train,lambda=BoxCox.lambda(mobile_cv.train))
  stlf_mobile.ts_BC_rb.cv <- stlf(mobile_cv.train,lambda=BoxCox.lambda(mobile_cv.train),robust=TRUE)
  arima_mobile.cv <- auto.arima(mobile_cv.train,seasonal=TRUE)
  stlf_mobile.cv <- stlf(mobile_cv.train)
  
  stlf_mobile_BC.cv.a <- accuracy(stlf_mobile_BC.cv,mobile_cv.test)
  stlf_mobile.ts_BC_rb.cv.a <- accuracy(stlf_mobile.ts_BC_rb.cv,mobile_cv.test)
  arima_mobile.cv.a <- accuracy(forecast(arima_mobile.cv),mobile_cv.test)
  stlf_mobile.cv.a <- accuracy(stlf_mobile.cv,mobile_cv.test)
  #  
  arima_mobile <- auto.arima(mobile.ts,seasonal=TRUE)
  plot(forecast(arima_mobile))
  accuracy(arima_mobile)  
  #
  plot(stlf_mobile.cv, ylim=c(0,120000000))
  lines(mobile_cv.test)
  
  plot(stlf_mobile.ts_BC_rb.cv,ylim=c(0,120000000))
  lines(mobile_cv.test)
  
  plot(stlf_mobile_BC.cv,ylim=c(0,120000000))
  lines(mobile_cv.test)
  
  plot(forecast(arima_mobile.cv),ylim=c(0,120000000))
  lines(mobile_cv.test)
}


##last 2 years to predict next year


# #########################################
# #MA of stlf plot
# ma365 <- rep(1/365, 365)
# y_lag <- filter(stlf_mobile.ts, ma365, sides=1)
# lines(x, y_lag, col="red")

# #########################################
# #time series
# Creating a time series
# The ts() function will convert a numeric vector into an R time series object. The format is ts(vector, start=, end=, frequency=) where start and end are the times of the first and last observation and frequency is the number of observations per unit time (1=annual, 4=quartly, 12=monthly, etc.).
# # save a numeric vector containing 48 monthly observations
# # from Jan 2009 to Dec 2014 as a time series object
# myts <- ts(myvector, start=c(2009, 1), end=c(2014, 12), frequency=12) 
# 
# # subset the time series (June 2014 to December 2014)
# myts2 <- window(myts, start=c(2014, 6), end=c(2014, 12)) 
# 
# # plot series
# plot(myts)