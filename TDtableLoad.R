conn <- teradataConnect()
table <- 'p_csi_tbs_t.fl_mobileFcst'
df <- combined
batchSize <- 15000
#maxBatch=16383
###############################################

start <- proc.time()
#clear old table
drop <- paste('drop table',table,';'); drop
dropped <- dbSendQuery(conn,drop)

##confirm dropped (will show error message)
#confirmEmpty <- dbGetQuery(conn,paste('select * from',table,';'))

createTablePath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Forecast/ForecastModel/mForecast/SQL/createEmptyTable.sql'
createTableQuery <- paste(readLines(createTablePath), collapse=" ")
createTableQuery <- gsub(':tableName',table,createTableQuery); createTableQuery
createdEmpty <- dbSendQuery(conn,createTableQuery)

#confirm empty but columns available
confirmCreated <- dbGetQuery(conn,paste('select * from',table)); confirmCreated

emptyTime <- proc.time()-start; emptyTime
##end of drop create table##

#push table
start <- proc.time()
# batch: http://developer.teradata.com/blog/ulrich/2013/11/a-wider-test-case-on-r-jdbc-fastload 
push_df_2_TD_Batch <- function(conn,table,df)
{ 
  myinsert <- function(arg1,arg2,arg3,arg4,arg5){
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
  
  
  ##########
  rowStart <- 1
  
  
  ## batch insert
  for(n in 1:nrow(df)){
    myinsert(df[n,1],df[n,2],df[n,3],df[n,4],df[n,5])
  }
  
  #   #apply & commit
  .jcall(ps,"[I","executeBatch")
  #   
  #   exc <- NULL
  #   exc <-dbGetException(ps)
  #   print(exc)
  
  
  # # capture chained JDBC SQLException messages and stack trace from PreparedStatement.executeBatch()
  # .jcall(ps,"[I","executeBatch", check=FALSE) # disable the default jcall exception handling with check=FALSE
  # ex = .jgetEx() # save exceptions from PreparedStatement.executeBatch()
  # .jclear() # clear all pending exceptions
  # if (!is.jnull(ex)) {
  #   while (!is.jnull(ex)) { # loop thru chained exceptions
  #     sw = .jnew("java/io/StringWriter")
  #     pw = .jnew("java/io/PrintWriter",.jcast(sw, "java/io/Writer"),TRUE)
  #     .jcall(ex,"V","printStackTrace",pw) # redirect printStackTrace to a Java PrintWriter so it can be printed in Rterm AND Rgui
  #     if (ex %instanceof% "java.sql.BatchUpdateException") {
  #       print(.jcall(ex,"[I","getUpdateCounts")) # print int[] update count showing 3 rows inserted successfully (1) and 2 rows failed to insert (-3)
  #     }
  #     cat(.jcall(sw,"Ljava/lang/String;","toString")) # print the error message and stack trace
  #     if (ex %instanceof% "java.sql.SQLException") {
  #       ex = ex$getNextException()
  #     } else {
  #       ex = ex$getCause()
  #     }
  #   }
  #   
  #   # capture chained JDBC SQLWarning messages and stack trace from Connection.rollback()
  #   .jcall(conn, "V", "rollback")
  #   w = .jcall(conn, "Ljava/sql/SQLWarning;", "getWarnings") # save warnings from Connection.rollback()
  #   while (!is.jnull(w)) { # loop thru chained warnings
  #     sw = .jnew("java/io/StringWriter")
  #     pw = .jnew("java/io/PrintWriter",.jcast(sw, "java/io/Writer"),TRUE)
  #     .jcall(w,"V","printStackTrace",pw) # redirect printStackTrace to a Java PrintWriter so it can be printed in Rterm AND Rgui
  #     cat(.jcall(sw,"Ljava/lang/String;","toString")) # print the warning message and stack trace
  #     w = w$getNextWarning()
  #   }
  # } else {
  #   .jcall(conn, "V", "commit")
  # }
  
  dbCommit(conn)
  .jcall(ps,"V","close")
  .jcall(conn@jc,"V","setAutoCommit",TRUE)
  
}

#start push loop#
startRow <- 1
totalRows <- nrow(df); totalRows

while (startRow <= nrow(df)){
  numRows <- min(batchSize,totalRows-startRow+1); numRows
  endRow <- startRow+numRows-1
  push_df_2_TD_Batch(conn,table,df[startRow:endRow,]); print(paste("pushing rows",startRow,"to",endRow))
  startRow <- endRow+1
}
##end push loop##

dbDisconnect(conn)

loadTime <- proc.time()-start; emptyTime; loadTime
