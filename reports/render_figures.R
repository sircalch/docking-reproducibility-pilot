# Render publication-ready figures from the evidence-bounded pilot record.
# Values below are copied from results/PILOT-RESULTS.md; no new analysis is
# performed by this rendering script.

arguments <- commandArgs(trailingOnly = TRUE)
if (length(arguments) > 1L) {
  stop("Use at most one optional output directory argument.", call. = FALSE)
}
output_dir <- if (length(arguments) == 1L) arguments[[1L]] else file.path("reports", "figures")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

draw_box <- function(x0, y0, label, fill, border = "#334155") {
  rect(x0, y0, x0 + 1.75, y0 + 0.8, col = fill, border = border, lwd = 1.2)
  text(x0 + 0.875, y0 + 0.4, label, cex = 0.72)
}

grDevices::svg(file.path(output_dir, "figure-1-evidence-pathway.svg"), width = 10, height = 4.5)
par(mar = c(0.3, 0.3, 1.6, 0.3), xpd = NA)
plot.new()
plot.window(xlim = c(0, 10), ylim = c(0, 4))
title("Evidence pathway and current execution boundary", cex.main = 1.25)
draw_box(0.35, 2.55, "DUD-E source archives\nADA · AMPC · COMT\nverified", "#dbeafe")
draw_box(2.7, 2.55, "Retrospective tables\nintegrity and seed\nmetrics documented", "#dbeafe")
draw_box(5.05, 2.55, "AMPC structural\npreparation\nvalidated stepwise", "#fef3c7")
draw_box(7.4, 2.55, "Candidate docking\nnot executed", "#f1f5f9")
arrows(2.12, 2.95, 2.56, 2.95, length = 0.08)
arrows(4.47, 2.95, 4.91, 2.95, length = 0.08)
arrows(6.82, 2.95, 7.26, 2.95, length = 0.08)
segments(5.92, 2.55, 5.92, 1.5, col = "#b91c1c", lwd = 2)
draw_box(5.05, 0.65, "Stopped before PDBQT\nNo poses, scores, ranks\nor biological claims", "#fee2e2", border = "#b91c1c")
text(0.35, 0.2, "Blue: documented evidence  ·  Amber: structural work  ·  Red: validated stop", adj = 0, cex = 0.78)
dev.off()

metric_ranges <- utils::read.csv(
  file.path("results", "PILOT-METRIC-RANGES.csv"),
  stringsAsFactors = FALSE
)
expected_targets <- c("ADA", "AMPC", "COMT")
expected_metrics <- c("rank_agreement", "roc_auc", "average_precision", "top5_enrichment")
expected_keys <- as.vector(outer(expected_targets, expected_metrics, paste, sep = "::"))
observed_keys <- paste(metric_ranges$target, metric_ranges$metric, sep = "::")
if (
  nrow(metric_ranges) != length(expected_keys) ||
  !setequal(observed_keys, expected_keys) ||
  anyDuplicated(observed_keys) ||
  any(!is.finite(metric_ranges$minimum)) ||
  any(!is.finite(metric_ranges$maximum)) ||
  any(metric_ranges$minimum > metric_ranges$maximum)
) {
  stop("PILOT-METRIC-RANGES.csv does not satisfy the documented target/metric contract.", call. = FALSE)
}
target <- c("ADA", "AMPC", "COMT")
metric_vector <- function(metric, column) {
  data <- metric_ranges[metric_ranges$metric == metric, , drop = FALSE]
  data <- data[match(target, data$target), , drop = FALSE]
  if (anyNA(data[[column]]) || !identical(data$target, target)) {
    stop("Metric ranges do not contain complete target-specific values for ", metric, call. = FALSE)
  }
  data[[column]]
}
spearman_low <- metric_vector("rank_agreement", "minimum")
spearman_high <- metric_vector("rank_agreement", "maximum")
auc_low <- metric_vector("roc_auc", "minimum")
auc_high <- metric_vector("roc_auc", "maximum")
ap_low <- metric_vector("average_precision", "minimum")
ap_high <- metric_vector("average_precision", "maximum")
ef5 <- metric_vector("top5_enrichment", "minimum")

draw_range_panel <- function(low, high, main, ylim = c(0, 1), reference = NULL) {
  x <- seq_along(target)
  plot(x, (low + high) / 2, type = "n", xaxt = "n", xlab = "", ylab = "Range across fixed seeds", ylim = ylim, main = main)
  axis(1, at = x, labels = target)
  if (!is.null(reference)) abline(h = reference, lty = 2, col = "#64748b")
  segments(x, low, x, high, lwd = 5, col = "#2563eb")
  points(x, low, pch = 16, col = "#1d4ed8")
  points(x, high, pch = 16, col = "#1d4ed8")
}

grDevices::svg(file.path(output_dir, "figure-2-retrospective-metrics.svg"), width = 11, height = 4.2)
par(mfrow = c(1, 3), mar = c(4, 4, 2.5, 0.7), oma = c(0, 0, 0, 0))
draw_range_panel(spearman_low, spearman_high, "Rank agreement", ylim = c(0.9, 1.0))
draw_range_panel(auc_low, auc_high, "ROC AUC", ylim = c(0, 1), reference = 0.5)
draw_range_panel(ap_low, ap_high, "Average precision", ylim = c(0, 0.65))
mtext("Vertical segments show documented minimum–maximum values across three fixed seeds; no target pooling.", side = 1, outer = TRUE, line = -1.2, cex = 0.75)
dev.off()

grDevices::svg(file.path(output_dir, "figure-3-top5-enrichment.svg"), width = 7, height = 4.2)
par(mar = c(4.2, 4.5, 2.4, 0.8))
barplot(ef5, names.arg = target, ylim = c(0, 2), col = "#2563eb", border = NA, ylab = "Top-5 enrichment factor", main = "Documented top-5 enrichment")
abline(h = 1, lty = 2, col = "#64748b")
text(seq_along(ef5), ef5 + 0.09, labels = format(ef5, nsmall = 1), cex = 0.9)
mtext("Dashed line: random expectation. Values are retrospective and target-specific.", side = 1, line = 2.6, cex = 0.75)
dev.off()
