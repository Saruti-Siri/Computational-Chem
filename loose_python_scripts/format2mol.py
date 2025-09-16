import re
import os
from sys import argv
if len(argv) != 2:
  print ('''input.mol''')
  exit()
#atomtypes #
chargelist = []

#format spacings
output = open('MOLECULE.mol', "w")
input = open(argv[1])
for line in input:
	li=line.strip()
	if not li.startswith("Charge"):
		output.write(re.sub(r' ', '  ', line))#	else:
	else:
		output.write(line); chargelist.append(line)
input.close()
output.close()

filename = argv[1]
filename_wo_ext = os.path.splitext(filename)[0]

with open('MOLECULE.mol', 'r') as original: data = original.read()
with open('MOLECULE.mol', 'w') as modified: modified.write('ATOMBASIS\n' + filename_wo_ext + '\n---------------\nAngstrom Atomtypes=%d Spherical\n'% (len(chargelist)) + data)

#oldfile_name = "/home/saruti/first_proj/loprop/new/out.mol"
#newfile_name = "/home/saruti/first_proj/loprop/new/MOLECULE.mol"
#for file in os.listdir("/home/saruti/first_proj/loprop/new"):
#	os.rename(file, f"/home/saruti/first_proj/loprop/new/old_{MOLECULE.mol}")
#	os.rename(oldfile_name, newfile_name)
