#!/bin/bash
#
#SBATCH --partition=normal
#SBATCH --ntasks=4
#SBATCH --mem 8G
#SBATCH --output=pseudomonas_trim_%J_stdout.txt
#SBATCH --error=pseudomonas_trim_%J_stderr.txt
#SBATCH --job-name=pseudomonas_trim
# 

bash /home/biol726302/BIOL7263_Genomics/scripts/pseudomonas/pseudomonas_trim.sh