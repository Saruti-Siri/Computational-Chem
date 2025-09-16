import re
import os

output = open("out.mol", "w")
input = open("out_og.mol")
for line in input:
	li=line.strip()
	if not li.startswith("Charge"):
		output.write(re.sub(r' ', '  ', line))#	else:
	else:
		output.write(line)

input.close()
output.close()

fin = open("structure.mol", "r")
newdata = fin.read()
fin.close()

fout = open("out.mol", "a")
fout.write(newdata)
fout.close()

with open('out.mol', 'r') as original: data = original.read()
with open('out.mol', 'w') as modified: modified.write('ATOMBASIS\nGFP chromophore\n---------------\nAngstrom Atomtypes=9 Spherical Nosymetry Charge=-1\n' + data)

#oldfile_name = "/home/saruti/first_proj/loprop/new/out.mol"
#newfile_name = "/home/saruti/first_proj/loprop/new/MOLECULE.mol"
#for file in os.listdir("/home/saruti/first_proj/loprop/new"):
#	os.rename(file, f"/home/saruti/first_proj/loprop/new/old_{MOLECULE.mol}")
#	os.rename(oldfile_name, newfile_name)
