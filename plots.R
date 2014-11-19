library('ggplot2')
#dev.off()
#plot gmb over time
plot_df.Date <- ggplot(df.Date,
                       aes(x=created_dt,y=gmb, color=format(created_dt,"%Y"))) + geom_line(); plot_df.Date
#plot gmb over time (rolling 2 years)
Year <- format(df.Date_2yr$created_dt,"%Y")
monthDate <- format(df.Date_2yr$created_dt,"%m-%d")
plot_df.Date_2yr <- ggplot(df.Date_2yr,
                           aes(x=monthDate,y=gmb, color=Year)) + geom_line(aes(group=Year)); plot_df.Date_2yr

#plot mobile gmb by platform over time
plot_mobile.DatePlat <- ggplot(mobile.DatePlat,
                               aes(x=created_dt,y=gmb, color=platform)) + geom_line(); plot_mobile.DatePlat
#plot mobileAgg gmb over time
plot_mobile.Date <- ggplot(mobile.Date,
                       aes(x=created_dt,y=gmb)) + geom_line(); plot_mobile.Date

#plot pcAgg gmb over time
plot_pc.Date <- ggplot(pc.Date,
                       aes(x=created_dt,y=gmb)) + geom_line(); plot_pc.Date
