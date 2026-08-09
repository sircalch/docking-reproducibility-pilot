# Deviation 003: incomplete residues in RCSB 1L2S chain A

## Event

On 2026-08-09, the prespecified chain-A receptor selection from RCSB 1L2S was
submitted to Meeko's direct PDB preparation route. The source selection itself
succeeded (2,737 protein `ATOM` records and 19 STC reference-ligand records),
but receptor preparation stopped before a PDBQT file was produced.

Meeko reported failed residue-template matching for chain-A residues 21, 22,
99, 124, 126, 196, 207, 246, 264, and 296. Its diagnostic associates these
failures with missing heavy atoms.

## Decision

The suggested automatic `--allow_bad_res` option is not used. It would remove
the affected residues, which is a structural modification that may influence
the binding site or receptor conformation. No residue is deleted, rebuilt,
protonated, or otherwise repaired under the current protocol.

## Required next decision

A future amendment needs a scientifically justified receptor-repair strategy,
including the selected tool and version, whether each affected residue is near
the binding site, how added atoms are validated, and how the result is kept
separate from the original experimental coordinate record. That decision should
be reviewed by a researcher experienced in protein structure preparation.

## Effect on results

There is no prepared receptor, prepared reference ligand, docking pose, score,
rank, or retrospective performance result from the RCSB 1L2S route.
