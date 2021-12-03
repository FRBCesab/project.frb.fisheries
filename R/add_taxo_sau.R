#' add_taxo_sau
#'
#' @return the temporal series with taxonomic information
#' @export
#'
#' @examples
#'
#'
add_taxo_sau = function(data_sau_clean) {
  list_sp_df = data.frame(unique(data_sau_clean$scientific_name), NA)
  names(list_sp_df) = c("list_sp_col", NA)
  gbif_sau = add_gbif_backbone_taxonomy(dataframe = list_sp_df, speciescolumn = "list_sp_col")
  gbif_sau = gbif_sau[,-2]
  list_sp_sau_ts = unique(data_sau_clean$scientific_name)
  list_sp_sau_gbif = unique(gbif_sau$species_gbif)
  data_sau_clean[, colnames(gbif_sau)] = NA

  for (i in 1:length(list_sp_sau_gbif)) {
    species_rows = which(data_sau_clean$scientific_name == list_sp_sau_gbif[i])
    data_sau_clean[species_rows, colnames(gbif_sau)] = gbif_sau[i, colnames(gbif_sau)]
  }
  return(data_sau_clean)
}
