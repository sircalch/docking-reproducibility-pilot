# Reproducibility tiers

This pilot separates two different and useful forms of reproducibility. They
must not be described as interchangeable.

## Tier 1: independent analysis rerun

An analyst with independently obtained, normalized input tables can rerun the
audit, rank-agreement, consensus, and retrospective-label calculations. The
minimum input contract is three files named
`dude-ada/pilot_runs_normalized.csv`, `dude-ampc/pilot_runs_normalized.csv`,
and `dude-comt/pilot_runs_normalized.csv`. Each must retain ligand identifiers,
seed/scenario identifiers, scores, and reference labels.

Tier 1 tests whether the reported summaries follow from supplied tables. It
does not reproduce the generation of those tables, docking poses, or docking
scores.

## Tier 2: end-to-end computational rerun

An end-to-end rerun additionally requires lawful access to the source ligand
and decoy records, target structures, preparation settings, docking engine and
version, search-space definition, random seeds, command lines, logs, and
normalization rules. Those materials are not currently distributed by this
repository.

Tier 2 is therefore **not executed** and is not claimed by this pilot. It is a
future study component, not a completed result.

## Common requirements

Both tiers must retain a source manifest, checksums, operating-system and R
versions, package commit identifiers, command logs, and all generated output
tables. Metrics are reported separately by target and seed; they must never be
pooled across target score distributions.

## Interpretation boundary

Neither tier establishes molecular binding, biological activity, efficacy,
safety, clinical utility, or prospective screening performance. Reference
labels support retrospective discrimination summaries only.
