# _targets.R file

library(targets)
# We source all functions contained in all files in the R directory
lapply(list.files(here::here("R"), recursive = TRUE, full.names = T), source)


list(
  tar_target(data_sau, load_SAU()),
  # reads the Sea Around Us data,  returns a data.frame
  tar_target(data_ghs, wrangle_ghs_data()),
  #read the Global heterotroph stoichiometry data, returns a data.frame
  tar_target(dat_seaghs, the_function_that_merges),
  # merge both datasets
  tar_target(hist, create_plot(data)),
  #explore the data (custom function)
  tar_target(fit, lm(Ozone ~ Wind + Temp, data)) #model the data
)
