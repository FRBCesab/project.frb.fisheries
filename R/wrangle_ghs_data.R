#' wrangling_ghs_data
#'
#' @return a tibble containing species ID, taxonomy and chemical composition
#' @export
#'
#' @examples
#'
#'
wrangling_ghs_data <- function (ghs_data) {
  data <-
    readr::read_csv(here::here("data", "ghs", "Global_heterotrophs_stoichio_v5"))
  return(data)

}
