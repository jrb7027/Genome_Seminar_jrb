#script to merge orf bed file from orfipy with the blastp predictions

require(tidyverse)

#load files
bed<-read_table("orfs.bed", col_names = FALSE)
blast<-read_table("orf_best_hit.txt", col_names = FALSE)

#process the bed file to pull out the transcript ID
b_names <- bed %>%
  separate_wider_delim(X4, delim = "=", names = c(NA, "name", NA), too_many = "drop") %>%
  separate_wider_delim(name, delim = ";", names = c("name"), too_many = "drop") %>% select(X1:name, X6)

#process the blast results to reformat gene symbol
blast$gene <- str_remove(blast$X4, 
                pattern = "\\[gene=") %>%
  str_remove(pattern = "\\]")

blast_gene <- blast %>%
  select(X1, gene, X3)

#merge the bed file with the blastp result
bed_gene<-left_join(b_names, blast_gene, by = join_by (name == X1))

#reorder to specification of https://genome.ucsc.edu/FAQ/FAQformat.html#format1
bed_gene_reord <- tibble(bed_gene[,1:3],bed_gene[,6],bed_gene[,7], bed_gene[,5])

#output bed file to me loaded into IGV
write_delim(bed_gene_reord, delim = "\t", file = "orfs_gene.bed", col_names = FALSE)
