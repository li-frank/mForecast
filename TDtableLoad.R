conn <- c

#remove old table
removePath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Forecast/ForecastModel/mForecast/SQL/drop_createEmpty.sql'
removeQuery <- paste(readLines(removePath), collapse=" ")
removeQuery <- gsub(':start_dt',reloadStart,removeQuery); removeQuery
removed <- dbSendQuery(c,removeQuery)

table <- 'p_csi_tbs_t.fl_mobileFcst'
df<-combined[1:100,]

# batch: http://developer.teradata.com/blog/ulrich/2013/11/a-wider-test-case-on-r-jdbc-fastload 
push_df_2_TD_Batch <- function(conn,table,df)
{ 
  myinsert <- function(arg1,arg2,arg3,arg4, arg5){
    .jcall(ps,"V","setString",as.integer(1),as.character(arg1))
    .jcall(ps,"V","setString",as.integer(2),as.character(arg2))
    .jcall(ps,"V","setString",as.integer(3),as.character(arg3))
    .jcall(ps,"V","setInt",as.integer(4),as.integer(arg4))
    .jcall(ps,"V","setString",as.integer(5),as.character(arg5))
    .jcall(ps,"V","addBatch")
  }
  
  #set autocommit false
  .jcall(conn@jc,"V","setAutoCommit",FALSE)
  ##prepare
  ps = .jcall(conn@jc,"Ljava/sql/PreparedStatement;","prepareStatement",paste("insert into ",table," values(?,?,?,?,?)",sep=""))
  
  
  
  ## batch insert
  for(n in 1:nrow(df)){
    myinsert(df[n,1],df[n,2],df[n,3],df[n,4],df[n,5])
  }
  
  #apply & commit
  .jcall(ps,"[I","executeBatch")
  dbCommit(conn)
  .jcall(ps,"V","close")
  .jcall(conn@jc,"V","setAutoCommit",TRUE)
  
}

push_df_2_TD_Batch(conn,table,df)
