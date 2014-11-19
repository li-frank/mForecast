#limit data to last 3 years
minDate.lim <- maxDate - 3*364 + 1
df <- df[df$created_dt >= minDate.lim,]

##gmb over time
###old: sumDate <- ddply(df,.(created_dt),summarize,gmb=sum(gmb_plan))
df.gbDate <- group_by(df,created_dt)
df.Date <- summarise(df.gbDate,gmb=sum(gmb_plan)); tail(df.Date)
#filter for last 2 years
df.Date_2yr <- df.Date[df.Date$created_dt>=max(df.Date$created_dt) - (366*2+2),]; df.Date_2yr

mobile <- df[df$platform != 'Core Site on PC',]

##mobile gmb: platform over time
mobile.DatePlat <- ddply(mobile,
                         .(created_dt,platform),
                         summarise,gmb=sum(gmb_plan))
#mobile.gbDatePlat <- group_by(mobile,.groups=c(created_dt, platform))
#mobile.DatePlat <- summarise(mobile.gbDatePlat,gmb=sum(gmb_plan)); tail(mobile.DatePlat)

##mobile gmb: country over time
mobile.DateCntry <- ddply(mobile,
                         .(created_dt,country),
                         summarise,gmb=sum(gmb_plan))
#mobile.gbCntryPlat <- group_by(mobile,.groups=(created_dt, country))
#mobile.DateCntry <- summarise(mobile.gbDatePlat,gmb=sum(gmb_plan)); tail(mobile.DatePlat)

##mobile gmb: platform & country over time
mobile.PlatCntry <- ddply(mobile,
                          .(created_dt,country,platform),
                          summarise,gmb=sum(gmb_plan))
#mobile.gbCntryPlat <- group_by(mobile,created_dt,country, platform)
#mobile.cntryPlat <- summarise(mobile.gbCntryPlat,gmb=sum(gmb_plan)); mobile.cntryPlat[mobile.cntryPlat$created_dt==maxDate & mobile.cntryPlat$country=='US',]

##mobile aggregate
mobile.gbDate <- group_by(mobile,created_dt)
mobile.Date <- summarise(mobile.gbDate,gmb=sum(gmb_plan)); tail(mobile.Date)

##pc
pc <- df[df$platform == 'Core Site on PC',]
pc.gbDate <- group_by(pc,created_dt)
pc.Date <- summarise(pc.gbDate,gmb=sum(gmb_plan)); tail(pc.Date)