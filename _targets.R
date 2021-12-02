# _targets.R file

library(targets)
source("R/functions.R")

list(
  tar_target(raw_data_file, "data/raw_data.csv", format = "file"
  ), #make the workflow depends on the raw data file
  tar_target(raw_data, read_csv(raw_data_file)
  ), #read the data, return a data.frame
  tar_target(data,
             raw_data %>% filter(!is.na(Ozone))
  ), #transform the data
  tar_target(hist, create_plot(data)), #explore the data (custom function)
  tar_target(fit, lm(Ozone ~ Wind + Temp, data)) #model the data
)
