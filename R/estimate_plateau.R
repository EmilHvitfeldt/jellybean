#' Estimate the plateau value for fitted Michaelis-Menten equation
#'
#' https://www.statforbiology.com/nonlinearregression/usefulequations
#'
#' @param x character variable
#'
#' @return single nuemric.
#' @export
#'
#' @examples
#' estimate_plateau(sample(letters, 20, replace = TRUE))
estimate_plateau <- function(x) {
  suppressWarnings(
    model <- drm(growing_n_distinct(x) ~ seq_along(x), fct = MM.2())
  )
  model$fit$par[1]
}
