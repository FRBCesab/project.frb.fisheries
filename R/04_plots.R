###########################################
#
#
#file name = 04_plots.R
#
#functions generating graphs
###########################################
graph_barplot_ton <- function(tibble) {
  # filter on countries, we want just Norway UK and Russia
  tibble %>%
    dplyr::filter(fishing_entity %in% c("Russian Federation",
                                        "Norway",
                                        "United Kingdom")) %>%
    ggplot() +
    aes(year, landed_value, fill = scientific_name) +
    geom_bar(stat = "identity")+
    ylab ("Landed tonnage (tons)") +
    xlab ("Year") +
    theme(panel.background = element_rect(fill = "white", colour = "white"),
          panel.grid.major = element_line(size = 0.5, linetype = 'solid', colour = "grey95"),
          panel.grid.minor = element_line(size = 0.25, linetype = 'solid', colour = "white"),
          axis.title.x = element_text(size = 9, face = "bold"),
          axis.text.x = element_text(size=9, angle = 60, hjust=1),
          strip.background=element_rect(colour="grey90", fill="grey95"),
          axis.title.y = element_text(size = 9, face = "bold"),
          axis.text.y = element_text(size=9)) +
    scale_fill_manual(name = "Species",
                      values = c("#446590FF", "#2D2A25FF",
                                 "#534C53FF", "#583B2BFF")) +
    #ghibli::scale_fill_ghibli_d(name = "PonyoMedium", direction = - 1) +
    facet_wrap(.~ fishing_entity, nrow = 3)
}



#' @title Create graph of C, N, P export
#'
#'
#'
#' @return ggplot object
graphCNP_export <- function(data) {
  data %>%
    tidyr::pivot_longer(cols = c(C_tonnage, N_tonnage, P_tonnage),
                 names_to = "nut_exp",
                 values_to = "tonnage") %>%
    dplyr::mutate(nut_exp = case_when(nut_exp == "C_tonnage" ~ "C",
                                      nut_exp == "N_tonnage" ~ "N",
                                      nut_exp == "P_tonnage" ~ "P")) %>%
    ggplot() +
    aes(x = year, y = tonnage, fill = nut_exp) +
    geom_col() +
    facet_wrap(~ nut_exp) +
    xlab("Year") + ylab("Total export (tons)") +
    scale_fill_manual(values = c("#278B9AFF", "#E75B64FF", "#D8AF39FF")) +
    #ghibli::scale_fill_ghibli_d(name = "MononokeMedium", direction = -1)
    theme(panel.background = element_rect(fill = "white", colour = "white"),
          panel.grid.major = element_line(size = 0.5, linetype = 'solid', colour = "grey95"),
          panel.grid.minor = element_line(size = 0.25, linetype = 'solid', colour = "white"),
          axis.title.x = element_text(size = 9, face = "bold"),
          axis.text.x = element_text(size=9, angle = 60, hjust=1),
          strip.background=element_rect(colour="grey90", fill="grey95"),
          axis.title.y = element_text(size = 9, face = "bold"),
          axis.text.y = element_text(size=9),
          legend.position = "none")
}

#' @title Create graph f(total_tonnage) = nb_countries
#'
#'
#'
#' @return ggplot object
graphton_nb_countries <- function(data) {
  data %>%
    dplyr::group_by(year) %>%
    dplyr::summarize(ton_tot = sum(landed_value),
                     nb_countries = length(unique(fishing_entity))) %>%
    ggplot() +
    aes(x = nb_countries, y = ton_tot) +
    geom_point() +
    xlab("Nb of countries fishing in the Barents Sea") + ylab("Total tonnage (tons)") +
    theme(panel.background = element_rect(fill = "white", colour = "white"),
          panel.grid.major = element_line(size = 0.5, linetype = 'solid', colour = "grey95"),
          panel.grid.minor = element_line(size = 0.25, linetype = 'solid', colour = "white"),
          axis.title.x = element_text(size = 9, face = "bold"),
          axis.text.x = element_text(size=9, angle = 60, hjust=1),
          strip.background=element_rect(colour="grey90", fill="grey95"),
          axis.title.y = element_text(size = 9, face = "bold"),
          axis.text.y = element_text(size=9),
          legend.position = "none")
}
