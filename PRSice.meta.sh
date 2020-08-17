#!/bin/bash
#$ -cwd
#$ -j y
#$ -o $HOME
#$ -l h_vmem=8G


#Need cohort target 
trait=SCZ
dir="/stanley/huang_lab/home/Y.Ruan/SCZ.PRScsx/"
PRSice="/stanley/huang_lab/home/Y.Ruan/Software/PRSice"
for pop in eur eas
do
$PRSice \
--base ${dir}/Base/summarystats/mix.${cohort}.meta \
--target ${dir}/Target/${target} \
--ld /stanley/huang_lab/home/Y.Ruan/Raw_Data/g1000_${pop} \
--bar-levels 1E-8,1E-7,1E-6,1E-5,3E-5,1E-4,3E-4,1E-3,3E-3,0.01,0.03,0.1,0.3,1.0 \
--fastscore \
--score sum \
--missing CENTER \
--no-regress \
--all-score \
--memory 8Gb \
--thread 1 \
--binary-target T \
--stat OR \
--out $dir/Meta-result/EUR-EAS.${cohort}_${target}-${trait}-ref.$pop
done




