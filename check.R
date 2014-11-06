#gmb over time
##old: sumDate <- ddply(df,.(created_dt),summarize,gmb=sum(gmb_plan))
df.gbDate <- group_by(df,created_dt)
df.Date <- summarise(df.gbDate,gmb=sum(gmb_plan)); head(df.Date)


#mobile gmb by platform over time
mobile <- df[df$platform != 'Core Site on PC',]
mobile.gbDatePlat <- group_by(mobile[mobile$created_dt>=max(mobile$created_dt)-366,],created_dt, platform)
mobile.DatePlat <- summarise(mobile.gbDatePlat,gmb=sum(gmb_plan)); head(mobile.DatePlat)


#filter for last 2 years
df.Date_2yr <- df.Date[df.Date$created_dt>=max(df.Date$created_dt) - (366*2+2),]; df.Date_2yr