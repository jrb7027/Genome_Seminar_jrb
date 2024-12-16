#!/bin/bash
#
#SBATCH --partition=normal
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem 30G
#SBATCH --output=blastn_%J_stdout.txt
#SBATCH --error=blastn_%J_stderr.txt
#SBATCH --job-name=blastn
# 

bash blastn.sh
