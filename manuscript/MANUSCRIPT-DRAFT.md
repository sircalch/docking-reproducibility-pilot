# Transparent analysis of a small multiblanco docking reproducibility pilot

## Authors

Andrés Monreal Hernández; Sara Lizbeth Franco Amaya; Carlos Ivanhoe Martínez Osorio.

## Abstract

Computational docking campaigns commonly produce ranked candidate lists, yet the
reproducibility properties of the underlying result tables are often reported
incompletely. We assembled a small retrospective multiblanco pilot from
documented precomputed score tables for ADA, AMPC and COMT. Each target was
represented by three fixed-seed scenarios with 24 ligands per scenario, including
six DUD-E-labelled actives and 18 decoys [1]. We first audited table integrity, then
described pairwise rank agreement and retrospective label-separation summaries.
All nine target-scenario tables satisfied the declared structural contract: 24
rows, 24 unique ligands, no duplicate pairs, no invalid identifiers, no
non-finite scores and no missing expected pairs. Pairwise Spearman agreement
across seeds ranged from 0.970 to 0.982 for ADA, 0.985 to 0.998 for AMPC, and
0.930 to 0.975 for COMT. Retrospective ROC AUC across seeds ranged from 0.343 to
0.380 for ADA, 0.528 to 0.565 for AMPC and 0.769 to 0.796 for COMT. These
results illustrate transparent separation of data integrity, rank agreement and
retrospective discrimination summaries. They do not establish molecular binding,
biological activity, efficacy, safety, superiority of a docking program or
prospective screening performance.

**Keywords:** molecular docking; reproducibility; rank stability; retrospective
benchmarking; scientific software; R.

## 1. Introduction

Docking scores are commonly used to prioritize candidates for subsequent work,
but a ranking alone does not document whether the input table was complete, the
ranking is stable under recorded settings, or a retrospective label set is being
used appropriately. We present a small pilot organized around a transparent
workflow: protocol declaration, file provenance, integrity audit, rank agreement,
comparison, consensus, retrospective benchmarking and reporting.

The objective is methodological. The pilot demonstrates what can be reported
from documented computational outputs while maintaining a boundary between a
computational prioritization and experimental validation.

## 2. Materials and methods

### 2.1 Design and scope

The analysis followed the prespecified plan in
[`../protocol/ANALYSIS-PLAN.md`](../protocol/ANALYSIS-PLAN.md). ADA, AMPC and
COMT were treated separately. No metric was pooled across targets because score
distributions and target-specific conditions are not directly comparable.

### 2.2 Pilot tables and labels

The documented local pilot comprised three fixed Vina seeds per target and 24
ligands per target-scenario: six DUD-E-labelled actives and 18 decoys. Original
DUD-E archives, prepared structures, poses, raw docking logs and local score
tables are excluded from this repository.

### 2.3 Integrity and rank analyses

For each target-scenario table, we checked row count, unique ligand identifiers,
duplicate ligand-scenario pairs, identifier validity, finite scores and expected
pair coverage. Pairwise Spearman correlation across the three seed rankings was
used as a descriptive rank-agreement summary. Complete coverage was reported
separately.

### 2.4 Retrospective label-separation summaries

When the documented DUD-E labels were available, ROC AUC, average precision and
top-5 enrichment factor were reported by target and as ranges across seeds. The
metrics are retrospective summaries of the supplied labels and settings.

## 3. Results

### 3.1 Integrity

All nine tables met the declared structural contract: 24 rows and 24 unique
ligands per table, with zero duplicate pair rows, invalid identifiers,
non-finite scores or missing expected pairs.

### 3.2 Rank agreement

Each ligand appeared in all three seed rankings for its target. Pairwise
Spearman agreement ranged from 0.970–0.982 for ADA, 0.985–0.998 for AMPC and
0.930–0.975 for COMT.

### 3.3 Retrospective summaries

| Target | ROC AUC across seeds | Average precision across seeds | Top-5 enrichment factor across seeds |
|---|---:|---:|---:|
| ADA | 0.343–0.380 | 0.239–0.368 | 0.8 |
| AMPC | 0.528–0.565 | 0.276–0.293 | 0.0 |
| COMT | 0.769–0.796 | 0.476–0.569 | 1.6 |

The target-specific ranges differed materially, so they were retained rather
than combined into a single global estimate.

## 4. Discussion

This pilot shows that a transparent computational report can distinguish three
different statements: the supplied tables met a defined integrity contract; the
rankings had high global pairwise agreement under the recorded seeds; and
retrospective label-separation summaries varied across targets. These statements
are not interchangeable. In particular, high global rank correlation does not
guarantee stable identity among the top candidates, and retrospective metrics do
not validate biological binding or prospective screening performance.

The work is limited by its small size, fixed seeds, retrospective labels and the
absence of independent re-execution from distributable inputs. It is intended as
a reproducibility-oriented case study and a template for more comprehensive,
legally shareable investigations.

## 5. Conclusions

The pilot provides a documented example of reporting integrity, rank agreement
and retrospective discrimination separately for precomputed docking tables. The
companion workflow makes the analytic boundaries explicit and supports future
independent reruns. Experimental validation remains necessary for biological or
therapeutic claims.

## Data and code availability

The analysis protocol and aggregate results are in this repository. Companion
software releases provide the implementation context. Third-party archives,
prepared structures, raw logs, poses and local score tables are not redistributed.
The visual evidence pathway, rendering script and supplementary procedural note
are available in `reports/` and `manuscript/SUPPLEMENTARY-EVIDENCE-NOTE.md`.

## Author contributions

To be confirmed by all authors before submission. The final manuscript must use
the agreed CRediT contribution statement.

## Competing interests

The authors declare no competing interests.

## References

1. Mysinger MM, Carchia M, Irwin JJ, Shoichet BK. Directory of useful decoys,
   enhanced (DUD-E): better ligands and decoys for better benchmarking. *Journal
   of Medicinal Chemistry*. 2012;55(14):6582–6594.
   https://doi.org/10.1021/jm300687e
