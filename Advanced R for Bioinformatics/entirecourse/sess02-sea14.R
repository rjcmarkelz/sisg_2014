setwd("C:/Users/kenrice/Desktop/SISG-ADV")

f <- read.csv("SEAflights.csv")
g <- read.csv("airportlocations.csv")

names(f)
names(g)

g2 <- g
names(g2) <- c("Origin", "o.lat", "o.long")

g3 <- g
names(g3) <- c("Dest", "d.lat", "d.long")

# merge everything together
h  <-  merge(f, g2, by="Origin")
h2 <-  merge(h, g3, by="Dest")

names(h2)

#install.packages("hexbin")
library("hexbin")
with(h2, plot(hexbin(o.long, o.lat)))  # not right
with(h2, plot(hexbin(-o.long, o.lat))) # coping with minutes west, not east

range(h2$o.long, na.rm=T)
range(h2$o.lat, na.rm=T)

locator()


#install.packages("maps")
library("maps")
library(help="maps")

# plotting the lines on top of a prettier map
map("state")
dim(h2)
#with(h2, segments(-o.long, o.lat, -d.long, d.lat,col="#0000FF20") )
# this would take a while

# just using a subset... there are so many, the exact choice doesn't matter
map("state")
system.time({
with(h2[sample(70724,1000),], segments(-o.long, o.lat, -d.long, d.lat,col="#0000FF10",lwd=3) )
})

# zoomed in version of same
map("county","washington")
with(h2[sample(70724,1000),], segments(-o.long, o.lat, -d.long, d.lat,col="#0000FF10",lwd=3) )
  
# which airports have delays in and out?
names(h2)
delays <- aggregate(h2[,c("ArrDelay","DepDelay","AirTime")], list(h2$Origin),mean, na.rm=TRUE) 

plot(ArrDelay~DepDelay, data=delays)
my.choice <- with(delays, 
 identify(DepDelay, ArrDelay, labels=as.character(Group.1)) 
)
delays[my.choice,]

# a higher-dimensional version of this plot (without nasty "fake 3D")
coplot(ArrDelay~DepDelay|AirTime, data=delays)
coplot(ArrDelay~DepDelay|AirTime, data=delays, rows=1)

# For aviation/navigation fans;
# gcIntermediate() is in geosphere package

install.packages("geosphere")
library(help="geosphere")
library("geosphere")
?gcIntermediate

map("state")

for(i in sample(70724,1000)){
	gci <- with(h2[i,], gcIntermediate(c(-o.long, o.lat), c(-d.long, d.lat)) )
	lines(gci[,1], gci[,2],col="#0000FF10",lwd=6)
}

