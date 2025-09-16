import parmed as pmd
gmx_top = pmd.load_file('a-ARM_Rh_GLH-181_CASTp_18273.top', xyz='final-a-ARM_Rh_GLH-181_CASTp_18273.gro')
gmx_top.save('rhod.top', format='amber')
gmx_top.save('rhod.crd', format='rst7')
