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
  # update taxo on SAU and data
  tar_target(SAU_taxo, add_gbif_backbone_taxonomy(data_sau)),
  tar_target(GHS_taxo, add_gbif_backbone_taxonomy(data_ghs)),
  #read the Global heterotroph stoichiometry data, returns a data.frame
  tar_target(dat_seaghs, the_function_that_merges),
  # merge both datasets
  tar_target(hist, create_plot(data)),
  #explore the data (custom function)
  tar_target(fit, lm(Ozone ~ Wind + Temp, data)) #model the data
)
