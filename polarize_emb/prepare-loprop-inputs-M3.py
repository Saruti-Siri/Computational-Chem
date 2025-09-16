import os
import sys
#import pelib
import pyframe

# Create Project() object
project = pyframe.Project()
# Set path to scratch directory.
# This will be used by the auxiliary programs, e.g. Dalton or MOLCAS.
project.scratch_dir = '$HOME/tmp/scratch' 
# Set path to working directory (it will be created if it does not exist).
# This directory will contain the final output files from PyFraME (e.g. Dalton mol and pot files),
# and a directory for each fragment which will contain output from the auxiliary program, e.g. Dalton or MOLCAS.
wd = os.getcwd()
project.work_dir = wd
#Where is molcas?
os.environ['MOLCAS'] = '$HOME/Molcas/open_3/build/pymolcas'

# Specifies the number of jobs that will be run on each node.
# A fragment may require one or more calculations run by an auxiliary program.
# Each of these counts as a job.
project.jobs_per_node = 6
# Specifies memory per job.
# Note that this amount will be shared by MPI processes
project.memory_per_job = 2048
# Number of MPI processes per job
project.mpi_procs_per_job = 1
# You can manually specify the name of nodes that should be used to run jobs.
# PyFraME will attempt to autodetect nodes from SLURM and PBS/Torque queuing systems.
#project.node_list = ['{0}'.format(os.environ['HOSTNAME'])]
# Prints all the details regarding the setup.
# Note that all of the settings demonstrated above have defaults which are shown with the method below.
#project.print_info()

# Create MolecularSystem() object.
# Currently only PDB and some forms of PQR are supported (however you can give your own reader as input).
# The bond_threshold argument defines the factor that should be applied when detecting bonds.
system = pyframe.MolecularSystem(input_file='./18_PS_0.3nm_shell.pdb')


#Split chromophore preceeding and following residues into two fragments
#system.split_fragment_by_identifier(identifier='64_PHE', new_names=['PHEA', 'PHEB'], fragment_definitions=[['C', 'O'], ['CA', 'HA', 'N', 'H', 'CB', 'HB1', 'HB2', 'CG', 'CD1', 'HD1', 'CE1', 'HE1', 'CZ', 'HZ', 'CD2', 'HD2', 'CE2', 'HE2']])

system.split_fragment_by_identifier(identifier='295_X_ALA', new_names=['ALAA', 'ALAB'], fragment_definitions=[['C', 'O'], ['CA', 'HA', 'N', 'H', 'CB', 'HB1', 'HB2', 'HB3']])

system.split_fragment_by_identifier(identifier='297_X_THR', new_names=['THRA', 'THRB'], fragment_definitions=[['N', 'H', 'CA', 'HA'], ['CB', 'HB', 'CG2', '1HG2', '2HG2', '3HG2', 'OG1', 'HG1', 'C', 'O']])

system.split_fragment_by_identifier(identifier='114_X_GLY', new_names=['GLYA', 'GLYB'], fragment_definitions=[['N', 'H', 'CA', 'HA1', 'HA2'], ['C', 'O']])

system.split_fragment_by_identifier(identifier='112_X_LEU', new_names=['LEUA', 'LEUB'], fragment_definitions=[['C', 'O'], ['CA', 'HA', 'N', 'H', 'CB', 'HB1', 'HB2', 'CG', 'HG', 'CD1', '1HD1', '2HD1', '3HD1', 'CD2', '1HD2', '2HD2', '3HD2']])

system.split_fragment_by_identifier(identifier='181_X_GLH', new_names=['GLHB', 'GLHA'], fragment_definitions=[['C', 'O', 'CA', 'HA', 'N', 'H'], ['CB', 'HB1', 'HB2', 'CG', 'HG1', 'HG2', 'CD', 'OE1', 'OE2', 'HE2']])


# take fragment and put them in core region
core = system.get_fragments_by_name(names=['RET', 'ALAA', 'THRA', 'LEUA', 'GLYA', 'GLHA'])
core2 = system.get_fragments_by_identifier(identifiers=['113_X_GLU'])
water_QM = system.get_fragments_by_identifier(identifiers=['6358_X_SOL', '6402_X_SOL', '349_X_SOL', '5798_X_SOL', '350_X_SOL', '5812_X_SOL', '5782_X_SOL'])

core.update(water_QM)
core.update(core2)

#core_capp = system.get_fragments_by_name(names)
system.set_core_region(core, basis='ANO-L-VDZP')

##########
#If protect_molecules=True, the whole protein is 
#written in. USEFUL LATER ON!!!
protein = system.get_fragments_by_name(names=['GLY', 'ALA', 'VAL', 'LEU', 'ILE', 'MET', 
'PRO', 'PHE', 'TRP', 'SER', 'THR', 'HIP', 'ASH', 'HID', 'GLH', 
'ASN', 'GLN', 'TYR', 'CYS', 'LYS', 'ARG', 'HIS', 'ASP', 'GLU', 'ALAB', 'THRB', 'LEUB', 'GLYB', 'GLHB'])
# Add a region and place the protein in it.
# Note that each of these settings have defaults and that there are more than those shown here.
system.add_region(name='protein', fragments=protein, use_mfcc=True, 

mfcc_order=2, use_multipoles=True, multipole_order=2, 

multipole_basis='ANO-L-VDZP', use_polarizabilities=True,

polarizability_basis='ANO-L-VDZP', multipole_program='molcas', 

multipole_method = 'DFT', multipole_xcfun = 'B3LYP',

polarizability_program='molcas', polarizability_method = 'DFT', 

polarizability_xcfun = 'B3LYP'
)

water = system.get_fragments_by_name(names=['SOL'])

system.add_region(name='water', fragments=water, use_multipoles=True, 

multipole_order=2, multipole_basis='ANO-L-VDZP', 

use_polarizabilities=True, polarizability_basis='ANO-L-VDZP', 

multipole_program='molcas', multipole_method = 'DFT', multipole_xcfun = 'B3LYP',

polarizability_program='molcas', polarizability_method = 'DFT', 

polarizability_xcfun = 'B3LYP'
)

ions = system.get_fragments_by_name(names=['Cl', 'NA'])

system.add_region(name='ion', fragments=ions, use_multipoles=True,

multipole_order=0, multipole_basis='ANO-L-VDZP',

use_polarizabilities=True, polarizability_basis='ANO-L-VDZP',

multipole_program='molcas', multipole_method = 'DFT', multipole_xcfun = 'B3LYP',

polarizability_program='molcas', polarizability_method = 'DFT',

polarizability_xcfun = 'B3LYP'
)

project.create_inputs(system)
# This will start the necessary fragment calculations using the using the auxiliary programs and settings defined when creating the regions.
#project.create_embedding_potential(system)
##
### Create pot file
#system.write_potential()
#### Create mol file
#system.write_core()
#
exit()
