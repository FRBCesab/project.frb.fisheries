##########################################################
# 2/12/2021
# Lola Gilbert lola.gilbert@univ-lr.fr
#
# load_data.R
# Script with functions to load the two datasets
##########################################################

load_SAU <- function() {
  data_SAU <- readr::read_csv(
    here::here("data",
               "SAU LME 20 v48-0 (1)",
               "SAU LME 20 v48-0.csv")
  )

  data_SAU
}


