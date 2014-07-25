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
gutlength <- subset(gutlength, chr= -15)
boxplot(gutlength ~ sex*cross, data=gutlength$pheno, horizontal=TRUE, xlab= "Gut Length (cm)", col=c("red", "blue"))
anova(aov(gutlength ~ sex*cross, data=gutlength$pheno))
