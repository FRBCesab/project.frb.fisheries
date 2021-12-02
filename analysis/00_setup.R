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

# Use the renv package

renv::init()
