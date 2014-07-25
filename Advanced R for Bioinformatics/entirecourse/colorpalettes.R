library("colorspace")
library("dichromat")
library("RColorBrewer")

wheel<-function(col, radius = 1, ...)
  pie(rep(1, length(col)), col = col, radius = radius, ...)
pal<-function(col, border = "light gray", ...) 
 { 
 n <- length(col) 
 plot(0, 0, type="n", xlim = c(0, 1), ylim = c(0, 1), 
 axes = FALSE, xlab = "", ylab = "", ...) 
 rect(0:(n-1)/n, 0, 1:n/n, 1, col = col, border = border) 
 } 
 par(mar=c(1,1,1,1))
 
 par(mfrow=c(2,1))
 wheel(rainbow(12)); wheel(rainbow_hcl(12))
 
 par(mfrow=c(3,1))
 pal(terrain.colors(8))
 pal(terrain_hcl(8));  
 pal((rev(brewer.pal(8,"YlGn"))))
 
 par(mfrow=c(3,2))
 pal((brewer.pal(7,"RdYlGn")))
 pal(dichromat(brewer.pal(7,"RdYlGn")))
 pal((brewer.pal(7,"PRGn")))
 pal(dichromat(brewer.pal(7,"PRGn")))
 pal((diverge_hcl(17, c = 100, l = c(40, 70), power = 1)))
 pal(dichromat(diverge_hcl(17, c = 100, l = c(40, 70), power = 1)))
