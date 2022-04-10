################################################################################
# The goal of this script is to convert specific data sources into formatting  #
# compatible with SQL insert statements. This script is not utilized in the    #
# final website, but it is valuable for data recreation.                       #
#                                                                              #
# Author: Caleb Pecka                                                          #
################################################################################

# Set the current working directory to the location of the R file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# The first SQL table we will format is for metabolic_pathways
# Open the Metabolic Pathways file
met_path <- read.csv("../data/metabolicPathways.csv", header = F)

# Create an empty list
entries <- c()

# Reformat the data into DML statements for SQL
for (i in 1:nrow(met_path)){
  entry <- paste0("INSERT INTO metabolic_pathways VALUES (\n", 
         "  '", met_path$V1[i], "',\n",
         "  '", met_path$V2[i], "'\n",
         ");")
  entries <- c(entries, entry)
}

# Write these reformatted entries into a DML text file
lapply(entries, write, "../data/metabolicPathwaysDML.txt", 
       append=TRUE, ncolumns=1000)

################################################################################
# This next segment of code attempts to collect information about bacterial    #
# species from KEGG, which requires a small amount of web scraping.            #
################################################################################
library(rvest)
library(xml2)

# A list of bacterial organisms was extracted from an htext download off of
# KEGG's brite list of organisms: https://www.genome.jp/brite/br08601.keg
# Eukaryotes and archea were manually curated to be removed from this list,
# meaning all remaining values of "level E" were codes for bacterial species.
# These codes are extracted in the following few lines.
briteHierarchy <- read.table("../data/br08601.keg", sep = "\t")
briteCodes <- briteHierarchy$V1[grep("E    ", briteHierarchy$V1)]
briteCodes <- gsub("E *", "", briteCodes)

# Performing a 4 length substring and removing whitespace accounts for both
# 3 character and 4 character length brite codes
briteCodes <- unlist(lapply(briteCodes, substr, 0, 4))
briteCodes <- gsub(" ", "", briteCodes)

# Create an empty list to populate bacterial SQL entries
bacterialEntries <- c()

# Now we need to scrape several thousand web pages. This function is used to
# tell our program to wait for a few seconds before loading a new page.
waitTime <- function(x)
{
  p1 <- proc.time()
  Sys.sleep(x)
  proc.time() - p1
}

# Create an insert statement for each org code.
for (org_code in unique(briteCodes)){
  
  # Wait 1 second before loading a new page.
  waitTime(1.0)
  
  # Reset text values
  commentExtraction <- "NULL"
  lineageLevels <- "NULL"
  nameTextList <- "NULL"
  
  # Read the organism XML page
  page <- read_html(paste0("https://www.genome.jp/kegg-bin/show_organism?org=", 
                           org_code))
  
  # Navigate through XML nodes until we find specific sections that we are
  # looking for, including Comments, Name, and Lineage.
  bodySections <- page %>% html_elements("body")
  table <- xml_child(bodySections[[1]], 3)
  table2 <- xml_child(table, 2)
  orgInfo <- xml_child(xml_child(xml_child(xml_child(xml_child(table2, 
                                                              1), 1), 1), 1), 5)
  for (i in 1:length(xml_contents(orgInfo))){
    tmp <- xml_contents(xml_child(orgInfo, i))
    tmpNodeSet <- xml_contents(tmp[[1]]) %>% xml_text()
    
    # Comment node found
    if (tmpNodeSet == "Comment"){
      commentNodeSet <- xml_contents(tmp[[2]])
      commentTextList <- commentNodeSet %>% xml_text()
      
      # Reformat the XML elements into a readable string. This involves removing
      # unnecessary white space at the beginning of every new line.
      commentExtraction <- paste0(gsub("^ *", " ", commentTextList), 
                                  collapse = '')
    }
    
    # Lineage node found. Lineage include information about the phylum, genus,
    # species, etc.
    if (grepl("Lineage", tmpNodeSet)){
      lineageNodeSet <- xml_contents(tmp[[2]])
      lineageTextList <- lineageNodeSet %>% xml_text()
      
      # Lineage must be split by semicolon to order based on taxonomic hierarchy
      # levels. White space is also removed in this step.
      lineageLevels <- strsplit(lineageTextList, ";")
      lineageLevels <- gsub(" ", "", lineageLevels[[1]])
    }
    
    # Any species and strain information are stored in the XML Name Node
    if (tmpNodeSet == "Name"){
      nameNodeSet <- xml_contents(tmp[[2]])
      nameTextList <- nameNodeSet %>% xml_text()
    }
  }
  
  # We can append the original lineage with the Name node to get a full lineage
  fullLineage <- c(lineageLevels, nameTextList)
  
  # Finally, some lineages are not complete. In these instances, we fill the
  # remaining taxonomic lineages with NULL values. This is necessary in cases
  # when the taxonomic hierarchy ends at the genus level, for example, and 
  # species information is not available. The length is unneccessarily long
  # to handle unclassified strains.
  fullLineage <- c(fullLineage, rep("NULL", 10 - length(fullLineage)))
  
  # Reformat the data into DML statements for SQL
  entry <- paste0("INSERT INTO bacteria VALUES (\n", 
                  "  '", org_code, "',\n",
                  "  '", fullLineage[1], "'\n",
                  "  '", fullLineage[2], "'\n",
                  "  '", fullLineage[3], "'\n",
                  "  '", fullLineage[4], "'\n",
                  "  '", fullLineage[5], "'\n",
                  "  '", fullLineage[6], "'\n",
                  "  '", fullLineage[7], "'\n",
                  "  '", commentExtraction, "'\n",
                  "  '", nameTextList, "'\n",
                  ");")
  entry <- gsub("'NULL'", "NULL", entry)
  bacterialEntries <- c(bacterialEntries, entry)
}

