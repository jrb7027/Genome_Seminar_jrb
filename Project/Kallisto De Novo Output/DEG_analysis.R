if (!requireNamespace('BiocManager', quietly = TRUE))
  install.packages('BiocManager')

BiocManager::install('EnhancedVolcano')
BiocManager::install("devtools")
BiocManager::install("pachterlab/sleuth")

library(sleuth)
library(tidyverse)  
library(EnhancedVolcano)
library(pheatmap)

#read in sample tables - be sure to set correct path 

metadata <- read.table(file = "ExpTable_TTC.txt", sep='\t', header=TRUE, stringsAsFactors = FALSE)

#this command sets up paths to the kallisto output that we will process in the following steps

metadata <- dplyr::mutate(metadata,
                          path = file.path('output', Run_s, 'abundance.h5'))
metadata <- dplyr::rename(metadata, sample = Run_s)

#Read in headers for the transcripts that we aligned to with kallisto
#These will be mapped in the sleuth_prep command below

ttn <- read_delim("TTC_headers.txt", delim = " ", col_names = FALSE)

colnames(ttn)<-c("target_id","gene","product")


#ALTERNATE
# Read the text file into R
lines <- readLines("TTC_headers.txt")

# Create an empty dataframe to store the extracted data
ttn <- data.frame(target_id = character(0), gene = character(0), product = character(0), stringsAsFactors = FALSE)

# Loop through each line and extract the required information
for (line in lines) {
  # Use regular expressions to extract the target_id, gene, and product
  target_id <- sub("^>([^|]+\\|[^|]+\\|[^|]+\\|[^|]+\\|).*", "\\1", line)  # Capture everything between the 1st and 4th '|'
  gene <- sub("^>[^|]+\\|([^|]+).*", "\\1", line)  # Extract gene between first and second '|'
  product <- sub("^>[^|]+\\|[^|]+\\|[^|]+\\|[^|]+\\|\\s*(.+)$", "\\1", line)  # Extract product after the last '|'
  
  # If gene or product is missing, set them to NA
  if (length(gene) == 0 || gene == "") {
    gene <- NA
  }
  if (length(product) == 0 || product == "" || product == target_id) {
    product <- NA
  }
  
  # Add the extracted data to the dataframe
  ttn <- rbind(ttn, data.frame(target_id = target_id, gene = gene, product = product, stringsAsFactors = FALSE))
}

# View the first few rows of the resulting dataframe
head(ttn)


# Remove the '>' symbol from the target_id
ttn$target_id <- gsub(">", "", ttn$target_id)


#create object so
so <- sleuth_prep(metadata, full_model = ~treat, target_mapping = ttn, extra_bootstrap_summary = TRUE, read_bootstrap_tpm = TRUE, aggregation_column = "gene")

#fit model specified above
so <- sleuth_fit(so)

#print the model
models(so)

#calculate the Wald test statistic for 'beta' coefficient on every transcript 
so <- sleuth_wt(so, 'treatUnarmored')

#extract the wald test results for each transcript 
transcripts_all <- sleuth_results(so, 'treatUnarmored', show_all = FALSE, pval_aggregate = FALSE)

#filtered by significance 
transcripts_sig <- dplyr::filter(transcripts_all, qval <= 0.05)

transcripts_50 <- dplyr::filter(transcripts_all, qval <= 0.05) %>%
  head(50)

transcripts_10 <- transcripts_all %>% head(10)

genes_all <- sleuth_results(so, 'treatUnarmored', show_all = FALSE, pval_aggregate = TRUE)

#extract the gene symbols, qval, and b values from the Wlad test results
forVolacano<-data.frame(transcripts_all$gene, transcripts_all$qval, transcripts_all$b)

#rename the columns of the dataframe
colnames(forVolacano)<-c("gene","qval","b")

genes_to_label <- forVolacano$gene[forVolacano$qval < 0.05]  # Example: label genes with qval < 0.05

# Sort the dataframe by qval
forVolacano <- forVolacano[order(forVolacano$qval), ]

# Select the top 3 genes by significance
top_genes <- head(forVolacano$gene, 3)

