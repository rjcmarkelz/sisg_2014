\name{ROC}
\alias{ROC}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
ROC(T, D)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{T}{
%%     ~~Describe \code{T} here~~
}
  \item{D}{
%%     ~~Describe \code{D} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (T, D) 
{
    DD <- table(-T, D)
    tpr <- cumsum(DD[, 2])/sum(DD[, 2])
    fpr <- cumsum(DD[, 1])/sum(DD[, 1])
    rval <- list(tpr = tpr, fpr = fpr, cutpoints = rev(sort(unique(T))), 
        call = sys.call())
    class(rval) <- "ROC"
    rval
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
