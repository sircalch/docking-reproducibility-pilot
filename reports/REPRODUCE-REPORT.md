# Reproduce the visual evidence report

The figures in this repository are generated from the documented values in
`results/PILOT-RESULTS.md` and from the evidence-state record. They do not
download data, prepare structures, run docking engines, or generate new scores.

From the repository root, run:

```r
Rscript reports/render_figures.R
```

The command writes:

- `reports/figures/figure-1-evidence-pathway.svg`
- `reports/figures/figure-2-retrospective-metrics.svg`
- `reports/figures/figure-3-top5-enrichment.svg`

Then confirm that the committed figures are current:

```sh
git diff --exit-code -- reports/figures
```

The `Evidence check` workflow runs these two steps on GitHub. The Python
structural-selection and repair scripts are compiled for syntax only; they are
not run in CI because they depend on deliberately untracked external source
files and isolated local scientific tools.
