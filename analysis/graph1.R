###########################################
#
#
#file name = graph1.r
#
#graph with to Y axis
###########################################
library(tidyverse)
SAU_data<-load_SAU()
cleaned_Data<-clean_SAU(SAU_data)

GHS<-wrangling_ghs_data()

merged<-merge_files(cleaned_Data, GHS)

str(merged)
merged$year<- as.factor(merged$year)
merged$fishing_entity<- as.factor(merged$fishing_entity)

#Filter by countries with the highest landed values


  ggplot(merged,aes(year, landed_value)) +
  geom_bar(aes(fill=fishing_entity),stat = "identity")+
  ylab ("Landed value")+
  theme(strip.text.x = element_text(size=11))+
  theme(panel.background = element_rect(fill = "grey92", colour = "white"),
        panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                        colour = "white"),
        panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                        colour = "white"),axis.title.x = element_text(size = 9, face = "bold"),
        axis.text.x = element_text(size=9,angle = 60, hjust=1))+
  theme(axis.title.y = element_text(size = 9, face = "bold"), axis.text.y = element_text(size=9))+
  xlab ("Year")+ facet_wrap(.~fishing_entity)

