#!/bin/bash
#
#SBATCH --partition=normal
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem 25G
#SBATCH --output=AH_denovo_%J_stdout.txt
#SBATCH --error=AH_denovo_%J_stderr.txt
#SBATCH --job-name=denovo
# 

bash AH_denovo.sh