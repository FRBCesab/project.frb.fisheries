#################################################



#################################################
# _targets.R file

library(targets)
# We source all functions contained in all files in the R directory
lapply(list.files(here::here("R"),
                  recursive = TRUE, full.names = T),
       source)


list(
  # define data files
  tar_target(data_sau_file,
             "data/SAU_LME_20_v48_0_1/SAU_LME_20_v48_0.csv",
             format = "file"), # Sea Around us data
  tar_target(data_ghs_file,
             "data/ghs/Global_heterotroph_stoichio_v5.csv",
             format = "file"), # GHS data
  # load data sau
  tar_target(data_sau, load_SAU(data_sau_file)),
  # clean data sau
  tar_target(data_sau_clean, clean_SAU(data_sau)),
  # load and clean ghs data
  tar_target(data_ghs_clean, wrangling_ghs_data(data_ghs_file)),
  # update taxo on SAU and data with taxonomy data
  tar_target(SAU_taxo, add_taxo_sau(data_sau_clean)),
  tar_target(GHS_taxo,
             add_gbif_backbone_taxonomy(
               dataframe = data_ghs_clean,
               speciescolumn = "scientific_name")),
  # merge both datasets
  tar_target(dat_merged, merge_files(SAU_taxo, GHS_taxo)),
  # complete calculation of C, N, P
  tar_target(final_tibble, format_merged(dat_merged)),
  # make plots
  tar_target(plot_landedval_sp, graph_barplot_ton(final_tibble)),
  tar_target(plot_CNP_exp, graphCNP_export(final_tibble)),
  tar_target(plot_flanded_nb_countries, graphton_nb_countries(final_tibble)),
  # generate report Rmd
  tarchetypes::tar_render(rmd_report, "manuscript/ProjectFisheries.Rmd")
)
