# Render publication-ready figures from the evidence-bounded pilot record.
# Values below are copied from results/PILOT-RESULTS.md; no new analysis is
# performed by this rendering script.

output_dir <- file.path("reports", "figures")
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

target <- c("ADA", "AMPC", "COMT")
spearman_low <- c(0.970, 0.985, 0.930)
spearman_high <- c(0.982, 0.998, 0.975)
auc_low <- c(0.343, 0.528, 0.769)
auc_high <- c(0.380, 0.565, 0.796)
ap_low <- c(0.239, 0.276, 0.476)
ap_high <- c(0.368, 0.293, 0.569)
ef5 <- c(0.8, 0.0, 1.6)

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
