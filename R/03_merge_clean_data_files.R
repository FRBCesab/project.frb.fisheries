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

  return(data)
}


#' @title Add water percent and transform tonnage to tons of C, N, P
#'
#'
#'
#' @return unique tibble to work on, with tonnage and equivalent
#'     export in C, N,P
format_merged <- function(tibble_merged) {
  data <- tibble_merged %>%
    dplyr::mutate(# convert % dry mass means into dry weight concentrations
                  # with a 80% water content
                  # unit g/ton
                  c_g_per_t = (c_mean/5)*1e4,
                  n_g_per_t = (n_mean/5)*1e4,
                  p_g_per_t = (p_mean/5)*1e4,
                  # compute equivalent export of C, N, P, in tons
                  C_tonnage = c_g_per_t*landed_value*1e-6,
                  N_tonnage = n_g_per_t*landed_value*1e-6,
                  P_tonnage = p_g_per_t*landed_value*1e-6,
                  )

  return(data)
}

