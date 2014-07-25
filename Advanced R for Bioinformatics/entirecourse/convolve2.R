# Commands for the C example in notes
# before starting, download convolve2.Call, to your working directory (and read it)

#
#at the Command Line;
#
cd C:\Users\Ken\Desktop\SISG-ADV

#notice that there was a bunch of path changes at Rtools installation
#but we need one more;

path C:\Program Files\R\R-2.13.0\bin;%PATH%

#... also, delete old versions of convolve2.o, convolve2.dll, if they exist
setwd("C:/Users/Ken/Desktop/SISG-ADV")
# system("rm convolve2.o")
# system("rm convolve2.dll")

# Also need to force 64-bit architecture (on my machine)
R --arch x64 CMD SHLIB convolve2.c

file.show("convolve2.c")

#... also, delete old versions of convolve.o, convolve.dll, if they exist
# back in R

setwd("C:/Users/Ken/Desktop/SISG-ADV")

dyn.load("convolve2.dll")

# make a function that uses the C code
conv2 <- function(x, y){
	x <- as.double(x)
	y <- as.double(y)	
.Call("convolve2", x, y)
}

# R version
Rconv <- function(x, y){
	m <- length(x)
	n <- length(y)
	z <- m+n-1
	for(j in 1:m){
		for (k in 1:n){
			z[j+k-1] = z[j+k-1] + x[j]*y[k]
		}
}
z
}

system.time( replicate(1000, { conv(1:100, 1:100)} ) )
system.time( replicate(1000, { conv2(1:100, 1:100)} ) )
#could do slightly better with the improved C code, in the slides

system.time( replicate(100, {Rconv(1:100, 1:100)} ) )

dyn.unload("convolve2.dll")






