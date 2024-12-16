#!/bin/bash
#
#SBATCH --partition=normal
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem 20G
#SBATCH --output=trimming_%J_stdout.txt
#SBATCH --error=trimming%J_stderr.txt
#SBATCH --job-name=trimming
#SBATCH --array=1-8
# 

bash AH_trim.sh $(sed -n "${SLURM_ARRAY_TASK_ID}p" AH_trim.args)