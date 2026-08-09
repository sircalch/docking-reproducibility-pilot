# Reproduce the visual evidence report

The figures in this repository are generated from the documented ranges in
`results/PILOT-METRIC-RANGES.csv`, which transcribes the results record in
`results/PILOT-RESULTS.md`, and from the evidence-state record. They do not
download data, prepare structures, run docking engines, or generate new scores.

From the repository root, run:

```r
Rscript reports/render_figures.R
```

The command writes:

- `reports/figures/figure-1-evidence-pathway.svg`
- `reports/figures/figure-2-retrospective-metrics.svg`
- `reports/figures/figure-3-top5-enrichment.svg`

For a portable verification (the approach used in CI), render to an empty
temporary directory and confirm that the three SVG files are non-empty:

```r
Rscript reports/render_figures.R path/to/temporary/evidence-figures
```

The committed SVGs are versioned display artifacts. Their bytes can differ
between operating systems because R's SVG device encodes local font glyphs;
therefore byte-for-byte comparison is not a valid cross-platform scientific
check. The renderer instead validates the complete 3-by-4 target/metric data
contract before producing the three figures. The `Evidence check` workflow
runs this portable rendering check on GitHub. The Python
structural-selection and repair scripts are compiled for syntax only; they are
not run in CI because they depend on deliberately untracked external source
files and isolated local scientific tools.
