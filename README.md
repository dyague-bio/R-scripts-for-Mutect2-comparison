# WGS vs. WGBS Mutation Analysis Pipeline
This repository contains R scripts developed for the visualization of the Mutect2-variant-calling-WGBS project, to compare the performance of variant calling pipelines in Whole Genome Sequencing (WGS) and Whole Genome Bisulfite Sequencing (WGBS) plant data.

1. *mutation_spectrum_Mutect2.R*
This script contains a function to generate grouped bar plots showing the distribution of specific mutation types. Produces a 4-mode comparison plot with percentage labels, utilizing ggplot2.
The plot_mutation_spectrum_4modes function requires headerless .tsv (Tab-Separated Values) files. Each file should contain the summarized counts of mutations for a single pipeline mode or branch.
Format Requirements: headerless .tsv files.
Column 1: Mutation type string (e.g., C>A, T>G, A>C).
Column 2: Integer count of occurrences.

2. *venn_diagram_Mutect2.R*
This script quantifies and visualizes the intersection of SNP calls between two genomic datasets. Calculates the percentage of WGBS-derived SNPs that are validated by (intersect with) WGS data. Add counts manually in the script.

**Example Data**:
The example files provided in the data/ directory are derivatives of the datasets used in my thesis.
