# Deviation 001: AMPC receptor parsing

## Event

On 2026-08-09, the prescribed initial receptor-preparation command attempted
to read the unchanged DUD-E file `ampc/receptor.pdb` with Meeko's `--read_pdb`
parser. It stopped before producing a prepared receptor. The parser reported a
missing element symbol. A read-only inspection found that all 3,409 `ATOM` or
`HETATM` rows omit the PDB element field.

## Effect on results

There are no docking results, poses, scores, rankings, or label-based metrics
from this attempt. The source archive remains unchanged. The failed command
log is retained locally in `derived-data/ampc-tier2-v1/prepare_receptor.log`.

## Prespecified resolution

The next attempt will use Meeko's documented `--read_with_prody` input path
after installing ProDy in the isolated environment and recording its exact
version. This changes the parser, not the source receptor. The original
`--read_pdb` failure remains part of the run record.

No other preparation settings, input structures, docking parameters, or
candidate-selection rules change under this deviation.
