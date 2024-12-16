#!/bin/bash
#
#SBATCH --partition=normal
#SBATCH --ntasks=1
#SBATCH --mem 16G
#SBATCH --output=Aheterochaelis_fastqc_%J_stdout.txt
#SBATCH --error=Aheterochaelis_fastqc_%J_stderr.txt
#SBATCH --job-name=Aheterochaelis_fastqc
# 

bash /home/biol726302/Project/Scripts/fastqc/Aheterochaelis_fastqc_8_r2.sh
