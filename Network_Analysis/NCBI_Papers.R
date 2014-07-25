library("RISmed")
setwd("/Users/Cody_2/git.repos/SISG_course/Network_Analysis/")

?EUtilsSummary
brass_papers <-  EUtilsSummary("brassica[ti]+Plant Physiology[jo]", db = "pubmed")
head(brass_papers)

QueryTranslation(brass_papers)
QueryCount(brass_papers)

fetch <- EUtilsGet(brass_papers)
fetch
# PubMed query:  brassica[ti] AND "Plant Physiol"[Journal] 
# Records:  146

Article 