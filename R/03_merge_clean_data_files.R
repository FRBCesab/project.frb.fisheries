#####################################################
# 2/12/2021
# Celine Albert, Samuel Charberet, Lola Gilbert
#
# merge_clean_data_files.R
#
# Script with functions to merge both data files
#####################################################

#' @title Merge both files
#'
#'
#'
#' @return unique tibble to work on
merge_files <- function(tibble_SAU, tibble_CNP) {
  data <- tibble_SAU %>%
    # join the two tibbles
    dplyr::left_join(tibble_CNP, by = "scientific_name") %>%
    dplyr::filter(!is.na(c_mean))

  data
}

