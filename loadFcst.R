#insert new forecast into p_csi_tbs_t.fl_dly_mGMBforecast
# teradataInsert <- function(system="vivaldi", user="", password="", database="access_views", 
#                            table, df, pi = NULL, set = "MULTISET", safe = TRUE, 
#                            cleanup = FALSE)

#p_csi_tbs_t.fl_dly_mGMBforecast_s1
#mobile.PlatCntry

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-
#retail <- read.csv("http://robjhyndman.com/data/ausretail.csv",header=FALSE)
#retail <- ts(retail[,-1],f=12,s=1982+3/12)

#system.time() to see how long function takes


st.year <- as.integer(format(minDate.lim,"%Y")); st.year
st.dayofYear <- as.integer(format(minDate.lim,"%j")); st.dayofYear

#test set
test<-mobile.PlatCntry[(mobile.PlatCntry$country=='US'|mobile.PlatCntry$country=='DE') &
                         (mobile.PlatCntry$platform=='FSoM'|mobile.PlatCntry$platform=='iPhone App'),]
test<-test[1:50,]
splits <- list(test$country,test$platform)
test2<-split(test,splits)


#by(warpbreaks, tension, function(x) lm(breaks ~ wool, data = x))

#function to loop through auto.arima