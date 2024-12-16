#!/bin/bash
#
#SBATCH --partition=normal
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem 25G
#SBATCH --output=crust_blastsb%J_stdout.txt
#SBATCH --error=crust_blastdb%J_stderr.txt
#SBATCH --job-name=blastdb
# 

bash make_blast_db_crust.sh