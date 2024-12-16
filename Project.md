# My Project

## Project Background
 * My study system is *Alpheus heterochaelis* a species of snapping shrimp. They can create cavitation bubbles with the snap of their claw. These shock waves can cause brain damage if their natural armor, known as orbital hoods, are removed or damaged. This hoods protect the eyes and in turn the brains of these shrimp in the event of these shock waves they can produce. 

 * My research questions
  * Are genes differentially expressed in the brains of brain damaged snapping shrimp?
  * What genes are differentially expressed in the brains of brain damaged snapping shrimp?
  * Why may those genes be differentially expressed in the brains of brain damaged snapping shrimp?
 * I hypothesize that I will find a multiple genes which show differential gene expression between the experimental groups.
 * This study started by collecting brains from both shrimp who were exposed to a shock wave with and without their orbital hoods. There brains were then removed and transcriptome reads were taken. Here I completed a de novo assembly and kallisto pseudoalignment allowing for differential gene expression analysis between the experimental groups. 
 
## Data Sources
 * This data game from my lab.
 * This data was sequenced as paired short reads. 
 * Samples and conditions
  *  AC2 - Armored Control, Small Size
  *  AE1 - Armored Experimental, Very Small Size
  *  AE2 - Armored Experimental, Small Size, bad quality
  *  AE3 - Armored Experimental, Large, good quality
  *  AE4 - Armored Experimental, Average size, good quality
  *  UE1 - Unarmored Experimental, Large, good quality
  *  UE2 - Unarmored Experimental, Large , good quality
  *  UE4 - Unarmored Experimental, Small Size
  *  UE5 - Unarmored Experimental, Very Small Size
  
## Analysis and Results

### QC
 * [Aheterochaelis_fastqc.sh](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/fastqc/Aheterochaelis_fastqc.sh)
 * [Aheterochaelis_fastqc.sbatch](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/fastqc/Aheterochaelis_fastqc.sbatch)
 * The only unusable read quality was AE2. This one was not used for any of the further analysis. The rest had decent quality but some were small like AE1 and UE5 and were also not used for further analysis.
 * ![AE2 Results](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/FastQc/3%20result%202.png)
 
### Cross Species Kallisto
 * [kallisto_index.sh](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/Kallisto/kallisto_index.sh)
 * [kallisto_index.sbatch](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/Kallisto/kallisto_index.sbatch)
 * [Kallisto_quant.sh](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/Kallisto/kallisto_quant.sh)
 * [Kallisto_quant.sbatch](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/Kallisto/kallisto_quant.sbatch)
 * [Kallisto_quant.args](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/Kallisto/kallisto_quant.args)
 
### Differntial Gene Expression of Cross Species Kallisto
 * [DEG_analysis.R](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Kallisto%20De%20Novo%20Output/DEG_analysis.R)
 * [ExpTable_TTC.txt](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Kallisto%20De%20Novo%20Output/ExpTable_TTC.txt)
 * ![Volcano_Plot_AH_PC.svg](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Kallisto%20De%20Novo%20Output/Volcano_Plot_AH_PC.svg)
 * ![Heatmap_AH_PC.svg](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Kallisto%20De%20Novo%20Output/Heatmap_AH_PC.svg)

### Trimming
 * [AH_trim.sh](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/Trimming/AH_trim.sh)
 * [AH_trim.sbatch](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/Trimming/AH_trim.sbatch)
 * [AH_trim.args](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/Trimming/AH_trim.args)
 
### De novo
 * [AH_denovo.sh](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/De%20Novo/AH_denovo.sh)
 * [AH_denovo.sbatch](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/De%20Novo/AH_denovo.sbatch)

### BLASTn Annotation
 * [make_blast_db_crust.sh](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/Database/make_blast_db_crust.sh)
 * [make_blast_db_crust.sbatch](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/Database/make_blast_db_crust.sbatch)
 * [blastn.sh](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/BLAST/blastn.sh)
 * [blastn.sbatch](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Scripts/BLAST/blastn.sbatch)

### Differntial Gene Expression of De novo
 * [DEG_analysis.R](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Kallisto%20De%20Novo%20Output/DEG_analysis.R)
 * [ExpTable_TTC.txt](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Kallisto%20De%20Novo%20Output/ExpTable_TTC.txt)
 * ![Volcano_Plot_AH_De_Novo.svg](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Kallisto%20De%20Novo%20Output/Volcano_Plot_AH_De_Novo.svg)
 * ![Heatmap_AH_De_Novo.svg](https://github.com/jrb7027/Genome_Seminar_jrb/blob/main/Project/Kallisto%20De%20Novo%20Output/Heatmap_AH_De_Novo.svg)

## Conclusions
 * The class has taught me a lot of useful skills that were completely foreign to me before. At the start of this class everything we were going to learn seemed very daunting however after some time things became far less scary. I now feel like I have a solid foundation on which I can build in the future to analyze transciptomic and genomic data. 
 * The key results that I found were the few differentially expressed genes and that the ones that could be identified seemed to be connected to stress responses or tissue damage. This suggests that certain pathways may be used more during the stress response to brain damage caused by their own shock waves in the event that their orbital hood is damaged or missing. 
 * Future steps will be to run the transcriptomes again and try to get better quality and longer reads so we can get a larger picture into what is going on. I may also want to try using or making a new database for my annotations so that they, one, work better and, two, have a larger spread of identified genes. 