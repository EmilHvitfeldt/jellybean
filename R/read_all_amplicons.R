read_amplicon <- function(sheet, data_folder, proportion) {
  fs::dir_ls(data_folder) %>% map_dfr(read_xlsx, sheet = sheet) %>%
    select(!starts_with("X")) %>%
    keep_top_proportion(proportion)
}

read_all_amplicons <- function(data_folder, proportion) {
  all_sheets <- fs::dir_ls(data_folder) %>%
    .[1] %>%
    excel_sheets()

  all_aplicon_reads <- map(all_sheets, safely(read_amplicon), data_folder, proportion)

  all_aplicon_reads[map_lgl(all_aplicon_reads, ~is.null(.x[["error"]]))] %>%
    map_dfr("result")
}
