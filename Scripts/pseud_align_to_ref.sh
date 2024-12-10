#make a new folder for the mapping output
mkdir /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/

#make the index and write it to the new folder
bwa index -p /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/hybrid_assembly \
/scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/assembly/hybrid/contigs.fasta 

# map
bwa mem -t 6 /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/hybrid_assembly \
/scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/SRR491287_trimmed_reads_val_1.fq.gz \
/scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/SRR491287_trimmed_reads_val_2.fq.gz \
-o /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseud_illumina.sam

# convert to bam
samtools view -bS /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseud_illumina.sam > /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseudo_illumina.bam

# sort
samtools sort -o /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseudo_illumina_sorted.bam /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseudo_illumina.bam

# index
samtools index /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseudo_illumina_sorted.bam

# stats
samtools flagstat /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseudo_illumina_sorted.bam > /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseudo_illumina_sorted.stats

minimap2 -x map-pb -t 6 -a /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/assembly/hybrid/contigs.fasta \
/scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/SRR1042836_subreads.fastq.gz  \
-o /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseud_pacbio.sam

# convert to bam
samtools view -bS /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseud_pacbio.sam > /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseudo_pacbio.bam

# sort
samtools sort -o /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseudo_pacbio_sorted.bam /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseudo_pacbio.bam

# index
samtools index /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseudo_pacbio_sorted.bam

# stats
samtools flagstat /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseudo_pacbio_sorted.bam > /scratch/biol726302/BIOL7263_Genomics/pseudomonas_gm41/mapping_to_assembly/pseudo_pacbio_sorted.stats