#!/bin/bash
#
#SBATCH --partition=normal
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem 30G
#SBATCH --output=blastdb_%J_stdout.txt
#SBATCH --error=blastdb_%J_stderr.txt
#SBATCH --job-name=blastdb
# 

bash /home/biol726302/BIOL7263_Genomics/scripts/assembly/blastn_de_novo.sh