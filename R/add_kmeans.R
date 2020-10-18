##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param amplicon_pca
##' @param nameme1
##' @param nameme2
##' @return
##' @author EmilHvitfeldt
##' @export
add_kmeans <- function(data, variables, clusters) {
  data %>%
    select( {{variables}} ) %>%
    kmeans(centers = clusters) %>%
    broom::augment(data)
}
