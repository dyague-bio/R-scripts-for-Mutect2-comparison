library(ggplot2)
library(dplyr)
library(readr)
library(stringr)

plot_mutation_spectrum_4modes <- function(file1, file2, file3, file4, 
                                   labels = c("Tumor-only", 
                                              "Tumor-only (Bisulfite-aware alignment)", 
                                              "Tumor-normal", 
                                              "Tumor-normal (Bisulfite-aware alignment)"),
                                   title = "SNP Mutation Spectrum Comparison",
                                   output_file = "mutation_spectrum_plot.png") {
  
  # Read and label each dataset
  # Use 'mutate' to add a column for the Mutect2 mode and aligner the data comes from
  vcf1 <- read_tsv(file1, col_names = c("Mutation", "Count")) %>%
    mutate(Mode = labels[1])
  
  vcf2 <- read_tsv(file2, col_names = c("Mutation", "Count")) %>%
    mutate(Mode = labels[2])
  
  vcf3 <- read_tsv(file3, col_names = c("Mutation", "Count")) %>%
    mutate(Mode = labels[3])
  
  vcf4 <- read_tsv(file4, col_names = c("Mutation", "Count")) %>%
    mutate(Mode = labels[4])

  # Combine all into one long dataframe
  all_data <- bind_rows(vcf1, vcf2, vcf3, vcf4)

  # Order mutations in X-axis
  mutation_order <- c("T>C". "C>T", "T>G", "T>A", "C>A", "C>G")
  all_data <- all_data %>%
    filter(Mutation %in% mutation_order) %>%
    mutate(Mutation = factor(Mutation, levels = mutation_order))

  # Calculate percentage per Mode
  all_data <- all_data %>%
    group_by(Mode) %>%
    mutate(Percent = 100 * Count / sum(Count)) %>%
    ungroup()

  # PLOT
  p <- ggplot(all_data, aes(x = Mutation, y = Percent, fill = VCF)) +
    geom_bar(stat = "identity", position = position_dodge(width = 0.9)) +
    # percentage labels
    geom_text(aes(label = sprintf("%.1f%%", Percent)),
              position = position_dodge(width = 0.9),
              vjust = -0.5,
              size = 3.0) +
    labs(title = title,
         x = "Mutation Type",
         y = "Percentage",
         fill = "Mutect2 mode, aligner") +
    theme_minimal(base_size = 16) +
    theme(axis.text.x = element_text(angle = 0, hjust = 0.5)) +
    # custom colours
    scale_fill_manual(values = c("steelblue", "tomato", "darkgreen", "purple")) +
    ylim(0, max(all_data$Percent) * 1.15)  # add space for labels

  # Save
  ggsave(output_file, plot = p, width = 12, height = 6, dpi = 300)
  
  # Print plot to screen
  print(p)
}