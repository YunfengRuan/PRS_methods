library(pROC) 
#Based on Lee et al's work, A better coefficient of determination for genetic profile analysis，Genetic Epidemiology (2012）

LiabR2<-function(ncase, ncont, K, R20){
  #number of cases
  ncase=ncase
  
  #number of control
  ncont=ncont
  
  #total number of the sample
  nt=ncase+ncont
  P=ncase/nt
  #population prevalence
  K=K
  
  #assume follow Normal distribution
  #the threshold on the normal distribution which truncates the proportion of disease prevalence
  thd=qnorm(1-K)
  zv=dnorm(thd)
  mv=zv/K
  mv2=-mv*K/(1-K)
  
  theta=mv*(P-K)/(1-K)*(mv*(P-K)/(1-K)-thd) #theta in equation (15)
  cv=K*(1-K)/zv^2*K*(1-K)/(P*(1-P)) #C in equation (15)
  
  #observed n2
  R2O=R20
  
  #transfer
  R2=R2O*cv/(1+R2O*theta*cv)
  return(R2)
}

##example:
## A cohort of 500 cases and 530 controls; the partial R2 calculated by different PRS methods are 0.032, 0.042, 0.21, 0.059; 
## the prevalence in general population is 0.02.
## The calculation is 
a <- c(0.032, 0.042, 0.21, 0.059)
liability <- LiabR2(500, 530, 0.02, a)
