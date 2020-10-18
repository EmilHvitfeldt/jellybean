the_plan <-
  drake_plan(

   ## Plan targets in here.
    data_folder = "data-raw/exprmntl-ctls-qualfilt/",

    all_data = fs::dir_ls(data_folder) %>% map_dfr(read_xlsx) %>%
      select(!starts_with("X")),

    type_dict = make_dict_type(count(all_data, sample)),

    variant_counts = all_data %>%
      group_by(sample) %>%
      mutate(n_dis = growing_n_distinct(htype)),

    variant_step_plot = variant_counts %>%
      ggplot(aes(readseq, n_dis, color = sample)) +
      geom_step() +
      guides(color = "none"),

    biggest_sample = all_data %>%
      filter(sample == "81_D.bscflags") %>%
      pull(htype),

    MMe = tibble(n = seq(100, 5000, by = 10)) %>%
      mutate(estimate = map_dbl(n, ~ sample(biggest_sample, .x, replace = TRUE) %>% estimate_plateau())),

    MMe_plot = MMe %>%
      filter(estimate < 10000) %>%
      ggplot(aes(n, estimate)) +
      geom_point() +
      geom_hline(yintercept = n_distinct(biggest_sample)),

    prop_0.01 = keep_top_proportion(all_data, 0.01),
    prop_0.02 = keep_top_proportion(all_data, 0.02),
    prop_0.05 = keep_top_proportion(all_data, 0.05),
    prop_0.001 = keep_top_proportion(all_data, 0.001),

    amplicon_0.01 = read_all_amplicons(data_folder, proportion = 0.01),

    amplicon_0.01_wide = amplicon_0.01 %>%
      filter(htype_length > 3) %>%
      transmute(sample, amplicon, n_dist = n_dist / (2 ^ htype_length)) %>%
      pivot_wider(names_from = amplicon, values_from = n_dist),

    amplicon_pca = pca_transform(amplicon_0.01_wide, threshold = 0.95),
    amplicon_umap = umap_transform(amplicon_0.01_wide, seed = c(1234, 1234)),

    amplicon_pca_clusters = add_kmeans(amplicon_pca, -sample, 2),
    amplicon_umap_clusters = add_kmeans(amplicon_umap, -sample, 2),

    report = target(
      command = {
        rmarkdown::render(knitr_in("doc/analysis.Rmd"), output_format = "all")
        file_out("doc/analysis.html")
        file_out("doc/analysis.pdf")
      }
    )
)
