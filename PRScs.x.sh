#!/bin/sh
#$ -cwd
#$ -j y
#$ -o $HOME
#$ -l h_vmem=10G
#$ -l h_rt=20:00:00
#$ -t 1-22

chr=$SGE_TASK_ID

source /broad/software/scripts/useuse
reuse Anaconda

#Need $cohort, $phi, $n_trn2, $target; these parameters are added in "qsub -v ..."
trait=SCZ

dir=/stanley/huang_lab/home/Y.Ruan/SCZ.PRScsx/
PRScsx=/stanley/huang_lab/home/Y.Ruan/Software/PRScsx/PRScsx.py

ref_dir=/stanley/huang_lab/home/Y.Ruan/REF/
bim_prefix=$dir/Target/$target


python $PRScsx \
 --ref_dir=${ref_dir} \
 --bim_prefix=${bim_prefix} \
 --sst_file=${dir}/Base/PRScs-EUR.pgc2-${trait}.txt,${dir}/Base/PRScs-EAS.${cohort}-${trait}.txt \
 --n_gwas=77096,${n_trn2} \
 --pop=EUR,EAS \
 --chrom=${chr} \
 --phi=${phi} \
 --out_dir=${dir}/PRScsx-result \
 --out_name=EUR-EAS.${cohort}_${target}-$trait

