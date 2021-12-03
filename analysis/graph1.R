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

# Select by countries with the highest landed values
#
NorwayUKRussia<-filter(merged, fishing_entity==c("Norway", "United Kingdom", "Russian Federation"))

  ggplot(NorwayUKRussia,aes(year, landed_value, fill=fishing_entity)) +
  geom_bar(stat = "identity")+
  ylab ("Landed value")+xlab ("Year")+
    theme(panel.background = element_rect(fill = "white", colour = "white"),
          panel.grid.major = element_line(size = 0.5, linetype = 'solid', colour = "grey95"),
           panel.grid.minor = element_line(size = 0.25, linetype = 'solid', colour = "white"),
          axis.title.x = element_text(size = 9, face = "bold"),
          axis.text.x = element_text(size=9, angle = 60, hjust=1),
          strip.background=element_rect(colour="grey90", fill="grey95"),
          axis.title.y = element_text(size = 9, face = "bold"),
           axis.text.y = element_text(size=9))+
    facet_wrap(.~fishing_entity, nrow = 3)+
    scale_fill_manual(name = "Fishing entity", values=c("#999999", "#E69F00", "#56B4E9"))

#### de ce que je vois des données C ou N, on ne peut pas faire du temporel... Check the following graph.
  #Les valeurs se repètement d'une année à l'autre

  ggplot(NorwayUKRussia,aes(year, c_mean)) +
    geom_point()+
    ylab ("Carcone (C)")+xlab ("Year")
