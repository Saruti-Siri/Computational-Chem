import parmed as pmd
from parmed import gromacs, amber, unit as u
gromacs.GROMACS_TOPDIR = "/home/saruti/rhodopsin/gromacs/amber94"
gmx_top=pmd.gromacs.GromacsTopologyFile(fname='a-ARM_Rh_GLH-181_CASTp_18273.top')
gmx_gro=pmd.gromacs.GromacsGroFile.parse('final-a-ARM_Rh_GLH-181_CASTp_18273.gro')
gmx_top.box=gmx_gro.box # .prmtop requires box info
gmx_top.positions=gmx_gro.positions
amb_prm=pmd.amber.AmberParm.from_structure(gmx_top)
amb_prm.write_parm("rhod.prmtop")
amb_inpcrd=pmd.amber.AmberAsciiRestart("inpcrd", mode="w")
amb_inpcrd.coordinates=gmx_top.coordinates
amb_inpcrd.box=gmx_top.box
amb_inpcrd.close()
