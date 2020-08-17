#!/bin/sh
#$ -cwd
#$ -j y
#$ -o $HOME
#$ -l h_vmem=10G

PRSice=/stanley/huang_lab/home/Y.Ruan/Software/PRSice
plink=/stanley/huang_lab/home/Y.Ruan/Software/plink

dir=/stanley/huang_lab/home/Y.Ruan/SCZ.PRScsx/
base=${dir}/Base/$BASE
Bfile=${dir}/Target/${target}
out=${dir}/PRSice-result/${OUT}


$PRSice \
--base $base \
--target $Bfile \
--out ${out} \
--ld /stanley/huang_lab/home/Y.Ruan/Raw_Data/g1000_${pop} \
--fastscore \
--memory 10Gb \
--stat OR \
--pvalue P \
--binary-target T \
--snp SNP \
--bar-levels 1E-8,1E-7,1E-6,1E-5,3E-5,1E-4,3E-4,1E-3,3E-3,0.01,0.03,0.1,0.3,1.0 \
--score sum \
--missing CENTER \
--no-regress \
--all-score \
--thread 1 

