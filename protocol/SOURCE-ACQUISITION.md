# External-source acquisition record

This document records sources that may be acquired for a future end-to-end
computational rerun. It is not a dataset release and it does not claim that any
download, preparation, or docking calculation has been completed.

## Source registry

| Target ID | Target | Official target page | Archive URL | DUD-E page counts |
|---|---|---|---|---:|
| ADA | Adenosine deaminase | <https://dude.docking.org/targets/ada> | <https://dude.docking.org/targets/ada/ada.tar.gz> | 98 raw; 93 clustered; 5,450 decoys |
| AMPC | Beta-lactamase | <https://dude.docking.org/targets/ampc> | <https://dude.docking.org/targets/ampc/ampc.tar.gz> | 48 raw; 48 clustered; 2,850 decoys |
| COMT | Catechol O-methyltransferase | <https://dude.docking.org/targets/comt> | <https://dude.docking.org/targets/comt/comt.tar.gz> | 41 raw; 41 clustered; 3,850 decoys |

Source pages and URLs were checked on 2026-08-09. DUD-E identifies itself as a
benchmarking resource and requests citation of Mysinger, Carchia, Irwin, and
Shoichet (2012), DOI: <https://doi.org/10.1021/jm300687e>.

## Acquisition procedure

1. Download each archive from the official URL into a local, untracked
   `external-data/` directory; do not commit third-party archives to this
   repository.
2. Record retrieval date, final URL, file size, SHA-256 checksum, and any
   access or license notices present at retrieval.
3. Extract into a separate untracked directory and record an inventory and
   checksum manifest before selecting any structures or ligands.
4. Retain the original archives unchanged. Any prepared receptor, ligand, grid,
   seed, configuration, log, and score table must receive a distinct manifest.
5. Before analysis, publish or archive only the materials that can lawfully be
   shared. If external source files cannot be redistributed, publish their
   retrieval record and checksums instead.

## Deliberate non-actions

This repository does not select a subset, prepare structures, choose a docking
box, run an engine, or compute scores from these source archives. Those choices
are a future Tier 2 protocol and must be prespecified and logged before any
calculation.
