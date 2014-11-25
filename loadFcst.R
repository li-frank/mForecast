#insert new forecast into p_csi_tbs_t.fl_dly_mGMBforecast
# teradataInsert <- function(system="vivaldi", user="", password="", database="access_views", 
#                            table, df, pi = NULL, set = "MULTISET", safe = TRUE, 
#                            cleanup = FALSE)

#p_csi_tbs_t.fl_dly_mGMBforecast_s1

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-
#retail <- read.csv("http://robjhyndman.com/data/ausretail.csv",header=FALSE)
#retail <- ts(retail[,-1],f=12,s=1982+3/12)

#system.time() to see how long function takes

#function to organize into TS

#function to loop through auto.arima