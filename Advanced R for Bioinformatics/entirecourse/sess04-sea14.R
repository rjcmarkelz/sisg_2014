setwd("C:/Users/kenrice/Desktop/SISG-ADV")

# function to work out (partial) Area Under Curve

pAUC<-function(fpr,tpr,lower=0, upper=1){
	 
	ininterval <- which( fpr>=lower & fpr<=upper )
	n <- length(ininterval)
	
	delta <- diff(fpr[ininterval])
	av    <- (tpr[ininterval][-1]+tpr[ininterval][-n])/2
	sum(delta*av)
	}

## Q1a (using S3 methods)

# first, cut and paste function definitions from slides;

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

# an example (simulated data)

set.seed(1297) # Battle of Stirling Bridge (w/ Mel Gibson)
y <- rep(0:1, times=c(50, 150) ) # disease status
x <- rnorm(200, mean=y*2)

ROC(x, y)

roc1 <- ROC(x, y)
str(roc1)
print(roc1)
plot(roc1)         # impressive-looking area under curve
abline(0,1, lty=2) # the "just guessing line"
pAUC(roc1$fpr, roc1$tpr)

identify(roc1)


# Q1a
# summary method for ROC objects

summary.ROC<-function(object,lower=0,upper=1,...){
	pauc<-pAUC(object$fpr, object$tpr, lower,upper)
	rval<-list(curve=object, pAUC=pauc, lower=lower, upper=upper)
	class(rval)<-"summary.ROC"
	rval
	}
# nb first argument must be called "object" - type "summary" to see the right name
	
print.summary.ROC<-function(x, ...){
	print(x$curve)
	cat("pAUC (",x$lower,",",x$upper,") = ",round(x$pAUC,2),"\n")
	invisible(x)
	}

plot.summary.ROC<-function(x,col="#FF000030",border=NA,...){
	plot(x$curve)
	ininterval<-which(x$curve$fpr>=x$lower & x$curve$fpr<=x$upper)
	n<-length(ininterval)
	polygon(c(x$curve$fpr[rev(ininterval)], x$curve$fpr[ininterval]),
	        c(rep(0, length(ininterval)), x$curve$tpr[ininterval]), col=col,border=border,...)
	invisible(x)
	}	

sroc1 <- summary(roc1)
sroc1
print(sroc1) # the same thing

str(sroc1)
plot(sroc1)  # pink!
plot(summary(roc1, lower=0.2, upper=0.6), col="cyan") # nicer to re-plot the line
lines(roc1) 

#### Q2 (using S3 objects)

# function which will become the ROC method for glm.objects
logisticROC<-function(model){
	rval<-ROC(fitted(model), model$y)
	rval
	}	

ROC.default <- ROC  # a copy of the ROC() function, defined above
ROC.glm     <- logisticROC		
		
# define a generic called ROC
ROC <- function(test, disease){
	UseMethod("ROC")
	}	

methods("ROC")
	
# a 'proper' example, using data from the survival package
# (simulated data would also be fine)

data("pbc", package="survival")
pbc$died <- pbc$status==2
model    <- glm(died~log(bili)+protime+albumin, data=pbc,family=binomial)
str(model)
coef(summary(model))

roc2 <- ROC(model)
str(roc2)
summary(roc2)
roc2$call

plot(roc2)
abline(0,1,lty=2)
# bili is bilirubin levels
# protime is prothrombin time (clotting time)
with(pbc, lines(ROC(bili,died),col="forestgreen", lwd=2, type="s"))
with(pbc, lines(ROC(protime, died), col="magenta", lwd=2, type="s"))

summary(roc2)
with(pbc, summary(ROC(bili,died)))
with(pbc, summary(ROC(protime,died))) # slightly smaller AUC

# 'fun' with identify.ROC
ident.out <- identify(roc2, digits=2)
roc2$cutpoints[ident.out]

## S4 question 1

# from slides, set the class 
# ... but adding "S4" to class, to avoid (some) confusion

setClass("ROCS4",
	representation(tpr="numeric",fpr="numeric",
	cutpoints="numeric",call="call")
)

setGeneric("summary")
setMethod("summary",	"ROCS4",function(object,lower=0,upper=1,...){
		pauc<-pAUC(object@fpr, object@tpr, lower,upper)
#     show(object)
	cat("S4 version, pAUC (",lower,",",upper,") = ",round(pauc,2), "\n")
	})

# function to create an ROCS4 object (i.e. the S4 version)
ROC.s4 <- function(T,D){
	DD <- table(-T,D)
	tpr <- cumsum(DD[,2])/sum(DD[,2])
	fpr <- cumsum(DD[,1])/sum(DD[,1])
	new("ROCS4",tpr=tpr, fpr=fpr,
	cutpoints=rev(sort(unique(T))),call=sys.call())
}

ROC.s4(x, y) # create a show method to have a nicer, briefer version returned
r.4 <- ROC.s4(x,y)
summary(r.4)

sroc1 # same pAUC



	