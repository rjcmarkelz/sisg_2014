setwd("C:/Users/kenrice/Desktop/SISG-ADV")

amd <- read.table("http://faculty.washington.edu/kenrice/sisg-adv/amd.txt", header=TRUE)
dim(amd)

# missing values (should be set to NA!)
table(as.matrix(amd[1:100, 1:100]))

# loop over all pairs (slow)
# also throws a few warnings about zero standard deviations

system.time({
	r<-matrix(ncol=100,nrow=100)
	for (i in 1:100){
		for(j in 1:100){
			r[i,j]<-cor(amd[,i],amd[,j])
			}
	}
	})

# loop over each pair, and profile it
Rprof("corr.rprof")
system.time({
	r<-diag(100)
	for (i in 1:100){
		for(j in (i+1):100){
			r[i,j]<-cor(amd[,i],amd[,j])
			}
	}
	})
Rprof(NULL)
summaryRprof("corr.rprof")	

# looping commands take time
# ... but cor() does this in C, with matrix/data frame input

system.time(cor(amd[,1:100]))
Rprof("corr.rprof")
system.time(cor(amd[,1:1000]))
Rprof(NULL)
summaryRprof("corr.rprof")	

# is this faster? It depends on your system
Rprof("corr.rprof")
mycor<-function(m) {crossprod(scale(m))/(nrow(m)-1)}
system.time(mycor(amd[,1:4000]))
Rprof(NULL)
summaryRprof("corr.rprof")	

# for those with a few seconds to spare...
# - or hours, if you use the original double for() loop
system.time(mycor(amd))
system.time(cor(amd))

