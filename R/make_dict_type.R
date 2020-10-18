make_dict_type <- function(all_data) {
  fs::dir_info("data-raw/exprmntl-ctls-qualfilt/") %>%
    transmute(path = basename(path),
              path = str_remove(path, "\\.xlsx")) %>%
    left_join(read_xlsx("data-raw/ampliseq methylation key to all samples 9-20.xlsx", sheet = 3),
              by = c("path" = "Name")) %>%
    bind_cols(all_data) %>%
    select(Type, sample, description)
}
