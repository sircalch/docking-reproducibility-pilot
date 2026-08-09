#!/usr/bin/env python3
"""Select an unmodified protein chain from an RCSB legacy PDB file.

This utility does not repair coordinates, prepare a receptor, or run docking.
It writes selected ATOM records and a checksum manifest for a prespecified
receptor-qualification campaign.
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
    parser.add_argument("chain_id")
    parser.add_argument("output_dir", type=Path)
    parser.add_argument("--entry-id", required=True)
    arguments = parser.parse_args()
    if len(arguments.chain_id) != 1:
        raise ValueError("chain_id must be one character.")

    source = arguments.input_pdb.resolve(strict=True)
    output_dir = arguments.output_dir.resolve()
    output_dir.mkdir(parents=True, exist_ok=True)
    stem = f"{arguments.entry_id.lower()}_chain_{arguments.chain_id.lower()}"
    receptor = output_dir / f"{stem}_receptor.pdb"
    manifest = output_dir / f"{stem}_selection_manifest.json"

    receptor_rows: list[str] = []
    residues: set[tuple[str, str, str]] = set()
    for row in source.read_text(encoding="utf-8").splitlines():
        if row[:6].strip() != "ATOM" or row[21:22] != arguments.chain_id:
            continue
        if not row[76:78].strip():
            raise ValueError("Encountered an ATOM row without an element field.")
        receptor_rows.append(row)
        residues.add((row[17:20].strip(), row[22:26].strip(), row[26:27]))

    if not receptor_rows:
        raise ValueError("No selected-chain ATOM records were found.")
    receptor.write_text("\n".join(receptor_rows) + "\nTER\nEND\n", encoding="utf-8")
    manifest.write_text(
        json.dumps(
            {
                "input_pdb": str(source),
                "input_sha256": sha256(source),
                "selection": f"ATOM records from chain {arguments.chain_id}; no repair or editing",
                "receptor_atom_records": len(receptor_rows),
                "unique_residue_identifiers": len(residues),
                "receptor_sha256": sha256(receptor),
            },
            indent=2,
            sort_keys=True,
        )
        + "\n",
        encoding="utf-8",
    )


if __name__ == "__main__":
    main()
