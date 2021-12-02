###########################################
#
#
#file name = graph1.r
#
#graph with to Y axis
###########################################

SAU_data<-load_SAU()
cleaned_Data<-clean_SAU(SAU_data)

GHS<-wrangling_ghs_data()

merged<-merge_files(cleaned_Data, GHS)

str(merged)

ggplot(merged) +
  geom_point(aes(x=year, y = landed_value))

