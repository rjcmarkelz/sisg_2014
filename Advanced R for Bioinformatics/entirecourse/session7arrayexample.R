## a short example using an array
## working out the minimum entry in each column of an array
## ... compiled using inline

#install.packages("inline")
library("inline")

# a version mentioning indexes explicitly
colmin1 <- cfunction(signature(x="numeric",nrow="integer",ncol="integer",mins="numeric"),
body="
  int i,j, n=*nrow;

  for(j=0; j<*ncol; j++) mins[j]=1.0/0.0;
  
  for(j=0; j<*ncol; j++){
    for(i=0; i<*nrow; i++){
      if ( x[i+n*j] < mins[j])  mins[j]=x[i+n*j];
    }
  }
  ",
  convention=".C",language="C")
  
#version using a macro
colmin2 <- cfunction(signature(x="numeric",nrow="integer",ncol="integer",mins="numeric"),
body="
  #define X(I,J) x[(I)+ (*nrow)*J]

  int i,j;

  for(j=0; j<*ncol; j++) mins[j]=1.0/0.0;
  
  for(j=0; j<*ncol; j++){
    for(i=0; i<*nrow; i++){
      if ( X(i,j) < mins[j])  mins[j]=X(i,j);
    }
  }
  ",
  convention=".C",language="C")
  
  
m <- matrix(as.numeric(1:12),4)
m

colmin1(m,nrow(m),ncol(m),numeric(ncol(m)))$mins
colmin2(m,nrow(m),ncol(m),numeric(ncol(m)))$mins

# a wrapper for colmin1 - so we don't have to supply dimensions, etc
colmins<-function(m){
	colmin1(as.numeric(m), nrow(m),ncol(m), numeric(ncol(m)))$mins
	}

colmins(m)
apply(m, 2, min)



