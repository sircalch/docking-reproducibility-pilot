#!/usr/bin/env Rscript

# Validate the analysis-only Tier 1 input contract before a rerun.  This script
# does not download data, execute docking, alter inputs, or calculate results.

arguments <- commandArgs(trailingOnly = TRUE)
usage <- paste(
  "Usage: Rscript scripts/validate_tier1_inputs.R <derived-data-dir> [manifest-csv]",
  "\nValidates the three documented normalized input tables and optionally writes a preflight manifest.",
  sep = ""
)
if (identical(arguments, "--help") || identical(arguments, "-h")) {
  cat(usage, "\n")
  quit(status = 0L)
}
if (length(arguments) < 1L || length(arguments) > 2L) stop(usage, call. = FALSE)

derived_dir <- normalizePath(arguments[[1L]], mustWork = TRUE)
targets <- c("ada", "ampc", "comt")
required_columns <- c("ligand_id", "scenario_id", "score", "class_label")
expected_scenarios <- c("seed_1001", "seed_2002", "seed_3003")

validate_one_table <- function(path, target) {
  runs <- utils::read.csv(path, stringsAsFactors = FALSE, check.names = FALSE)
  missing <- setdiff(required_columns, names(runs))
  if (length(missing)) {
    stop(target, ": missing required column(s): ", paste(missing, collapse = ", "), call. = FALSE)
  }
  if (nrow(runs) != 72L) stop(target, ": expected exactly 72 rows (24 ligands x 3 seeds).", call. = FALSE)
  if (!is.numeric(runs$score) || any(!is.finite(runs$score))) {
    stop(target, ": `score` must contain finite numeric values.", call. = FALSE)
  }
  character_fields <- c("ligand_id", "scenario_id", "class_label")
  if (any(vapply(runs[character_fields], function(x) anyNA(x) || any(!nzchar(trimws(as.character(x)))), logical(1)))) {
    stop(target, ": identifier and label fields must be complete non-empty values.", call. = FALSE)
  }
  scenarios <- sort(unique(as.character(runs$scenario_id)))
  if (!identical(scenarios, expected_scenarios)) {
    stop(target, ": scenarios must be exactly ", paste(expected_scenarios, collapse = ", "), ".", call. = FALSE)
  }
  pair_key <- paste(runs$ligand_id, runs$scenario_id, sep = "\r")
  if (anyDuplicated(pair_key)) stop(target, ": duplicated ligand/scenario pair(s).", call. = FALSE)
  declared_ligands <- NULL
  for (scenario in expected_scenarios) {
    subset <- runs[runs$scenario_id == scenario, , drop = FALSE]
    ligands <- as.character(subset$ligand_id)
    if (length(ligands) != 24L || length(unique(ligands)) != 24L) {
      stop(target, " / ", scenario, ": expected 24 unique ligands.", call. = FALSE)
    }
    labels <- as.character(subset$class_label)
    if (!all(labels %in% c("active", "decoy")) || sum(labels == "active") != 6L || sum(labels == "decoy") != 18L) {
      stop(target, " / ", scenario, ": expected six `active` and 18 `decoy` reference labels.", call. = FALSE)
    }
    if (is.null(declared_ligands)) {
      declared_ligands <- sort(ligands)
    } else if (!identical(sort(ligands), declared_ligands)) {
      stop(target, " / ", scenario, ": ligand set differs from the other seed scenarios.", call. = FALSE)
    }
  }
  data.frame(
    target = target,
    input_file = normalizePath(path, winslash = "/"),
    md5 = unname(tools::md5sum(path)),
    rows = nrow(runs),
    scenarios = length(scenarios),
    ligands_per_scenario = 24L,
    active_labels_per_scenario = 6L,
    decoy_labels_per_scenario = 18L,
    stringsAsFactors = FALSE
  )
}

manifest <- do.call(rbind, lapply(targets, function(target) {
  path <- file.path(derived_dir, paste0("dude-", target), "pilot_runs_normalized.csv")
  if (!file.exists(path)) stop("Missing expected input: ", path, call. = FALSE)
  validate_one_table(path, target)
}))

if (length(arguments) == 2L) {
  utils::write.csv(manifest, arguments[[2L]], row.names = FALSE)
} else {
  print(manifest, row.names = FALSE)
}
message("Tier 1 input contract passed for all three targets.")
