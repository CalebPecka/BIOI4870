################################################################################
# Note: THIS SCRIPT WAS NOT CREATED AS A PRODUCT OF THE BIOI Spring 2022 CLASS.#
# IT WAS CREATED IN EXTERNAL RESEARCH WORK FOR THE UNIVERSITY OF OMAHA.        #
#                                                                              #
# The goal of this script is to generate interactive HTML plots that showcase  #
# Fuzzy ranking scores. The fuzzy ranking scores were calculated using close-  #
# source code. Results from the paper are in the process of being publicshed.  #
#                                                                              #
# Author: Caleb Pecka                                                          #
################################################################################

# Set the current working directory to the location of the R file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Import libraries
library(dplyr)
library(packcircles)
library(ggplot2)
library(viridis)
library(ggiraph)
library(htmlwidgets)
library(pals)

# Read in the files provided by KEGG metabolic modules
metabolic_pathways <- read.csv("../data/metabolicPathways.csv", header = F)
colnames(metabolic_pathways) <- c("ID", "Pathway Name")

# Read in fuzzy ranking scores generated with close source code (see
# file description at top of document)
CLDN1_metabolic <- read.csv("../data/CLDN1_Bact_Pathway_Fuzzy_Ranking.csv")
CLDN2_metabolic <- read.csv("../data/CLDN2_Bact_Pathway_Fuzzy_Ranking.csv")
CL3KO_metabolic <- read.csv("../data/CL3KO_Bact_Pathway_Fuzzy_Ranking.csv")

# Code can be repeated with the following different file names if you want to
# generate species level widget plots. If you do, be sure to change the file
# location commented at the bottom of the document.
# CLDN1_metabolic <- read.csv(paste0("../data/species_level_",
#                                    "CLDN1_Bact_Pathway_Fuzzy_Ranking.csv"))
# CLDN2_metabolic <- read.csv(paste0("../data/species_level_",
#                                    "CLDN2_Bact_Pathway_Fuzzy_Ranking.csv"))
# CL3KO_metabolic <- read.csv(paste0("../data/species_level_",
#                                    "CL3KO_Bact_Pathway_Fuzzy_Ranking.csv"))

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

# Assign ranks to the fuzzy ranking values to make them comparable. These will
# be used to generate normalized fuzzy ranking scores.
CLDN1_metabolic$Rank <- rank(CLDN1_metabolic$Value)
CLDN2_metabolic$Rank <- rank(CLDN2_metabolic$Value)
CL3KO_metabolic$Rank <- rank(CL3KO_metabolic$Value)

a <- CLDN1_metabolic
b <- CLDN2_metabolic
c <- CL3KO_metabolic

# One widget plot is created for each metabolic pathway
for (pathwayID in unique(c(a$`Pathway Name`, 
                           b$`Pathway Name`, 
                           c$`Pathway Name`))){
  
  # This section of code normalizes the fuzzy ranking values of all data
  # points on a scale of 0 to 100
  data_CLDN1 <- a[which(a$`Pathway Name` == pathwayID),c(1,3)]
  colnames(data_CLDN1) <- c("group", "value")
  data_CLDN1$value <- data_CLDN1$value/max(data_CLDN1$value) * 100
  
  data_CLDN2 <- b[which(b$`Pathway Name` == pathwayID),c(1,3)]
  colnames(data_CLDN2) <- c("group", "value")
  data_CLDN2$value <- data_CLDN2$value/max(data_CLDN2$value) * 100
  
  data_CL3KO <- c[which(c$`Pathway Name` == pathwayID),c(1,3)]
  colnames(data_CL3KO) <- c("group", "value")
  data_CL3KO$value <- data_CL3KO$value/max(data_CL3KO$value) * 100
  
  # A column is added to each phenotype vector with text. This text is displayed
  # when the user hovers over a bubble in the HTML widget.
  data_CLDN1$text <- paste(data_CLDN1$group, 
                           "\n\n", 
                           "Normalized Fuzzy Ranking:\n", 
                           data_CLDN1$value)
  data_CLDN2$text <- paste(data_CLDN2$group, 
                           "\n\n", 
                           "Normalized Fuzzy Ranking:\n", 
                           data_CLDN2$value)
  data_CL3KO$text <- paste(data_CL3KO$group, 
                           "\n\n", 
                           "Normalized Fuzzy Ranking:\n", 
                           data_CL3KO$value)
  
  # The layout of the bubbles requires complex circle packing calculations
  packing1 <- circleProgressiveLayout(data_CLDN1$value, sizetype='area')
  packing2 <- circleProgressiveLayout(data_CLDN2$value, sizetype='area')
  packing3 <- circleProgressiveLayout(data_CL3KO$value, sizetype='area')
  
  # The sizes of each packing plot are estimated for each phenotype
  packing2$x <- packing2$x + 100
  packing3$x <- packing3$x + 200
  
  # Calculations for each phenotype's space requirements are bound into 1 file
  data <- rbind(data_CLDN1, data_CLDN2)
  data <- rbind(data, data_CL3KO)
  packing <- rbind(packing1, packing2)
  packing <- rbind(packing, packing3)
  
  # Once the center of each plot area is calculated, a cirlce layout will
  # populate fuzzy ranking data points around the center, as closely packed
  # as possible.
  data <- cbind(data, packing)
  data$shortName <- unlist(lapply(strsplit(data$group, 
                                           split = " "), 
                                  function(x)x[1]))
  dat.gg <- circleLayoutVertices(packing, npoints=50)
  
  # A shortened name for each bacteria is included in the plot
  shortNameAddition <- c()
  for (i in data$shortName){
    shortNameAddition <- c(shortNameAddition, rep(i, 51))
  }
  dat.gg$shortName <- shortNameAddition
  
  # Colors for the plots are assigned
  colorCount = length(unique(data$shortName))
  colors = glasbey(colorCount)
  names(colors) <-as.factor(unique(data$shortName))
  
  # Generate a polygonal widget plot
  p <- ggplot() + 
    geom_polygon_interactive(data = dat.gg, 
                             aes(x, y, group = id, 
                                 fill=factor(shortNameAddition), 
                                 tooltip = data$text[id], 
                                 data_id = id), 
                             colour = "black", 
                             alpha = 0.6) +
    scale_fill_manual(values=colors) + 
    theme_void() + 
    theme(legend.title = element_blank(), 
          legend.position="bottom", legend.text = element_text(size=8), 
          plot.margin=unit(c(0,0,0,0),"cm") ) + 
    coord_equal() +
    annotate(geom="text", x=0, y=70, label="Claudin1-TG") +
    annotate(geom="text", x=100, y=70, label="Claudin2-TG") +
    annotate(geom="text", x=200, y=70, label="Claudin3-KO")
  
  # Add a ggiraph to make the plot interactive
  widg <- ggiraph(ggobj = p, width_svg = 7, height_svg = 4)
  
  # Save the widget
  saveWidget(widg, file=paste0( "../htmlWidgets/genusLevel/", 
                                gsub("/", "", pathwayID), ".html"))
  
  # The widgets can be saved to a different location if you wish to create
  # species level widget plots.
  # saveWidget(widg, file=paste0( "../htmlWidgets/speciesLevel/", 
  #                               gsub("/", "", pathwayID), ".html"))
}

