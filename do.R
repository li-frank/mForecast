#only load existing data: Source("load.R")
rm(list = ls())

start1 <- proc.time()

source("update.R")
source("load.R")

start2 <- proc.time()
source("clean.R")

UpdateTime <- proc.time()-start1; UpdateTime
cleanTime <- proc.time()-start2; cleanTime

#source("plots.R")
#source("forecast.R")

source("loadFcst2.R")