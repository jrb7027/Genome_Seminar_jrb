#!/bin/bash
#
#SBATCH --partition=normal
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem 20G
#SBATCH --output=kallisto_index_%J_stdout.txt
#SBATCH --error=kallisto_index_%J_stderr.txt
#SBATCH --job-name=kallisto_index
# 

bash kallisto_index.sh