#!/usr/bin/python3

#This script computes the angle between single-photon moment vectors
#transitions and changes of the dipole moment. You only need to enter the state 
#for which the moment of transition should be taken


from sys import argv
import re
import os
import numpy as np

if len(argv) != 2:

  print('Enter the state number for which you want to count kat.')

  exit()

output_pattern = re.compile('[a-zA-Z0-9]*.log')

files = os.listdir('./')

for name in files:

  if re.match(output_pattern, name):

    output_name = name

    break

S0_file = open('./S0/%s'% name, 'r')
Sn_file = open(name, 'r')

#Get dipole moment vector for S0 state
for line in S0_file:

  if line.startswith('    X=     '):

    words = line.split()
    S0_dipole = np.array([float(words[i]) for i in range(1, 6, 2)])


#Get dipole moment and transition moment vectors for S1
moment_pattern = re.compile("^\s{8,9}%s"% argv[1])
for line in Sn_file:

  if line.startswith('    X=        '):

    words = line.split()
    Sn_dipole = np.array([float(words[i]) for i in range(1, 6, 2)])


Sn_file.seek(0)

for line in Sn_file:

  if re.match(moment_pattern, line):

    words = line.split()
    moment = np.array([float(words[i]) for i in range(1, 4)])
 
    break


dmu = Sn_dipole - S0_dipole

dot_product = np.dot(dmu, moment)
len_dmu = np.linalg.norm(dmu)
len_moment = np.linalg.norm(moment)

cos2 = 1 + 2*(dot_product / (len_dmu * len_moment))**2

alfa = np.degrees(np.arccos( dot_product / (len_dmu * len_moment)  ))

print('%-5.1f & %.4f'% (alfa, cos2))




