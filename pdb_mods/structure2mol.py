#!/usr/bin/python
#xyz2mol for gas phase calculation (no ECP)
from sys import argv
from os.path import basename
import os

if len(argv) != 2:
  print ('''Provide XYZ file name''')
  exit()


xyz_file = open(argv[1], 'r')

xyz_data = xyz_file.readlines()

Clist = []
Hlist = []
Nlist = []
Olist = []
Slist = []
CLlist = []
Flist = []
SIlist = []
Plist = []


for line in xyz_data[2:]:

  if 'C ' in line:

    Clist.append(line)

  elif 'H ' in line:

    Hlist.append(line)

  elif 'N ' in line:

    Nlist.append(line)

  elif 'O ' in line:

    Olist.append(line)

  elif 'S ' in line:

    Slist.append(line)

  elif 'Cl ' in line:

    CLlist.append(line)

  elif 'F ' in line:

    Flist.append(line)

  elif 'Si ' in line:

    SIlist.append(line)

  elif 'P ' in line:

    Plist.append(line)

extension = ".mol"
filename = argv[1]
filename_wo_ext = os.path.splitext(filename)[0]
new_name = filename_wo_ext + extension

output = open(new_name, 'w')

if len(Clist) != 0:
  output.write('Charge=6.0 Atoms=%d Basis=aug-cc-pVDZ \n'% (len(Clist)))
  for el in Clist:
    output.write(el)

if len(Hlist) != 0:
  output.write('Charge=1.0 Atoms=%d Basis=aug-cc-pVDZ \n'% (len(Hlist)))
  for el in Hlist:
    output.write(el)

if len(Nlist) != 0:
  output.write('Charge=7.0 Atoms=%d Basis=aug-cc-pVDZ \n'% (len(Nlist)))
  for el in Nlist:
    output.write(el)

if len(Olist) != 0:
  output.write('Charge=8.0 Atoms=%d Basis=aug-cc-pVDZ \n'% (len(Olist)))
  for el in Olist:
    output.write(el)

if len(Slist) != 0:
  output.write('Charge=16.0 Atoms=%d Basis=aug-cc-pVDZ \n'% (len(Slist)))
  for el in Slist:
    output.write(el)

if len(CLlist) != 0:
  output.write('Charge=17.0 Atoms=%d Basis=aug-cc-pVDZ \n'% (len(CLlist)))
  for el in CLlist:
    output.write(el)

if len(Flist) != 0:
  output.write('Charge=9.0 Atoms=%d Basis=aug-cc-pVDZ \n'% (len(Flist)))
  for el in Flist:
    output.write(el)

if len(SIlist) != 0:
  output.write('Charge=14.0 Atoms=%d Basis=aug-cc-pVDZ \n'% (len(SIlist)))
  for el in SIlist:
    output.write(el)

if len(Plist) != 0:
  output.write('Charge=15.0 Atoms=%d Basis=aug-cc-pVDZ \n'% (len(Plist)))
  for el in Plist:
    output.write(el)
