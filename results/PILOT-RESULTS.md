# Results

## Table integrity

For ADA, AMPC and COMT, each of the three fixed-seed tables contained 24 rows
and 24 unique ligands. The documented audit reported zero duplicate pair rows,
zero invalid identifiers, zero non-finite scores and zero missing expected pairs
across the nine target-scenario tables.

## Rank agreement

| Target | Pairwise Spearman agreement across seeds |
|---|---:|
| ADA | 0.970–0.982 |
| AMPC | 0.985–0.998 |
| COMT | 0.930–0.975 |

Each ligand was present in all three seed rankings for its target (coverage 1.0).

## Retrospective label separation

| Target | ROC AUC across seeds | Average precision across seeds | Top-5 enrichment factor across seeds |
|---|---:|---:|---:|
| ADA | 0.343–0.380 | 0.239–0.368 | 0.8 |
| AMPC | 0.528–0.565 | 0.276–0.293 | 0.0 |
| COMT | 0.769–0.796 | 0.476–0.569 | 1.6 |

These are aggregate outputs from the documented pilot tables. They are not
evidence of binding, activity, efficacy, safety, superiority of a program, or
prospective screening performance.
