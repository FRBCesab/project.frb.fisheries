##########################################################
# 2/12/2021
# Lola Gilbert lola.gilbert@univ-lr.fr
#
# load_data.R
# Script with functions to load the two datasets
##########################################################
library(tidyverse)

#' @title To load Sea Around Us data
#'
#'
#' @return raw data tibble

load_SAU <- function() {
  data_SAU <- readr::read_csv(
    here::here("data",
               "SAU LME 20 v48-0 (1)",
               "SAU LME 20 v48-0.csv")
  )

  data_SAU
}


#' @title Clean up Sea Around Us tibble
#'
#'
#' @return cleaned Sea Around Us tibble

clean_SAU <- function(data_tibble) {
  SAU_clean <- data_tibble %>%
    dplyr::select(area_name, year, functional_group,
                  common_name, scientific_name,
                  commercial_group, fishing_entity,
                  fishing_sector, catch_type, gear_type,
                  end_use_type, landed_value) %>% # select useful columns
    dplyr::filter(stringr::str_detect(scientific_name, " ")) %>%
    dplyr::filter(!(
      stringr::str_detect(scientific_name, "not identified")),
      !(
        stringr::str_detect(scientific_name, "Miscellaneous"))
      ) %>% # keep only when identified up to species level
    dplyr::mutate(scientific_name = stringr::str_to_lower(scientific_name)
                  )

    SAU_clean
}

renv::restore()

