keep_top_proportion <- function(all_data, prop) {
  all_data %>%
    group_by(sample, amplicon) %>%
    count(htype) %>%
    mutate(proportion = n / sum(n)) %>%
    filter(proportion > prop) %>%
    summarise(n_dist = n(),
              htype_length = nchar(htype)[1],
              .groups = "drop")
}
