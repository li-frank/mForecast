library('forecast')

#STLF: mobileAgg df: mobile.Date
mobile.ts <- ts(mobile.Date$gmb, frequency=52*7, start=c(2010,1))
plot_mobile.ts <- plot.ts(mobile.ts)

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

#########################################
arima_mobile <- auto.arima(mobile.ts,seasonal=TRUE)
plot(forecast(arima_mobile))
arima_mobile.ts <- ts(arima_mobile, frequency=364,start=c(2010,1,1))
accuracy(arima_mobile)
#########################################

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
  mobile_cv.train <- ts(mobile.ts[(364*(i-1)+1):(364*(i+1)+1)],frequency=364)
  mobile_cv.test <- ts(mobile.ts[(364*(i-1)+1):(364*(i+1)+1)],frequency=364)
  
  stlf_mobile_BC.cv <- stlf(mobile_cv.ts,lambda=BoxCox.lambda(mobile_cv.ts))
  stlf_mobile.ts_BC_rb.cv <- stlf(mobile_cv.ts,lambda=BoxCox.lambda(mobile_cv.ts),robust=TRUE)
  arima_mobile.cv <- auto.arima(mobile_cv.ts,seasonal=TRUE)
  stlf_mobile.cv <- stlf(mobile_cv.ts)
  
  stlf_mobile.cv.a <- accuracy(stlf_mobile.cv,)
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