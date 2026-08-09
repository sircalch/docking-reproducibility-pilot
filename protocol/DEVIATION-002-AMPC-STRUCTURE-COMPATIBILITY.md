# Deviation 002: AMPC structure compatibility review

## Event

On 2026-08-09, after installing ProDy 2.6.1 in the isolated preparation
environment, the documented Meeko `--read_with_prody` route was attempted for
the unchanged DUD-E AMPC receptor. It stopped before producing a prepared
receptor with the same missing-element error as the direct parser.

## Audit finding

The source receptor has 3,409 `ATOM` or `HETATM` records with blank PDB element
fields. It also contains noncanonical residue labels (`ALB`, `ASM`, `GLZ`,
`HID`, `SEM`, `TYM`, and `WAU`) in addition to standard amino-acid labels.
Those labels can encode protonation or chemical-state choices; automatic
replacement or deletion would be a methodological intervention, not a harmless
format conversion.

## Decision

Tier 2 execution remains stopped. No element field will be inferred, residue
will be renamed, water will be deleted, alternative receptor will be obtained,
or docking parameter will be changed without a separate, justified amendment
that specifies the structural-preparation policy and validation checks.

## Effect on results

There are no prepared receptor files, prepared ligands, docking poses, scores,
rankings, or retrospective metrics from the AMPC Tier 2 implementation. The
source archive and both failed logs are retained locally and excluded from the
public repository.
