##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param amplicon_0.01_wide
##' @param seed
##' @return
##' @author EmilHvitfeldt
##' @export
umap_transform <- function(data, seed) {
  recipe(sample ~ ., data = data) %>%
    step_meanimpute(all_predictors()) %>%
    step_umap(all_predictors(), num_comp = 2, seed = seed, neighbors = 5) %>%
    prep() %>%
    juice()
}
