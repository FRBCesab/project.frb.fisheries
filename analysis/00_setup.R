##############################################
#02/12/2021
# Celine Albert, Samuel Charberet, Lola Gilbert
#
# 00_setup.R
#
# projet FRB CESAB
# compendium creation and set.up
##############################################

# compendium creation
library(rrtools)

rrtools::use_compendium(path = "../project.frb.fisheries/",
                        open = FALSE)

# set up
dir.create("data")
dir.create("outputs")
dir.create("analysis")
dir.create("R")
dir.create("manuscript")
dir.create("Image")

# Create a load data function
file.create("R/import_data.R")
file.rename(from = "R/import_data.R",
            to = "R/load_data.R")

# Use the renv package
renv::init()

#package ghibli
install.packages('ghibli')

#load package
library(ghibli)

# display palettes w/ names
par(mfrow=c(9,3))
for(i in names(ghibli_palettes)) print(ghibli_palette(i))

# create Rmarkdown file
file.create("manuscript/ProjectFisheries.Rmd")

# create R function script to merge both data files
file.create("R/merge_clean_data_files.R")

# create script to run at the end to update DESCRIPTION file with
# all packages used
file.create("analysis/update_description.R")

# order scripts with numbers
file.rename("R/load_clean_data_SAU.R", "R/01_load_clean_data_SAU.R")
file.rename("R/wrangle_ghs_data.R", "R/02_wrangle_ghs_data.R")
file.rename("R/merge_clean_data_files.R", "R/03_merge_clean_data_files.R")
