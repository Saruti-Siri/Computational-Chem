#!/usr/bin/python

from sys import argv

if len(argv) != 2:
  print ('''Provide .mol file outputted from pyframe.''')
  exit()


xyz_file = open(argv[1], 'r')

xyz_data = xyz_file.readlines()

Clist = []
Hlist = []
Nlist = []
Olist = []
Slist = []


for line in xyz_data[2:]:

  if 'C     ' in line:

    Clist.append(line)

  elif 'H     ' in line:

    Hlist.append(line)

  elif 'N     ' in line:

    Nlist.append(line)

  elif 'O     ' in line:

    Olist.append(line)

  elif 'S     ' in line:

    Slist.append(line)

output = open('out_og.mol', 'w')

output.write('Charge=6.0 Atoms=%d Basis=aug-cc-pVDZ\n'% (len(Clist)))
for el in Clist:
  output.write(el)

output.write('Charge=1.0 Atoms=%d Basis=aug-cc-pVDZ\n'% (len(Hlist)))
for el in Hlist:
  output.write(el)

output.write('Charge=7.0 Atoms=%d Basis=aug-cc-pVDZ\n'% (len(Nlist)))
for el in Nlist:
  output.write(el)

output.write('Charge=8.0 Atoms=%d Basis=aug-cc-pVDZ\n'% (len(Olist)))
for el in Olist:
  output.write(el)

if len(Slist) != 0:
  output.write('Charge=16.0 Atoms=%d Basis=aug-cc-pVDZ\n'% (len(Slist)))
  for el in Slist:
    output.write(el)


