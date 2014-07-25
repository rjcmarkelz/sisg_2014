ROC <-
function(T,D)
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
