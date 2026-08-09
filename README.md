# Small multiblanco docking reproducibility pilot

This is a transparent retrospective pilot assembled from the documented local
outputs of the companion `dockbenchmarkR`, `dockprepR`, and `dockconsensusR`
repositories. It describes integrity, rank agreement and retrospective label
separation for precomputed score tables. It is not a prospective virtual screen
and does not establish molecular binding, biological activity, efficacy, safety,
or clinical utility.

## Scope

Three DUD-E target labels (ADA, AMPC and COMT), 24 ligands per target-scenario
(six labelled actives and 18 decoys), and three fixed Vina seeds were used in
the documented pilot. Original source archives, prepared structures, poses, raw
logs and local score tables are not redistributed here.

## Evidence report

The complete, evidence-bounded methodology, retrospective summaries, source
verification, structural-preparation decision log, and current execution state
are available in [reports/EVIDENCE-STATUS.md](reports/EVIDENCE-STATUS.md).

## Versioned evidence record

Release notes are maintained in [NEWS.md](NEWS.md). Version 0.1.1 adds the
visual evidence report and the documented AMPC implementation checks; it does
not add new docking outcomes.

## Reproduce visual materials

See [reports/REPRODUCE-REPORT.md](reports/REPRODUCE-REPORT.md). The repository
checks that committed evidence figures regenerate unchanged.
