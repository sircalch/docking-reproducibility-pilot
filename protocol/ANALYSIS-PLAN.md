# Prespecified analysis plan

1. Treat each target separately; no pooling across target score distributions.
2. Audit each target-seed table for row count, unique identifiers, duplicate
   pairs, finite scores and declared coverage.
3. Calculate pairwise Spearman rank agreement across the three fixed seeds.
4. When DUD-E labels are available, report ROC AUC, average precision and top-5
   enrichment factor separately for each target and seed.
5. Report ranges across seeds, not a pooled performance estimate.
6. State that all label-based metrics are retrospective and limited to the
   documented tables.

Any analysis outside this plan must be recorded as a deviation.
