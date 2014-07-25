# NB start a new R session before running these commands
# - because the package.skeleton() command makes documentation for everything
# in memory
rm( list=ls() )
setwd("C:/Users/kenrice/Desktop/SISG-ADV/Session5")

source("http://faculty.washington.edu/kenrice/sisg-adv/ROC-S3.R")
ls()
# get rid of all the objects in the examples
rm(y1, y2, z1, z2, glm1, glm2, expit, roc1, roc2)
ls()
# just the functions

package.skeleton("ROCpkg")
# edit this - e.g. put in examples, change the NAMESPACE file
# and adding titles to all help pages (see later INSTALL)
# and editing the example in the package overview help page (see later check)

#Command line - or use shell(), or system() 
#command prompt in windows

cd C:\Users\kenrice\Desktop\SISG-ADV\Session5
path C:\Program Files\R\R-3.0.2\bin\x64;%PATH%

R CMD INSTALL ROCpkg 
# annoying lack of title; fix this (and in practice, much else)

# and here's one I made earlier...
R CMD INSTALL ROCpkgNICE 
R CMD check ROCpkgNICE   
# warnings, and fails to make PDFs - but okay

R CMD build ROCpkgNICE 
# makes a gz file

R CMD INSTALL --build ROCpkg # makes a zip file, if you have zip installed

# edit this until the error messages go away
# - warnings are okay

# last command makes a Windows ZIP file, can be installed using the Windows GUI
# or...

install.packages("C:\\Users\\kenrice\\Desktop\\SISG-ADV\\Session5\\ROCpkg_1.0.tar.gz", type="source")
library("ROCpkg")
help(package="ROCpkg")

?ROC
# how to access the guts of a hidden function 
ROCpkg:::plot.ROC
getAnywhere(plot.ROC)
args(mean)
argsAnywhere(plot.ROC)

