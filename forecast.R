library('forecast')

#########################################
mobile.ts <- ts(mobile.Date$gmb, frequency=52*7, start=c(2010,1))
plot_mobile.ts <- plot.ts(mobile.ts)

#mobile agg forecast
arima_mobile <- auto.arima(mobile.ts,seasonal=TRUE,stepwise=FALSE,approx=FALSE)
plot(forecast(arima_mobile))
arima_mobile.ts <- ts(arima_mobile, frequency=364,start=c(2010,1,1))
accuracy(arima_mobile)

#by platform and country
##dataset: mobile.cntryPlat
unique(mobile.cntryPlat$country)
unique(mobile.cntryPlat$platform)

test <- subset(mobile, created_dt >= 2012-11-01 
               & (country=='US'|country=='AU')
               & (platform=='iPhone App'))

test.gb <- group_by(test,created_dt,country, platform)

testarima <- summarise(test.gb, gmb=auto.arima(test.gb$gmb_plan))
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