# Commands for the C example in notes
# before starting, download convolve.c, to your working directory (and read it)

#
#at the Command Line;
#
cd C:\Users\Ken\Desktop\SISG-ADV

#notice that there was a bunch of path changes at Rtools installation
#but we need one more;

path C:\Program Files\R\R-3.0.1\bin;%PATH%

#... also, delete old versions of convolve.o, convolve.dll, if they exist
setwd("C:/Users/Ken/Desktop/SISG-ADV")
system("rm convolve.o")
system("rm convolve.dll")
# or use file.remove()

file.show("convolve.c")

# Forcing 64-bit architecture (on my machine)
R --arch x64 CMD SHLIB convolve.c

#The default 32-bit version is;
#R CMD SHLIB convolve.c

# back in R

setwd("C:/Users/Ken/Desktop/SISG-ADV")

dyn.load("convolve.dll")

# make a function that uses the C code
conv <- function(x, y){
  .C("convolve", x=as.double(x), n=length(x),
  y=as.double(y), m=length(y),
  z=numeric(length(x)+length(y)-1))$z
}

.C("convolve", x=as.double(1:5), n=5L, y=as.double(1:10), m=10L, z=numeric(14) )

# R version
Rconv <- function(x, y){
	m <- length(x)
	n <- length(y)
	z <- numeric(m+n-1)
	for(j in 1:m){
		for (k in 1:n){
			z[j+k-1] = z[j+k-1] + x[j]*y[k]
		}
}
z
}

conv(1:100, 1:100)
Rconv(1:100, 1:100)

# An example with a distribution (sum of two betas)
par(mfrow=c(2,1))
plot(x=200*ppoints(199), y=conv(1:100, 1:100), type="h")
hist(100*rbeta(10000, 2,1) + 100*rbeta(10000,2,1), n=50, xlim=c(0,200))

# An example with a simpler distribution (sum of two uniforms)
par(mfrow=c(2,1))
plot(x=2*ppoints(199), y=conv(rep(1/100, 100), rep(1/100, 100)), type="h")
hist(runif(10000) + runif(10000), n=50)

# timings
system.time( replicate(1000, { conv(1:100, 1:100)} ) )
system.time( replicate(100, {Rconv(1:100, 1:100)} ) ) # yawn!

dyn.unload("convolve.dll")



