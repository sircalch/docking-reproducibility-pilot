#!/usr/bin/env Rscript

# Test-only fixtures for the Tier 1 preflight validator.  They are synthetic
# contract checks, not pilot data and not docking results.

script_argument <- commandArgs(FALSE)[grep("^--file=", commandArgs(FALSE))]
if (length(script_argument) != 1L) stop("Could not determine this test script path.", call. = FALSE)
project_root <- normalizePath(file.path(dirname(sub("^--file=", "", script_argument)), ".."), mustWork = TRUE)
validator <- file.path(project_root, "scripts", "validate_tier1_inputs.R")

fixture_root <- file.path(tempdir(), paste0("tier1-preflight-", Sys.getpid()))
dir.create(fixture_root, recursive = TRUE, showWarnings = FALSE)

write_target <- function(target, duplicate = FALSE) {
  scenario <- rep(c("seed_1001", "seed_2002", "seed_3003"), each = 24L)
  ligand <- rep(sprintf("L%02d", seq_len(24L)), times = 3L)
  if (duplicate) ligand[[2L]] <- ligand[[1L]]
  table <- data.frame(
    ligand_id = ligand,
    scenario_id = scenario,
    score = seq_along(ligand) / 10,
    class_label = rep(c(rep("active", 6L), rep("decoy", 18L)), times = 3L),
    stringsAsFactors = FALSE
  )
  destination <- file.path(fixture_root, paste0("dude-", target))
  dir.create(destination, recursive = TRUE, showWarnings = FALSE)
  utils::write.csv(table, file.path(destination, "pilot_runs_normalized.csv"), row.names = FALSE)
}

for (target in c("ada", "ampc", "comt")) write_target(target)
manifest <- file.path(fixture_root, "preflight_manifest.csv")
rscript <- file.path(R.home("bin"), "Rscript")
run_validator <- function() {
  system2(rscript, c(shQuote(validator), shQuote(fixture_root), shQuote(manifest)), stdout = TRUE, stderr = TRUE)
}

valid_run <- run_validator()
if (!identical(attr(valid_run, "status"), NULL) || !file.exists(manifest)) {
  stop("The valid synthetic Tier 1 fixture did not pass preflight validation.", call. = FALSE)
}
validated_manifest <- utils::read.csv(manifest, stringsAsFactors = FALSE)
if (nrow(validated_manifest) != 3L || !identical(sort(validated_manifest$target), c("ada", "ampc", "comt"))) {
  stop("The preflight manifest did not contain the expected three targets.", call. = FALSE)
}

write_target("ampc", duplicate = TRUE)
invalid_run <- suppressWarnings(run_validator())
if (is.null(attr(invalid_run, "status")) || !any(grepl("duplicated ligand/scenario", invalid_run, fixed = TRUE))) {
  stop("A duplicate ligand/scenario fixture was not rejected clearly.", call. = FALSE)
}

message("Tier 1 preflight validator test passed.")
