#!/usr/bin/env python3
"""Create auditable AMPC receptor and reference-ligand source files.

This script performs only the structural selection prespecified in
TIER2-AMPC-RCSB-1L2S-V1.md. It does not prepare molecules or run docking.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("input_pdb", type=Path)
    parser.add_argument("output_dir", type=Path)
    arguments = parser.parse_args()

    source = arguments.input_pdb.resolve(strict=True)
    output_dir = arguments.output_dir.resolve()
    output_dir.mkdir(parents=True, exist_ok=True)
    receptor = output_dir / "1l2s_chain_a_receptor.pdb"
    reference = output_dir / "1l2s_chain_a_stc.pdb"
    manifest = output_dir / "1l2s_selection_manifest.json"

    receptor_rows: list[str] = []
    reference_rows: list[str] = []
    for row in source.read_text(encoding="utf-8").splitlines():
        record = row[:6].strip()
        chain = row[21:22]
        residue = row[17:20].strip()
        residue_number = row[22:26].strip()
        element = row[76:78].strip()
        if record == "ATOM" and chain == "A":
            if not element:
                raise ValueError("Encountered an ATOM row without an element field.")
            receptor_rows.append(row)
        if record == "HETATM" and chain == "A" and residue == "STC" and residue_number == "1115":
            if not element:
                raise ValueError("Encountered an STC row without an element field.")
            reference_rows.append(row)

    if not receptor_rows:
        raise ValueError("No chain-A ATOM records were selected.")
    if not reference_rows:
        raise ValueError("No chain-A STC 1115 records were selected.")

    receptor.write_text("\n".join(receptor_rows) + "\nTER\nEND\n", encoding="utf-8")
    reference.write_text("\n".join(reference_rows) + "\nEND\n", encoding="utf-8")
    manifest.write_text(
        json.dumps(
            {
                "input_pdb": str(source),
                "input_sha256": sha256(source),
                "selection": {
                    "receptor": "ATOM records with chain A",
                    "reference_ligand": "HETATM STC chain A residue 1115",
                },
                "receptor_atom_records": len(receptor_rows),
                "reference_ligand_atom_records": len(reference_rows),
                "receptor_sha256": sha256(receptor),
                "reference_ligand_sha256": sha256(reference),
            },
            indent=2,
            sort_keys=True,
        )
        + "\n",
        encoding="utf-8",
    )


if __name__ == "__main__":
    main()
