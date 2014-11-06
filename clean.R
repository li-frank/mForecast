#create DFs for mobile, mobileAgg, PC

#gmb over time
##old: sumDate <- ddply(df,.(created_dt),summarize,gmb=sum(gmb_plan))
df.gbDate <- group_by(df,created_dt)
df.Date <- summarise(df.gbDate,gmb=sum(gmb_plan)); head(df.Date)
#filter for last 2 years
df.Date_2yr <- df.Date[df.Date$created_dt>=max(df.Date$created_dt) - (366*2+2),]; df.Date_2yr

#mobile gmb by platform over time
mobile <- df[df$platform != 'Core Site on PC',]
mobile.gbDatePlat <- group_by(mobile[mobile$created_dt>=max(mobile$created_dt)-366,],created_dt, platform)
mobile.DatePlat <- summarise(mobile.gbDatePlat,gmb=sum(gmb_plan)); head(mobile.DatePlat)

#mobile aggregate
byDate <- group_by(mobile[mobile$created_dt>=max(mobile$created_dt)-366,],created_dt, platform)
sumDatePlat <- summarise(byDatePlat,gmb=sum(gmb_plan)); head(sumDatePlat)
plot_platGMB <- ggplot(sumDatePlat,
                       aes(x=created_dt,y=gmb, color=platform)) + geom_line(); plot_platGMB




PC <- df[df$platform == 'Core Site on PC',]
byDatePlat <- group_by(PC[PC$created_dt>=max(PC$created_dt)-366,],created_dt)
sumDatePC <- summarise(byDatePlat,gmb=sum(gmb_plan)); head(sumDatePlat)
plot_platGMB <- ggplot(sumDatePlat,
                       aes(x=created_dt,y=gmb, color=platform)) + geom_line(); plot_platGMB
#create by platforms within mobile


byDate <- group_by(df,created_dt)
iphoneGMB <- summarise(byDate,gmb=sum(gmb_plan)); head(sumDate)

#time series
Creating a time series
The ts() function will convert a numeric vector into an R time series object. The format is ts(vector, start=, end=, frequency=) where start and end are the times of the first and last observation and frequency is the number of observations per unit time (1=annual, 4=quartly, 12=monthly, etc.).
# save a numeric vector containing 48 monthly observations
# from Jan 2009 to Dec 2014 as a time series object
myts <- ts(myvector, start=c(2009, 1), end=c(2014, 12), frequency=12) 

# subset the time series (June 2014 to December 2014)
myts2 <- window(myts, start=c(2014, 6), end=c(2014, 12)) 

# plot series
plot(myts)