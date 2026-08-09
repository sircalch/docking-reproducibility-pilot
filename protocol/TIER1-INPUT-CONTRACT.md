# Tier 1 normalized-input contract

This is a preflight contract for an **independent analysis rerun**. It does
not describe a docking run, and it must not be used to infer that such a run
was completed in this repository.

## Required layout

The supplied directory contains exactly these files:

```text
<derived-data-dir>/dude-ada/pilot_runs_normalized.csv
<derived-data-dir>/dude-ampc/pilot_runs_normalized.csv
<derived-data-dir>/dude-comt/pilot_runs_normalized.csv
```

Each CSV has these required columns. Extra provenance columns are permitted.

| Column | Required representation | Constraint |
|---|---|---|
| `ligand_id` | non-empty identifier | 24 unique identifiers in every seed scenario; identical set across scenarios within a target |
| `scenario_id` | character | exactly `seed_1001`, `seed_2002`, and `seed_3003` |
| `score` | finite numeric value | one score per ligand/scenario pair; score direction is handled by the companion analysis |
| `class_label` | character | exactly six `active` and 18 `decoy` source labels per scenario |

Every target table has 72 rows: 24 ligands multiplied by three scenarios. It
has no missing or duplicate ligand/scenario pair, non-finite score, blank
identifier, altered seed identifier, or changed ligand set across seeds.

The required header is:

```csv
ligand_id,scenario_id,score,class_label
```

The header is illustrative only; this repository deliberately does not provide
substitute scores, ligand identities, structures, poses, logs, or labels.

## Preflight command

Run the contract check before any companion analysis:

```sh
Rscript scripts/validate_tier1_inputs.R <derived-data-dir> <preflight-manifest.csv>
```

The optional manifest records only file location, MD5 checksum, row count and
the declared contract dimensions. Preserve it with the rerun materials. A
failed check is a rerun finding: correct neither inputs nor outputs silently.

## Relationship to interpretation

Passing this contract establishes only that supplied normalized tables meet the
declared structural requirements for Tier 1 analysis. It does not validate
source labels, docked poses, binding, biological activity, efficacy, safety,
or prospective performance.
