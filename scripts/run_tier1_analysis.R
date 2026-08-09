#!/usr/bin/env Rscript

# Run the analysis-only reproducibility tier from independently supplied,
# normalized tables. This script does not download data, run docking engines,
# or create substitute inputs.

arguments <- commandArgs(trailingOnly = TRUE)
if (length(arguments) != 4L) {
  stop(
    paste(
      "Usage: Rscript scripts/run_tier1_analysis.R",
      "<derived-data-dir> <output-dir> <dockprepR-dir> <dockconsensusR-dir>",
      "\nRun dockbenchmarkR/tools/run_pilot_benchmark.R separately with the same inputs."
    ),
    call. = FALSE
  )
}

derived_dir <- normalizePath(arguments[[1L]], mustWork = TRUE)
output_dir <- normalizePath(arguments[[2L]], mustWork = FALSE)
dockprep_dir <- normalizePath(arguments[[3L]], mustWork = TRUE)
dockconsensus_dir <- normalizePath(arguments[[4L]], mustWork = TRUE)

required <- file.path(
  derived_dir,
  paste0("dude-", c("ada", "ampc", "comt")),
  "pilot_runs_normalized.csv"
)
missing <- required[!file.exists(required)]
if (length(missing)) {
  stop("Missing required Tier 1 input(s):\n", paste(missing, collapse = "\n"), call. = FALSE)
}

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
run_script <- function(project_dir, script_name) {
  script <- file.path(project_dir, "tools", script_name)
  if (!file.exists(script)) stop("Missing companion script: ", script, call. = FALSE)
  status <- system2(
    command = file.path(R.home("bin"), "Rscript"),
    args = c(shQuote(script), shQuote(derived_dir), shQuote(output_dir))
  )
  if (!identical(status, 0L)) stop("Companion analysis failed: ", script_name, call. = FALSE)
}

run_script(dockprep_dir, "audit_multitarget_pilot.R")
run_script(dockconsensus_dir, "run_multitarget_consensus.R")

manifest <- data.frame(
  file = normalizePath(required, winslash = "/"),
  md5 = unname(tools::md5sum(required)),
  stringsAsFactors = FALSE
)
utils::write.csv(manifest, file.path(output_dir, "tier1_input_manifest.csv"), row.names = FALSE)

message("Tier 1 analysis completed. Outputs: ", normalizePath(output_dir))
