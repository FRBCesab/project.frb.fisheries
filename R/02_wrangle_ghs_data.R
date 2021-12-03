#' wrangling_ghs_data
#'
#' @return a tibble containing species ID, taxonomy and chemical composition
#' @export
#'
#' @examples
#'
#'
wrangling_ghs_data <- function (pat) {
  # Read the data
  ghs_data <- readr::read_delim(pat)
  ghs_data <- data.frame(ghs_data)
  # clean column names

  names(ghs_data)<- tolower(names(ghs_data))
  character_columns <- which(sapply(ghs_data, class) == 'character')
  ghs_data[,character_columns] <- lapply(data.frame(ghs_data[,character_columns]), stringi::stri_trans_tolower)


  # Keeps only species
  ghs_data <- ghs_data[!is.na(ghs_data$species), ]

  # Keeps only marine species
  ghs_data <- ghs_data[which(ghs_data$habitat=="marine"), ]

  # As we don't want to compute averages of values of different statistical status
  # (averages of unknown n, unique observations) have different weights, we will have to choose one data per species instead
  # The number of data for each species is very often 1 or 2. It is therefore risky to compute median as it would result in averages.
  # For each species, if there are several data for the same variable
  # we keep the data coming from the reference having the most data

  list_sp <- unique(ghs_data$species_binomial)

  if (length(which(is.na(list_sp))) > 0) {
    list_sp <- list_sp[-which(is.na(list_sp))]
  }

  ghs_data_aggregated <- NULL
  mat_na <- 1 * !is.na(ghs_data) # Where are data
  col_choice <- c(
    which(names(ghs_data) == "c_mean"),
    which(names(ghs_data) == "n_mean"),
    which(names(ghs_data) == "p_mean"),
    which(names(ghs_data) == "cn_ratio"),
    which(names(ghs_data) == "cp_ratio"),
    which(names(ghs_data) == "np_ratio")
  )
  row_data_nb <- rep(NA, nrow(ghs_data))

  for (i in 1:length(list_sp)) {
    lines_species <- which(ghs_data$species_binomial == list_sp[i]) # select the lines of the current species
    if (length(lines_species) == 1) {

      ghs_data_aggregated <- dplyr::bind_rows(ghs_data_aggregated, ghs_data[lines_species,])
    } # if there is only on row for the current species, we keep that row
    else {
      combined_row <- ghs_data[lines_species[1],]

      for (j in col_choice) {
        if (sum(mat_na[lines_species, j]) == 0) {
          combined_row[1, j] <- NA
        }
        else if (sum(mat_na[lines_species, j]) == 1) {
          combined_row[1, j] <- ghs_data[lines_species[which(mat_na[lines_species, j] ==
                                                             1)], j]
        }
        else if (sum(mat_na[lines_species, j]) > 1) {
          for (k in lines_species) {
            row_data_nb[k] <- sum(mat_na[k, col_choice])
          }

          combined_row[1, j] <- ghs_data[lines_species[which(row_data_nb[lines_species] ==
                                                             max(row_data_nb[lines_species]))][1], j]
        }
      }
      ghs_data_aggregated <- dplyr::bind_rows(ghs_data_aggregated, combined_row[1,])
    }
  }

  # clean up to prepare for join for SAU data
  ghs_data_aggregated <- ghs_data_aggregated %>%
    # change column name with latin name to have the same as SAU data
    dplyr::rename(scientific_name = species_binomial) %>%
    # select only useful columns
    dplyr::select(scientific_name,
                  c_mean, n_mean, p_mean,
                  cn_ratio, cp_ratio, np_ratio)

  return(ghs_data_aggregated)

}
