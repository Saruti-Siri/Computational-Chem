import parmed as pmd
gro = pmd.load_file('rhod_solv.gro')
gro.save('rhod_solv.mol2')

