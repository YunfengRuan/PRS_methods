#!/bin/sh
#$ -cwd
#$ -j y
#$ -o $HOME
#$ -l h_vmem=10G
#$ -l h_rt=20:00:00
#$ -t 1-22

chr=$SGE_TASK_ID

source /broad/software/scripts/useuse
reuse Anaconda3

#Need $Base, $target, $phi, $n_trn, $pop, $OUT; these parameters are added in "qsub -v ..."

dir=/stanley/huang_lab/home/Y.Ruan/SCZ.PRScsx/
PRScs=/stanley/huang_lab/home/Y.Ruan/Software/PRScs/PRScs.py

ref_dir=/stanley/huang_lab/home/Y.Ruan/REF/ldblk_1kg_${pop}

python $PRScs \
 --ref_dir=${ref_dir} \
 --bim_prefix=$dir/Target/${target} \
 --sst_file=${dir}/Base/$Base \
 --n_gwas=${n_trn} \
 --chrom=${chr} \
 --phi=${phi} \
 --out_dir=${dir}/PRScs-result/$OUT

