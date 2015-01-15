library(plyr)
#limit data to last 3 years
minDate.lim <- maxDate - 3*364 + 1
actual0.lim <- actual0[actual0$trans_dt >= minDate.lim,]

mobile.lim <- actual0.lim[actual0.lim$platform != "Core Site on PC",]
mobile.unlim <- actual0[actual0$platform != "Core Site on PC",]

##mobile gmb: platform over time
mobile.DatePlat <- ddply(mobile.lim,
                         .(trans_dt,platform),
                         summarise,gmb=sum(gmb))

##mobile gmb: country over time
mobile.DateCntry <- ddply(mobile.lim,
                         .(trans_dt,country),
                         summarise,gmb=sum(gmb))

##mobile gmb: platform & country over time*****************************
mobile.PlatCntry <- ddply(mobile.lim,
                          .(trans_dt,country,platform),
                          summarise,gmb=sum(gmb))

##mobile aggregate
mobileAgg <- ddply(mobile.lim,
                          .(trans_dt),
                          summarise,gmb=sum(gmb))

#add GMB share: share of site and share of country