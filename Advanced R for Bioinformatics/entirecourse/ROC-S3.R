###--------------------------------##

ROC<-function(T,D){ 
DD <- table(-T,D) 
tpr <- cumsum(DD[,2])/sum(DD[,2]) 
fpr <- cumsum(DD[,1])/sum(DD[,1]) 
rval <- list(tpr=tpr, fpr=fpr, 
cutpoints=rev(sort(unique(T))), 
call=sys.call()) 
class(rval)<-"ROC" 
rval 
} 

print.ROC<-function(x,...){ 
cat("ROC curve: ") 
print(x$call) 
} 
plot.ROC <- function(x, xlab="1-Specificity", 
ylab="Sensitivity", type="l",...){ 
plot(x$fpr, x$tpr, xlab=xlab, ylab=ylab, type=type, ...) 
} 

lines.ROC <- function(x, ...){ 
lines(x$fpr, x$tpr, ...) 
} 

identify.ROC<-function(x, labels=NULL, ...,digits=1) 
{ 
if (is.null(labels)) 
labels<-round(x$cutpoints,digits) 
identify(x$fpr, x$tpr, labels=labels,...) 
} 

### an example of glm(), i.e. logistic regression

set.seed(5)
expit <- function(x){ exp(x)/(1+exp(x)) }
z1 <- rnorm(1000)
z2 <- rnorm(1000)
y1  <- rbinom(1000, 1, expit( -0.5 + 1.0*z1 + 1.0*z2 ) )
y2  <- rbinom(1000, 1, expit( -0.5 + 0.5*z1 + 0.5*z2 ) )
glm1 <- glm(y1~z1+z2, family=binomial)
glm2 <- glm(y2~z1+z2, family=binomial)
coef(glm1)
coef(glm2)

roc1 <- ROC(fitted(glm1), glm1$y)
roc2 <- ROC(fitted(glm2), glm2$y)
plot(roc1, col="red")
lines(roc2, col="pink")
abline(0,1,lty=2)






