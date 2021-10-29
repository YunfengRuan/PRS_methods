Note: All the following script are using 1000 Genome downloaded from https://ctg.cncr.nl/software/magma as LD preference data  
_Scroll down, the download links are at the end of the page._

All the script are used for "qsub -v ...script.sh " command. I still keep the paths of my server in the scripts.
Please adjust accordingly if you run it on interactive sessions or locally.

## PRSice.pt.sh

The script uses PRSice (https://www.prsice.info/) to calculation Pruning and thresholding (PT) PRS

## PRSice.meta.sh 
Assuming you use a meta analysis data that consist of EUR and EAS GWAS data

First prepare the meta analysis discovery data. This step is not included in the script.

The script uses PRSice to calculate Pruning and thresholding (PT) PRS. Here we have 2 hyperparameters: the P-value threshold and the population of the LD reference. 

## LDpred.sh
It requires the sample size of the discovery GWAS data.

## PRScs.origin.sh
It requires the sample size of the discovery GWAS data.
It uses the original PRS-CS to calculate the PRS. 
In order to enable parallel jobs running at the same time. The analysis of each chromosome and each shrinkage parameter is done seperately. 
Please go to https://github.com/getian107/PRScs for more information

## PRScs.x.sh
It uses the PRS-CSx (https://github.com/getian107/PRScsx) to calculate the PRS. 

## Where to find the PRS
PRSice will print the PRS in *.all.score files  
LDpred and PRS-CS(x) will generate corrected effect size estimates. Please use plink to calculate the PRS: https://www.cog-genomics.org/plink/1.9/score

Here is an example of using plink to calculate PRS
```
$plink \
--score $posterior 2 4 6 sum center \
--bfile $target \
--out ${work_dir}/prs/${out}-phi1e${power} \
--allow-no-sex \
--memory 20000
```
*reads variant IDs from column 2, allele codes from column 4, and scores from column 6*


## To calculate the R^2 of PRS, you can use R:
### For binary traits:  
Here is the example code to calculate Nagelkerke's R2 (C1, C2, C3 are covariates)
```
library(rcompanion)
Null<-glm(formula = PHENO ~ C1 + C2 + C3 , family = "binomial", data = DATA)  
Full<-glm(formula = PHENO ~ PRS + C1 + C2 + C3 , family = "binomial", data = DATA)  
Adj.R2<-nagelkerke(Full, null=Null)$Pseudo.R.squared.for.model.vs.null[3]  
```
### For quantitative traits:
Here is the example code to calculate partial R2:
```
Null<-lm(PHENO ~ C1 + C2 + C3, Reg)  
Full<-lm(PHENO ~ PRS + C1 + C2 + C3, Reg)  
SSE.null<-sum(Null$residuals**2)  
SSE.full<-sum(Full$residuals**2)  
R2.partial<-(SSE.null-SSE.full)/SSE.null  
```


