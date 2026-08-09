# Tier 2 implementation prespecification: AMPC

## Status and purpose

**Prespecified; not executed.** This is the first end-to-end implementation
unit for the pilot. It is deliberately limited to the DUD-E AMPC target because
its source archive is comparatively small and contains a receptor, a crystal
ligand, clustered actives, and decoys. It is an implementation and
reproducibility exercise, not a claim of prospective screening performance.

No score, pose, rank, AUC, enrichment metric, or biological conclusion is
reported by this document.

## Frozen inputs

- Source archive: `external-data/ampc.tar.gz`
- Source URL: <https://dude.docking.org/targets/ampc/ampc.tar.gz>
- SHA-256: `886B31A35FA5D1E68051F543853A7C43FEA14127B7C35EB8D626E4874BBA3763`
- Receptor source: `ampc/receptor.pdb`
- Reference ligand source: `ampc/crystal_ligand.mol2`
- Candidate sources: `ampc/actives_final.sdf.gz` and
  `ampc/decoys_final.sdf.gz`

## Frozen software environment

- AutoDock Vina 1.2.7 for Windows, SHA-256
  `E0C4B2715E0C1A74F6E92D0F3BE0328AC97542EAFBC111E6B1EFAD897A73CCE5`
- Python 3.13 virtual environment recorded in
  `external-tools/PYTHON-ENVIRONMENT.txt`
- Meeko 0.7.1; RDKit 2026.03.5; SciPy 1.18.0; Gemmi 0.7.5

## Pre-execution decisions

1. Retain the downloaded source archive unchanged. Extracted and prepared
   artifacts are separate, local, and checksummed.
2. Use the supplied receptor without flexible side chains in the initial unit.
   Read it through Meeko's documented ProDy input path; the receptor file is
   not edited. The receptor-preparation command and complete log must be
   retained. The reason for this parser choice is recorded in
   [DEVIATION-001-AMPC-RECEPTOR-PARSING.md](DEVIATION-001-AMPC-RECEPTOR-PARSING.md).
3. Prepare the crystallographic ligand first. Its heavy-atom coordinates define
   a proposed docking box only after an explicit coordinate calculation is
   written to the run manifest.
4. Define the box as the reference-ligand coordinate extrema plus a 5 Å margin
   in every direction. Record exact center and size before scoring candidates.
5. Use Vina scoring, `exhaustiveness = 8`, `num_modes = 1`,
   `energy_range = 3`, one CPU, and three seeds: 1001, 2002, and 3003.
6. Run a receptor/reference-ligand smoke test before any active or decoy. A
   successful command only establishes that the pipeline runs; it is not an
   accuracy validation.
7. Do not select a performance subset after looking at scores. Candidate
   selection, if any, will be deterministic from the source identifiers and
   recorded before the first candidate command.

## Required outputs before interpretation

The run directory must contain source and tool manifests, extraction inventory,
receptor and ligand preparation logs, box calculation, Vina commands, seeds,
standard output/error, PDBQT input checksums, output-pose checksums, and a
tidy score table. Missing artifacts are a failed reproducibility condition.

## Stop conditions

Stop and document the issue if any source checksum differs, preparation fails,
the receptor or reference ligand cannot be parameterized, a candidate cannot be
processed, or the box cannot be derived without discretionary changes. Do not
silently replace structures, alter identifiers, or tune parameters after
observing scores.

The current implementation is stopped under
[DEVIATION-002-AMPC-STRUCTURE-COMPATIBILITY.md](DEVIATION-002-AMPC-STRUCTURE-COMPATIBILITY.md).

## Interpretation boundary

Any future score is a docking-program output for a retrospective benchmark.
It does not establish binding, biological activity, efficacy, safety, clinical
utility, or a viable therapeutic candidate.
