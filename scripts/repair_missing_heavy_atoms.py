#!/usr/bin/env python3
"""Perform the narrowly prespecified PDBFixer heavy-atom repair."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path

from openmm.app import PDBFile
from pdbfixer import PDBFixer


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def residue_label(residue) -> str:
    return f"{residue.chain.id}:{residue.name}{residue.id}"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("input_pdb", type=Path)
    parser.add_argument("output_dir", type=Path)
    arguments = parser.parse_args()

    source = arguments.input_pdb.resolve(strict=True)
    output_dir = arguments.output_dir.resolve()
    output_dir.mkdir(parents=True, exist_ok=True)
    repaired = output_dir / "1l2s_chain_a_heavy_atom_repaired.pdb"
    manifest_path = output_dir / "heavy_atom_repair_manifest.json"

    fixer = PDBFixer(filename=str(source))
    fixer.findMissingResidues()
    missing_residues = {
        f"chain_index={chain_index}; insertion_index={residue_index}": names
        for (chain_index, residue_index), names in fixer.missingResidues.items()
    }
    fixer.missingResidues = {}

    fixer.findNonstandardResidues()
    nonstandard = [residue_label(residue) for residue, _ in fixer.nonstandardResidues]
    if nonstandard:
        raise RuntimeError("Nonstandard residues detected: " + ", ".join(nonstandard))

    fixer.findMissingAtoms()
    missing_atoms = {
        residue_label(residue): [atom.name for atom in atoms]
        for residue, atoms in fixer.missingAtoms.items()
    }
    missing_terminals = {
        residue_label(residue): names
        for residue, names in fixer.missingTerminals.items()
    }
    fixer.addMissingAtoms()

    with repaired.open("w", encoding="utf-8") as handle:
        PDBFile.writeFile(fixer.topology, fixer.positions, handle, keepIds=True)

    manifest = {
        "input_pdb": str(source),
        "input_sha256": sha256(source),
        "policy": {
            "whole_residues_added": False,
            "nonstandard_residues_replaced": False,
            "hydrogens_added": False,
            "energy_minimization": False,
        },
        "detected_missing_residues_not_added": missing_residues,
        "detected_nonstandard_residues": nonstandard,
        "added_missing_atoms": missing_atoms,
        "added_missing_terminal_atoms": missing_terminals,
        "output_pdb": str(repaired),
        "output_sha256": sha256(repaired),
    }
    manifest_path.write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