# Plot with EnhancedVolcano
EnhancedVolcano(forVolacano,
                lab = forVolacano$gene,
                x = 'b',
                y = 'qval',
                xlab = "\u03B2",
                labSize = 3,
                legendPosition = "none",
                selectLab = top_genes)
max.overlaps = (50) 
#plot
EnhancedVolcano(forVolacano,
                lab = forVolacano$gene,
                x = 'b',
                y = 'qval',
                xlab = "\u03B2",
                labSize = 3,
                legendPosition = "none")
max.overlaps = (50) 
#Heat Map
k_table <- kallisto_table(so, normalized = TRUE)

k_DEG <- k_table %>%
  right_join(transcripts_10, "target_id")

k_DEG_select<-k_DEG %>%
  #apply log10 transformation to the tpm data
  mutate(log_tpm = log10(tpm+1)) %>%
  #select the specifc columns to plot
  dplyr::select(target_id, sample, log_tpm, gene) %>%
  #create "label" from the transcript id and gene symbol
  mutate(label = paste(target_id, gene))%>%
  #pivot data frame to a wide format
  pivot_wider(names_from = sample, values_from = log_tpm) %>%
  #drop the target_id and gene variables
  dplyr::select(!target_id & !gene) %>%
  #convert label to row name
  column_to_rownames("label") %>%
  #convert to matrix
  as.matrix(rownames.force = TRUE) 

#plot with pheatmap!
pheatmap(k_DEG_select, cexRow = 0.4, cexCol = 0.4, scale = "none")

#Gene ontology analysis
#filter for transcripts enriched in the TTC treatment
transcripts_up <- dplyr::filter(transcripts_all, qval <= 0.05, b > 0)

up<-transcripts_up %>%
  dplyr::select(gene)

#filter for transcripts depleted in the TTC treatment
transcripts_down <- dplyr::filter(transcripts_all, qval <= 0.05, b < 0)

down<-transcripts_down %>%
  dplyr::select(gene)

#output the full transcript list
all<-transcripts_all %>%
  dplyr::select(gene)

#copy to clipboard and paste into ShinyGo website
writeClipboard(as.character(up))

#copy to clipboard and paste into ShinyGo "background"
writeClipboard(as.character(all))












str(ttn)
head(ttn)

head(metadata$path)

# Get target IDs from kallisto
tmp_names <- sleuth::get_target_mapping(metadata$path)

# Compare with ttn$target_id
intersect_ids <- intersect(ttn$target_id, tmp_names$target_id)
length(intersect_ids)  # Should be > 0

# Read one of the kallisto abundance files to inspect its content
library(rhdf5)

# Replace with a valid path to an example abundance.h5 file
example_h5 <- metadata$path[1]
kallisto_data <- h5read(example_h5, "aux/ids")

# Inspect the IDs
head(kallisto_data)

tmp_names <- unique(unlist(lapply(metadata$path, function(p) h5ls(p)$name)))
head(tmp_names)

head(ttn$target_id)

library(rhdf5)

# Extract `target_id` from the first Kallisto output file
tmp_names <- h5read(metadata$path[1], "/aux/ids")

# Check the extracted IDs
head(tmp_names)

# Remove any leading '>' from target_id
ttn$target_id <- sub("^>", "", ttn$target_id)

# Check alignment again
setdiff(tmp_names, ttn$target_id)

ttn$gene[is.na(ttn$gene)] <- "No Gene"



if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("rhdf5")
library(rhdf5)

# Replace 'path_to_abundance_file' with the actual path to your abundance.h5 file
abundance_file <- "output/AE3/abundance.h5"

# List all the datasets in the file
h5ls(abundance_file)

# Read the target_id dataset
target_ids <- h5read(abundance_file, "aux/ids")

# View the first few identifiers
head(target_ids)

# Remove the trailing '|' character from target_ids
target_ids <- sub("\\|$", "", target_ids)

# Verify the changes
head(target_ids)



# Ensure the target_id in ttn matches the cleaned target_ids
ttn$target_id <- sub("\\|$", "", ttn$target_id)

# Verify the changes
head(ttn$target_id)

# Check the unique identifiers in metadata
unique_metadata_ids <- unique(metadata$sample)
head(unique_metadata_ids)

# Check the unique identifiers in ttn
unique_ttn_ids <- unique(ttn$target_id)
head(unique_ttn_ids)