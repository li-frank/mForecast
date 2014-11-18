#create DFs for mobile, mobileAgg, PC

##gmb over time
###old: sumDate <- ddply(df,.(created_dt),summarize,gmb=sum(gmb_plan))
df.gbDate <- group_by(df,created_dt)
df.Date <- summarise(df.gbDate,gmb=sum(gmb_plan)); tail(df.Date)
#filter for last 2 years
df.Date_2yr <- df.Date[df.Date$created_dt>=max(df.Date$created_dt) - (366*2+2),]; df.Date_2yr

##mobile gmb: platform over time
mobile <- df[df$platform != 'Core Site on PC',]
mobile.gbDatePlat <- group_by(mobile,created_dt, platform)
mobile.DatePlat <- summarise(mobile.gbDatePlat,gmb=sum(gmb_plan)); tail(mobile.DatePlat)

##mobile gmb: platform & country over time
mobile <- df[df$platform != 'Core Site on PC',]
mobile.gbCntryPlat <- group_by(mobile,created_dt,country, platform)
mobile.cntryPlat <- summarise(mobile.gbCntryPlat,gmb=sum(gmb_plan)); mobile.cntryPlat[mobile.cntryPlat$created_dt==maxDate & mobile.cntryPlat$country=='US',]

##mobile aggregate
mobile.gbDate <- group_by(mobile,created_dt)
mobile.Date <- summarise(mobile.gbDate,gmb=sum(gmb_plan)); tail(mobile.Date)

##pc
pc <- df[df$platform == 'Core Site on PC',]
pc.gbDate <- group_by(pc,created_dt)
pc.Date <- summarise(pc.gbDate,gmb=sum(gmb_plan)); tail(pc.Date)