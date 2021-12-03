#################################################



#################################################
# _targets.R file

library(targets)
# We source all functions contained in all files in the R directory
lapply(list.files(here::here("R"),
                  recursive = TRUE, full.names = T),
       source)


list(
  # load and clean both data files
  tar_target(data_sau, load_SAU()), # Sea Around us data
  tar_target(data_ghs, wrangle_ghs_data()), # CNP data
  # update taxo on SAU and data with taxonomy data
  tar_target(SAU_taxo, add_gbif_backbone_taxonomy(data_sau)),
  tar_target(GHS_taxo, add_gbif_backbone_taxonomy(data_ghs)),
  # merge both datasets
  tar_target(dat_merged, merge_files(SAU_taxo, GHS_taxo)),
  # complete calculation of C, N, P
  tar_target(final_tibble, format_merged(dat_merged)),
  # make plots
  tar_target(plot_landedvalue_species, Graph_barplot_2),
  #explore the data (custom function)
  #tar_target(fit, lm(Ozone ~ Wind + Temp, data)) #model the data
)