# Write these reformatted entries into a DML text file
lapply(bactrialEntries, write, "../data/baceterialDML.txt", 
       append=TRUE, ncolumns=1000)

################################################################################
# This next segment of code reorganizes our fuzzy ranking scores into DML      #
# statements. For more information about how these fuzzy ranking scores were   #
# acquired, view scripts/interactiveWidgetPlots.R.                             #
################################################################################

# Read in the files provided by KEGG metabolic modules
metabolic_pathways <- read.csv("../data/metabolicPathways.csv", header = F)
colnames(metabolic_pathways) <- c("ID", "Pathway Name")

# Read in fuzzy ranking scores
CLDN1_metabolic <- read.csv("../data/CLDN1_Bact_Pathway_Fuzzy_Ranking.csv")
CLDN2_metabolic <- read.csv("../data/CLDN2_Bact_Pathway_Fuzzy_Ranking.csv")
CL3KO_metabolic <- read.csv("../data/CL3KO_Bact_Pathway_Fuzzy_Ranking.csv")

species_CLDN1_metabolic <- read.csv(paste0("../data/species_level_",
                                  "CLDN1_Bact_Pathway_Fuzzy_Ranking.csv"))
species_CLDN2_metabolic <- read.csv(paste0("../data/species_level_",
                                  "CLDN2_Bact_Pathway_Fuzzy_Ranking.csv"))
species_CL3KO_metabolic <- read.csv(paste0("../data/species_level_",
                                  "CL3KO_Bact_Pathway_Fuzzy_Ranking.csv"))

# Attach the names of the metabolic pathways to the existing map ids
CLDN1_metabolic <- left_join(CLDN1_metabolic, 
                             metabolic_pathways, 
                             by = c("Pathway" = "ID"))
CLDN2_metabolic <- left_join(CLDN2_metabolic, 
                             metabolic_pathways, 
                             by = c("Pathway" = "ID"))
CL3KO_metabolic <- left_join(CL3KO_metabolic, 
                             metabolic_pathways, 
                             by = c("Pathway" = "ID"))

species_CLDN1_metabolic <- left_join(species_CLDN1_metabolic, 
                             metabolic_pathways, 
                             by = c("Pathway" = "ID"))
species_CLDN2_metabolic <- left_join(species_CLDN2_metabolic, 
                             metabolic_pathways, 
                             by = c("Pathway" = "ID"))
species_CL3KO_metabolic <- left_join(species_CL3KO_metabolic, 
                             metabolic_pathways, 
                             by = c("Pathway" = "ID"))

# Rows most be appended to these tables to dictate their phenotype information.
CLDN1_metabolic$genotype <- rep("CLDN1", nrow(CLDN1_metabolic))
CLDN2_metabolic$genotype <- rep("CLDN2", nrow(CLDN2_metabolic))
CL3KO_metabolic$genotype <- rep("CL3KO", nrow(CL3KO_metabolic))
species_CLDN1_metabolic$genotype <- rep("CLDN1", nrow(species_CLDN1_metabolic))
species_CLDN2_metabolic$genotype <- rep("CLDN2", nrow(species_CLDN2_metabolic))
species_CL3KO_metabolic$genotype <- rep("CL3KO", nrow(species_CL3KO_metabolic))

# Rows must have one final value appended to identify whether they belong
# to a genus level fuzzy ranking score or a species level fuzzy ranking score.
CLDN1_metabolic$studyType <- rep("genus", nrow(CLDN1_metabolic))
CLDN2_metabolic$studyType <- rep("genus", nrow(CLDN2_metabolic))
CL3KO_metabolic$studyType <- rep("genus", nrow(CL3KO_metabolic))
species_CLDN1_metabolic$studyType <- rep("species", 
                                         nrow(species_CLDN1_metabolic))
species_CLDN2_metabolic$studyType <- rep("species", 
                                         nrow(species_CLDN2_metabolic))
species_CL3KO_metabolic$studyType <- rep("species", 
                                         nrow(species_CL3KO_metabolic))

# All of these datasets are bound together
mergedFuzzyRanking <- rbind(CLDN1_metabolic, CLDN2_metabolic)
mergedFuzzyRanking <- rbind(mergedFuzzyRanking, CL3KO_metabolic)
mergedFuzzyRanking <- rbind(mergedFuzzyRanking, species_CLDN1_metabolic)
mergedFuzzyRanking <- rbind(mergedFuzzyRanking, species_CLDN2_metabolic)
mergedFuzzyRanking <- rbind(mergedFuzzyRanking, species_CL3KO_metabolic)

# Create an empty list
entries <- c()

# Reformat the data into DML statements for SQL
for (i in 1:nrow(mergedFuzzyRanking)){
  entry <- paste0("INSERT INTO fuzzy_ranking VALUES (\n", 
                  "  ", i, ",\n",
                  "  ", mergedFuzzyRanking$Value[i], ",\n",
                  "  '", mergedFuzzyRanking$genotype[i], "'\n",
                  "  '", mergedFuzzyRanking$studyType[i], "'\n",
                  "  '", mergedFuzzyRanking$Bacterium[i], "'\n",
                  "  '", mergedFuzzyRanking$Pathway[i], "'\n",
                  ");")
  entries <- c(entries, entry)
}

# Write these reformatted entries into a DML text file
lapply(entries, write, "../data/fuzzyRankingDML.txt", 
       append=TRUE, ncolumns=1000)

