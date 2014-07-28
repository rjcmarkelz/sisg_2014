setwd("~/git.repos/SISG_course/Advanced R for Bioinformatics/")

amdmat <- read.table("http://faculty.washington.edu/kenrice/sisg-adv/amd.txt", header = TRUE)
head(amdmat)
dim(amdmat)

amdmat_small <- as.matrix(amdmat[1:2])
dim(amdmat_small)
amdmat_small

str(amdmat_small)
cor(amdmat_small)

# corout <- 

# for(i in 1:length(amdmat_small)){        
#    }

system.time(amd_cor <- cor(amdmat_small, amdmat_small, method = c("pearson")))
amd_cor

#test some R code I am familiar with.
library(qtl)
library(qtlbook)
data(gutlength)
gutlength
#7.1
?Rprof
Rprof(filename = "test_out.txt")
ls()
summary(gutlength)
gutout <- scanone(gutlength)
Rprof(NULL)
summaryRprof("test_out.txt")


gutlength <- subset(gutlength, chr= -15)
boxplot(gutlength ~ sex*cross, data=gutlength$pheno, horizontal=TRUE, xlab= "Gut Length (cm)", col=c("red", "blue"))
anova(aov(gutlength ~ sex*cross, data=gutlength$pheno))\


#######
#Session 2- Graphics
#######

seaflight <- read.csv("http://faculty.washington.edu/kenrice/sisg-adv/SEAflights.csv")
airloc <- read.csv("http://faculty.washington.edu/kenrice/sisg-adv/airportlocations.csv")
head(airloc)
head(seaflight)

library(hexbin)


seaflight$
names(seaflight)
head(seaflight)
plot(hexbin(seaflight$, seaflight$), style = "centroids")
head()

seaflight2 <- merge()
?maps
library(maps)
?maps
map('state.vbm', fill = TRUE, col = palette())
names(seaflight)
names(airloc)
airloc2 <- 

#this is a really handy way to subset the data. 
names(airloc2) <- c("Year", "Month", "ArrDelay")
airloc2
head(airloc2)

############
#Day 2
############

#Session 1
#Session 2




# Session 3 --------------------------------------
# Make a small R package
# 

ROC <- function(test, disease){
	#where is the curve going to change?
	cutpoints <- (-Inf, sort(unique(test)), Inf)

	#what values will it take when it does change?
	sensitivity <- sapply(cutpoints,
		function(results){ mean(test > result & mean(disease))}
	)
	specificity <- sapply(cutpoints, 
		function(result){ mean (test <= result & !disease)/mean(disease)}
		)

	#plot the curve, return the coordinates
	plot(1-specificity, sensitivity, type="1")
	abline(0,1,lty=2)

	return(list(sens=sensitivity, spec=specificity))
}

vignette("GenomeSearching", package = "BSgenome")
?package.skeleton

ROC           <-function(T,D)


{ 
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

identify.ROC<-function(x, labels=NULL, ...,digits=1) { 
if (is.null(labels)) 
labels<-round(x$cutpoints,digits) 
identify(x$fpr, x$tpr, labels=labels,...) 
} 


#now create a package with these functions
package.skeleton(list = c("ROC", "print.ROC", "plot.ROC", "lines.ROC", "identify.ROC"),
	             name = "practice")

# or for even easier to document package
package.skeleton(list = c("ROC", "print.ROC"),
	             name = "practice")
?set.seed




