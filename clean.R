library(plyr)
#limit data to last 3 years
minDate.lim <- maxDate - 3*364 + 1
df.lim <- df[df$created_dt >= minDate.lim,]

mobile.lim <- df.lim[df.lim$platform != "Core Site on PC",]
mobile.unlim <- df[df$platform != "Core Site on PC",]

##mobile gmb: platform over time
mobile.DatePlat <- ddply(mobile.lim,
                         .(created_dt,platform),
                         summarise,gmb=sum(gmb_plan))

##mobile gmb: country over time
mobile.DateCntry <- ddply(mobile.lim,
                         .(created_dt,country),
                         summarise,gmb=sum(gmb_plan))

##mobile gmb: platform & country over time
mobile.PlatCntry <- ddply(mobile.lim,
                          .(created_dt,country,platform),
                          summarise,gmb=sum(gmb_plan))

##mobile aggregate
mobileAgg <- ddply(mobile.lim,
                          .(created_dt),
                          summarise,gmb=sum(gmb_plan))

#add GMB share: share of site and share of country