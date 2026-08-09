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

Release notes are maintained in [NEWS.md](NEWS.md). Version 0.1.3 adds a
tested preflight contract for authorized independent analysis inputs; it does
not add new docking outcomes.

## Reproduce visual materials

See [reports/REPRODUCE-REPORT.md](reports/REPRODUCE-REPORT.md). The repository
checks that the visual evidence can be regenerated from its documented data
contract on a clean platform.

## Prepare an independent analysis rerun

The repository includes a strict preflight validator for authorized,
independently obtained normalized tables. It does not create substitute data.
See [protocol/TIER1-INPUT-CONTRACT.md](protocol/TIER1-INPUT-CONTRACT.md) and
[protocol/INDEPENDENT-RERUN-PLAN.md](protocol/INDEPENDENT-RERUN-PLAN.md).

## Separate exploratory receptor qualification

The prespecified 4KG2 receptor-qualification campaign is a new exploratory
method study, not a continuation of the retrospective pilot. Its scope and
strict stop conditions are in
[protocol/TIER2-AMPC-4KG2-QUALIFICATION.md](protocol/TIER2-AMPC-4KG2-QUALIFICATION.md).
It stopped at direct receptor preparation without a PDBQT; see
[DEVIATION-005-AMPC-4KG2-DIRECT-PREPARATION.md](protocol/DEVIATION-005-AMPC-4KG2-DIRECT-PREPARATION.md).
