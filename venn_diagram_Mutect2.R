
library(VennDiagram)
library(grid)

# Data Input
# Replace numbers:
wgs_total <- 3868
wgbs_total <- 2057
intersection <- 302

# Calculate percentages
shared_pct <- round((intersection / wgbs_total) * 100, 1)
label_text <- paste0(shared_pct, "% of WGBS SNPs\nshared with WGS")

# Set up export
png("venn_wgs_wgbs_overlap.png", width = 2000, height = 2000, res = 300)

# Create Venn Diagram
venn_plot <- draw.pairwise.venn(
  area1 = wgs_total,
  area2 = wgbs_total,
  cross.area = intersection,
  category = c("WGS", "WGBS"),
  fill = c("#377eb8", "#e41a1c"),
  alpha = c(0.7, 0.7),
  lty = "blank",
  lwd = NA,
  cex = 0,
  cat.cex = 1.8,
  cat.fontfamily = "Arial",
  cat.fontface = "bold",
  cat.dist = c(0.03, 0.03),
  cat.pos = c(-10, 10)
)

# Add custom percentage label
grid.text(label_text, 
          x = 0.5,
          y = 0.5,
          gp = gpar(fontsize = 16, fontface = "bold"))

dev.off()