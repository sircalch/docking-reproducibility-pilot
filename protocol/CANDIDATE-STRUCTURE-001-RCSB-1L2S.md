# Candidate structure 001: RCSB PDB 1L2S

## Status

**Candidate evaluated; not adopted for docking.** This record preserves a
format-compatible candidate for a future amended AMPC Tier 2 protocol. It does
not replace the DUD-E receptor in the currently stopped run.

## Provenance

- DUD-E lists PDB entry 1L2S for AMPC.
- RCSB PDB entry: <https://www.rcsb.org/structure/1L2S>
- Coordinate URL: <https://files.rcsb.org/download/1L2S.pdb>
- Local retrieval date: 2026-08-09
- SHA-256 of retrieved coordinate file:
  `3F86CC280611A63FBCD80C7471B25839DFF46753248AB6751D3AB41F83EED4C8`

RCSB describes 1L2S as an X-ray structure of *E. coli* AmpC beta-lactamase in
complex with a noncovalent inhibitor, at 1.94 Å resolution.

## Read-only compatibility audit

The downloaded coordinate file contained 5,916 `ATOM` or `HETATM` rows and no
blank PDB element fields. Its residue labels comprise standard amino acids,
water (`HOH`), and the bound small-molecule ligand (`STC`). This is a format
finding only, not a preparation decision.

## Required amendment before use

Any adoption must specify, before execution:

1. whether the receptor is chain A, chain B, a biological assembly, or another
   explicit selection;
2. removal/retention rules for the crystallographic ligand and waters;
3. protonation and missing-atom policy;
4. validation of the prepared receptor and of a reference-ligand redocking
   smoke test; and
5. how the alternate structure affects comparability with the stopped DUD-E
   receptor route.

Until then, this structure is retained solely as a documented candidate.
