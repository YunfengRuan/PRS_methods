#!/bin/bash
#$ -cwd
#$ -j y
#$ -o $HOME
#$ -l h_vmem=50G
#$ -l h_rt=20:00:00

ldpred="$HOME/.local/bin/ldpred"
dir=/stanley/huang_lab/home/Y.Ruan/SCZ.PRScsx/
### export PATH=$PATH:/home/unix/yruan/.local/bin
source /broad/software/scripts/useuse
reuse .gcc-5.2.0
reuse Python-3.6
reuse Anaconda3

## Need $Base, $basefile, $cohort, ${n_trn}, $target

if [ $Base == 'EUR' ]
then 
pop=eur
elif [ $Base == 'EAS' ]
then
pop=eas
fi

trait=SCZ

ssf=${dir}/Base/${basefile}
bim_prefix=${dir}/Target/${target}
ld_ref=/stanley/huang_lab/home/Y.Ruan/Raw_Data/g1000_${pop}
coord=${dir}/LDpred-result/coord-${Base}.${cohort}_${target}-${trait}

${ldpred} coord  \
--only-hm3 \
--gf ${ld_ref} \
--ssf ${ssf} \
--N ${n_trn} \
--out ${coord} \
--vbim ${bim_prefix}.bim \
--eff_type OR \
--maf 0.01 \
--max-freq-discrep 1 \
--ssf-format CUSTOM \
--rs SNP \
--A1 A1 \
--A2 A2 \
--pos BP \
--chr CHR \
--pval P \
--eff OR \
--se SE


${ldpred} gibbs \
--cf ${coord} \
--ldr 400 \
--ldf ${dir}/LDpred-result/ld-${Base}.${cohort}_$target-${trait} \
--out ${dir}/LDpred-result/pst-${Base}.${cohort}_$target-${trait} \
--f 1.0 0.3 0.1 0.03 0.01 0.003 0.001 0.0003 0.0001 0.00003 0.00001 \
--N ${n_trn}


