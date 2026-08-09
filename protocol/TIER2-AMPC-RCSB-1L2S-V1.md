# Tier 2 alternative protocol: AMPC from RCSB 1L2S

## Status

**Prespecified; preparation may proceed, docking is not yet executed.** This
is a separate alternative to the stopped DUD-E-receptor route. It is not a
post-hoc replacement of that route and its results, if any, must be reported
separately.

## Structural policy

The downloaded RCSB coordinate file contains two crystallographic protein
chains and several bound-ligand instances. The receptor input is defined as
only `ATOM` records from chain A. `HETATM` records, including waters and STC,
are excluded from the receptor file. The chain-A STC instance (residue 1115)
is retained separately only as the reference ligand for defining the docking
box and a smoke test.

This policy does not assert that water removal or a rigid receptor is optimal;
it fixes a tractable, conventional initial condition that is transparent and
separate from the original DUD-E file.

## Frozen inputs and software

- RCSB coordinate: `external-data/rcsb-1l2s/1L2S.pdb`
- Coordinate SHA-256:
  `3F86CC280611A63FBCD80C7471B25839DFF46753248AB6751D3AB41F83EED4C8`
- AMPC candidate tables: unchanged DUD-E AMPC archive listed in
  `TIER2-AMPC-PRESPECIFICATION.md`
- AutoDock Vina 1.2.7; Meeko 0.7.1; RDKit 2026.03.5; ProDy 2.6.1.

## Preparation and validation sequence

1. Run `scripts/extract_rcsb_1l2s_chain_a.py` to generate the receptor and
   reference-ligand inputs, retaining a JSON manifest with input/output
   checksums and record counts.
2. Prepare the receptor with Meeko using its direct PDB reader. Stop if any
   parser or residue-template error occurs.
3. Prepare STC from its extracted Mol2/SDF-compatible representation; stop if
   chemical perception or protonation cannot be stated from the source.
4. Calculate the box from the unmodified reference-ligand coordinates plus the
   already specified 5 Å margin and record exact values before any Vina command.
5. Run only the reference-ligand smoke test. Do not run DUD-E candidates until
   the output, commands, and checksums have been reviewed.

## Interpretation boundary

Successful preparation or a smoke test demonstrates only software workflow
compatibility. It is not pose validation, affinity validation, or evidence of
biological effect.

The current route is stopped under
[DEVIATION-003-RCSB-1L2S-INCOMPLETE-RESIDUES.md](DEVIATION-003-RCSB-1L2S-INCOMPLETE-RESIDUES.md).
