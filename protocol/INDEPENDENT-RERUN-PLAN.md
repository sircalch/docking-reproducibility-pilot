# Independent rerun plan

## Status

**Not executed in this repository.** The original DUD-E archives, prepared
structures, docking artifacts, logs and derived score tables are intentionally
not redistributed here. An independent rerun may proceed only when an analyst
has lawful access to the required inputs.

## Required inputs

1. Three local directories: `dude-ada`, `dude-ampc`, and `dude-comt`.
2. Each directory must contain `pilot_runs_normalized.csv` with 24 ligands and
   three declared seed scenarios (1001, 2002 and 3003).
3. The label source and retrieval conditions must be recorded.
4. A file manifest must be produced before analysis and retained locally.

## Independent execution order

1. Run `dockprepR/tools/audit_multitarget_pilot.R` against a new output
   directory.
2. Run `dockconsensusR/tools/run_multitarget_consensus.R` against the same
   derived-data directory.
3. Run `dockbenchmarkR/tools/run_pilot_benchmark.R` against the same inputs.
4. Record R version, package release commit, operating system, input manifest
   and output checksums.
5. Compare aggregate outputs against `results/PILOT-RESULTS.md` without
   overwriting the original report.

## Acceptance criteria

- Nine tables pass the integrity contract.
- Every target has three complete 24-ligand seed rankings.
- All input checksums and source versions are logged.
- Aggregate results are reported by target and never pooled across targets.
- Any discrepancy is documented as a rerun finding rather than silently fixed.

## Interpretation boundary

Agreement with the documented aggregate results supports computational
reproducibility of this limited pilot only. It does not validate molecular
binding, biological activity, efficacy, safety, clinical utility, or prospective
screening performance.
