#!/bin/bash
#
#SBATCH --partition=normal
#SBATCH --ntasks=1
#SBATCH --mem 16G
#SBATCH --output=ecoli_markdupindex_%J_stdout.txt
#SBATCH --error=ecoli_markdupindex_%J_stderr.txt
#SBATCH --job-name=ecoli_markdup
# 

bash /home/biol726302/BIOL7263_Genomics/scripts/BWA/ecoli_markdupindex.sh