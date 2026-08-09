# Deviation 004: controlled repair did not pass receptor validation

## Event

The prespecified PDBFixer repair from Amendment 001 completed successfully on
the selected 1L2S chain-A protein. It detected no whole missing residues or
nonstandard protein residues and added the documented heavy atoms at ten
existing residues. It did not add hydrogens or perform minimization.

The repaired file then failed the required Meeko acceptance check before a
PDBQT receptor was produced. Meeko reported incompatible inter-residue padding
for residue pairs A:262/A:296 and A:264/A:282.

## Decision

The repaired receptor is not accepted for docking. No alternate converter,
automatic bond edit, residue deletion, geometry minimization, or Vina command
will be used to bypass this validation failure.

## Result classification

This is a negative workflow-validation finding: the narrowly controlled repair
is not sufficient to establish a usable AMPC receptor under the current Meeko
route. It is not a docking result and it does not support any molecular,
biological, or performance claim.

## Required next action

Further Tier 2 work requires a reviewed structural-preparation protocol that
addresses the crystallographic disorder and inter-residue connectivity, with
validation appropriate to the selected software. The current AMPC Tier 2
exercise is stopped at this point.
