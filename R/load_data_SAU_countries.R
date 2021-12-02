##########################################################
# 2/12/2021
# Lola Gilbert lola.gilbert@univ-lr.fr
#
# load_data.R
# Script with functions to load the two datasets
##########################################################
library(tidyverse)

#' @title To load Sea Around Us countries data
#'
#'
#' @return raw data tibble

load_SAU_countries <- function() {

  SAU_Fr <- readr::read_csv(
    here::here("data",
               "SAU_countries",
               "SAU_France.csv")
  ) %>%
    dplyr::mutate(fishing_country = "France")

  SAU_Ire <- readr::read_csv(
    here::here("data",
               "SAU_countries",
               "SAU_Ireland.csv")
  ) %>%
    dplyr::mutate(fishing_country = "Ireland")

  SAU_UK <- readr::read_csv(
    here::here("data",
               "SAU_countries",
               "SAU_UK.csv")
  )

}
