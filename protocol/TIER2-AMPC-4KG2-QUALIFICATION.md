# Tier 2 exploratory receptor qualification: AMPC 4KG2

## Status and separation from earlier work

**Prespecified; not yet executed.** This is a new exploratory structural
qualification campaign. It is not a repair, continuation, or replacement of
the stopped DUD-E receptor route or of the stopped 1L2S route. Any later
outputs must use the campaign identifier `AMPC-4KG2-EXPLORATORY-001` and be
reported separately from the retrospective pilot.

## Candidate-selection rationale

RCSB PDB entry 4KG2 is an X-ray structure of unmutated *E. coli* K-12 AmpC
beta-lactamase with 1.89 Angstrom resolution. The RCSB entry reports 716
modeled and 716 deposited residues across its two protein chains. These facts
make it eligible for **receptor qualification**, not automatically suitable for
docking or comparable to the DUD-E receptor.

The source contains cefotaxime in a C3-cleaved, open bound form. It may be used
only to identify the documented active-site region while inspecting the
structure. It must not be used as a redocking reference, a pose-recovery
standard, or a performance label in this campaign.

## Frozen scope

1. Download the RCSB legacy PDB coordinate file and record retrieval date,
   URL, size and SHA-256.
2. Select only `ATOM` records from chain A with nonblank element fields. Do not
   add atoms, residues, hydrogens, waters, ions, ligands, charges, or
   coordinates.
3. Attempt direct receptor preparation with Meeko 0.7.1, without
   `--allow_bad_res`, residue deletion, automatic repair, alternative receptor
   converter, minimization, or manual editing.
4. Record the exact command, standard output/error, software version, input and
   output checksums, and any error.

## Acceptance gate

The candidate is accepted for the next planning gate only if all conditions
hold:

- the downloaded source and selected chain have recorded SHA-256 checksums;
- every selected `ATOM` record has an element field;
- Meeko direct preparation exits successfully without a bypass option;
- a nonempty receptor PDBQT is produced and its checksum is recorded;
- no source coordinate, residue, atom, ligand or water was silently repaired
  or substituted.

Passing this gate establishes only receptor-software compatibility. It does not
establish an appropriate docking box, a validated pose, affinity prediction,
biological activity, or equivalence to the original DUD-E AMPC receptor.

## Stop conditions

Stop and record a deviation if any parser, missing-residue, residue-template,
padding, element, chain-selection, or output-integrity check fails. Do not
fall back to a different structure or converter in the same campaign.

No ligand preparation, Vina command, score table, ranking, enrichment metric or
biological inference is authorized by this qualification protocol. A separate
protocol must first justify a noncovalent reference ligand and a docking box.

## Source

- RCSB PDB 4KG2: <https://www.rcsb.org/structure/4KG2>
