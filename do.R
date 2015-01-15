#only load existing data: Source("load.R")
rm(list = ls())

start <- proc.time()
source("update.R")
source("load.R")
UpdateTime <- proc.time()-start; UpdateTime

start <- proc.time()
source("clean.R")
cleanTime <- proc.time()-start; cleanTime
#source("plots.R")

start <- proc.time()
source("arimaFcst.R")
fcstTime <- start - proc.time(); fcstTime

start <- proc.time()
source("TDtableLoad.R")
loadTime <- start - proc.time(); loadTime