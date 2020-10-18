##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param amplicon_0.01_wide
##' @param nameme1
##' @return
##' @author EmilHvitfeldt
##' @export
pca_transform <- function(data, threshold) {
  recipe(sample ~ ., data = data) %>%
    step_meanimpute(all_predictors()) %>%
    step_pca(all_predictors(), threshold = threshold) %>%
    prep() %>%
    juice()
}
