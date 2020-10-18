#' Growing n distinct values
#'
#' Calculates number of unique values from the beginning to current location in
#' vector.
#'
#' At the 10th position of the output is the number of unique values in the
#' first 10 values of the input.
#'
#' @param x character vector
#'
#' @return integer vector

#' @examples
#' growing_n_distinct(c("a", "a", "b", "b", "a", "c"))
cpp_function("integers growing_n_distinct(strings x) {
  int n = x.size();
  writable::integers out(n);
  writable::strings cache;
  int n_unique = 0;

  for (int i = 0; i < n; i++) {
    if (std::find(cache.begin(), cache.end(), x[i]) != cache.end()) {
    } else {
      cache.push_back(x[i]);
      n_unique ++;
    }
    out[i] = n_unique;
  }

  return out;
}")
