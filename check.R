#check last 365 days
#sumDate <- ddply(df,.(created_dt),summarize,gmb=sum(gmb_plan))
byDate <- group_by(df,created_dt)
sumDate <- summarise(byDate,gmb=sum(gmb_plan)); head(sumDate)
plot_sumDate <- ggplot(sumDate,
                       aes(x=created_dt,y=gmb, color=format(created_dt,"%Y"))) + geom_line(); plot_sumDate

#see GMB by platform over time for last year
mobile <- df[df$platform != 'Core Site on PC',]
byDatePlat <- group_by(mobile[mobile$created_dt>=max(mobile$created_dt)-366,],created_dt, platform)
sumDatePlat <- summarise(byDatePlat,gmb=sum(gmb_plan)); head(sumDatePlat)
plot_platGMB <- ggplot(sumDatePlat,
                       aes(x=created_dt,y=gmb, color=platform)) + geom_line(); plot_platGMB

#filter for last 2 years
sumDate_2yr <- sumDate[sumDate$created_dt>=max(sumDate$created_dt) - (366*2+2),]; sumDate_2yr
#sumDate <- filter(sumDate, format(created_dt,"%Y") >= max(sumDate$created_dt) - 368); sumDate

Year <- format(sumDate_2yr$created_dt,"%Y")
monthDate <- format(sumDate_2yr$created_dt,"%m-%d")

plot_sumDate_2yr <- ggplot(sumDate_2yr,
                           aes(x=monthDate,y=gmb, color=Year)) + geom_line(aes(group=Year)); plot_sumDate_2yr
