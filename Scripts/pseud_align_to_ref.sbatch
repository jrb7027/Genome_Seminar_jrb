#!/bin/bash
#
#SBATCH --partition=64gb_24core
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem 62G
#SBATCH --output=pseud_align_%J_stdout.txt
#SBATCH --error=pseud_align_%J_stderr.txt
#SBATCH --job-name=pseud_align
# 

bash /home/biol726302/BIOL7263_Genomics/scripts/pseudomonas/pseud_align_to_ref.sh