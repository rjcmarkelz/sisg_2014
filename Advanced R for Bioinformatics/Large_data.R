setwd("~/git.repos/SISG_course/Advanced R for Bioinformatics/")
library("ncdf")
nc <- open.ncdf("sisg.nc")
?get.var.ncdf
chromosome <- get.var.ncdf(nc, "snp", start=1, count=-1)
person     <- get.var.ncdf(nc, "sample", start=1, count=-1)
head(chromosome)
dim(chromosome)
dim(person)


######
#SQLlite
######
library("RSQLite")
sqlite <- dbDriver("SQLite")
?dbConnect
SEAflights <- dbConnect(sqlite, "SEAflights.db")

dbListTables(SEAflights)
dbListFields(SEAflights, "SEA")

seadata <- dbGetQuery(SEAflights, 
	        "select Origin, Dest, ArrDelay, DepDelay from SEA where Origin OR Dest = 'SFO'")

head(seadata)

dbDisconnect(SEAflights)
