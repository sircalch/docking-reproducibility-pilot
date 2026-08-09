# Deviation 005: AMPC 4KG2 direct receptor preparation

## Scope

This record closes the prespecified
[`AMPC-4KG2-EXPLORATORY-001`](TIER2-AMPC-4KG2-QUALIFICATION.md) receptor
qualification attempt. It is not a docking result.

## Acquired source and unmodified selection

- Source: `https://files.rcsb.org/download/4KG2.pdb`
- Retrieved: 2026-08-09
- Source size: 535,491 bytes
- Source SHA-256:
  `A24902F59715A949181AF1C5CE8543FC3D4123D9AB32F69CC1E6311EBBFA2AA0`
- Selection: `ATOM` records from chain A only; no atom, residue, ligand,
  water, charge or coordinate editing.
- Selected protein records: 2,799
- Selected residue identifiers: 358
- Selected-receptor SHA-256:
  `DA3150C88A981031DA5F7E272A35887C30B659ECCB13CD75536F728AB3E8032B`

## Direct preparation attempt

Meeko 0.7.1 was invoked once with its direct PDB reader and the selected
receptor. No `--allow_bad_res`, alternate-location choice, deletion, repair,
minimization, template override, or alternate converter was supplied.

The process exited nonzero and did not produce a receptor PDBQT. Meeko reported
template-matching failures for `A:6` (GLN), `A:37` (LYS), `A:50` (LYS), `A:207`
(LYS), and `A:246` (LYS), with an excess inter-residue bond indication. It also
reported alternate locations at `A:14` and `A:102`.

## Decision

The campaign is **stopped before receptor PDBQT, ligand preparation, docking,
poses, scores, rankings, or metrics**. Meeko suggested `--allow_bad_res` and a
default alternate-location choice, but both would change the predeclared
receptor treatment and are not used.

The next action, if any, requires a separately reviewed and prespecified
structural strategy. It must not be described as a successful AMPC docking
run, a replication of the retrospective pilot, or evidence of molecular
binding or biological activity.
