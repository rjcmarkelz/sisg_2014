# A cancer laboratory is estimating the rate of tumorigenesis in two 
# strains of mice, A and B. They have tumor count data for 10 mice in 
# strain A and 13 mice in strain B. Type A mice have been well studied, 
# and information from other laboratories suggests that type A mice have 
# tumor counts that are approximately Poisson-distributed with a mean of 
# 12. Tumor count rates for type B mice are unknown, but type B mice are 
# related to type A mice. 

# The observed tumor counts for the two populations are

yA<-c(12,9,12,14,13,13,15,8,15,6)

yB<-c(11,11,10,9,9,8,7,10,6,8,8,9,7)

# In this exercise, we will assme the following sampling models:
#
# y1A...ynA ~ iid Poisson(thetaA) 
# y1B...ynB ~ iid Poisson(thetaB)

# 1. Identify the posterior distributions of thetaA and thetaB
# under the following priors:
# 
# thetaA ~ gamma(120,10)
# thetaB ~ gamma(12,1)

# 2. Find the posterior medians and 95% CIs for thetaA and thetaB
# using the qgamma command in R. 

# 3. Simulate several thousands of values of thetaA and thetaB 
# from their posterior distributions using the rgamma command in R. 
# From the simulated values, 
#   a. plot histograms that approximate the posteriors of  thetaA and thetaB
#   b. obtain approximate posterior medians and 95% CIS using the qunatile 
#      command in R, and compare to the results in 2. 

# 4. Using your simulated theta-values, plots histograms and obtain 
# posterior medians and 95% CIs for thetaA/thetaB and thetaA-thetaB.