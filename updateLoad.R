library('dplyr')

#pull existing table for base
source("load.R")
head(df)
minDate
maxDate
days

#remove, reload
daysReload <- 31
reloadStart <- maxDate-31; reloadStart
reloadStart <- paste0("'", reloadStart ,"'"); reloadStart
reloadEnd <- Sys.Date()-2; reloadEnd
reloadEnd <- paste0("'", reloadEnd ,"'"); reloadEnd

##remove
removePath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Forecast/ForecastModel/mForecast/SQL/dly_mGMB_s1_remove.sql'
removeQuery <- paste(readLines(removePath), collapse=" ")
removeQuery <- gsub(':start_dt',reloadStart,removeQuery); removeQuery
removed <- dbSendQuery(c,removeQuery)
##reload
reloadPath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Forecast/ForecastModel/mForecast/SQL/dly_mGMB_s1_reload.sql'
reloadQuery <- paste(readLines(reloadPath), collapse=" ")
reloadQuery <- gsub(':start_dt',reloadStart,reloadQuery)
reloadQuery <- gsub(':end_dt',reloadEnd,reloadQuery); reloadQuery
reloaded <- dbSendQuery(c,reloadQuery)

#pull new data
source("load.R")
head(df,20)
minDate
maxDate
days

#check last 365 days
#sumDate <- ddply(df,.(created_dt),summarize,gmb=sum(gmb_plan))
byDate <- group_by(df,created_dt)
sumDate <- summarise(byDate,gmb=sum(gmb_plan)); head(sumDate)
plot_sumDate <- ggplot(sumDate,
                           aes(x=created_dt,y=gmb, color=format(created_dt,"%Y"))) + geom_line(); plot_sumDate

#filter for last 2 years
sumDate_2yr <- sumDate[sumDate$created_dt>=max(sumDate$created_dt) - (366*2+2),]; sumDate_2yr
#sumDate <- filter(sumDate, format(created_dt,"%Y") >= max(sumDate$created_dt) - 368); sumDate

Year <- format(sumDate_2yr$created_dt,"%Y")
monthDate <- format(sumDate_2yr$created_dt,"%m-%d")

plot_sumDate_2yr <- ggplot(sumDate_2yr,
                         aes(x=monthDate,y=gmb, color=Year)) + geom_line(aes(group=Year)); plot_sumDate_2yr
