###########################################
#
#
#file name = graph1.r
#
#graph with species _ Landed values
###########################################

Graph_barplot_2 <- function(NorwayUKRussia) {
  ggplot(NorwayUKRussia,aes(year, landed_value, fill=common_name)) +
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
    #scale_fill_manual(name = "Species", )+
    facet_wrap(.~fishing_entity, nrow = 3)
}



#' @title Create graph of C, N, P export
#'
#'
#'
#' @return ggplot object
graphCNP_export <- function(data) {
  data %>%
    pivot_longer(cols = c(C_tonnage, N_tonnage, P_tonnage),
                 names_to = "nut_exp",
                 values_to = "tonnage") %>%
    ggplot() +
    aes(x = year, y = tonnage, fill = nut_exp) +
    geom_col() +
    facet_wrap(~ nut_exp)
}
