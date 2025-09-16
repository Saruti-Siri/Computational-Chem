#!/usr/bin/python

from sys import argv
from math import pi

dane = open('data.txt', 'r').readlines()
dane2 = open('OPA.txt', 'r').readlines()

#1 Hartree 
ev=27.2114

#Fine structure constant
alfa=7.29735e-3

if len(argv) == 1:

  print ('''This script requires the following arguments:

N --- parameter allowing comparison with different experiments
gamma --- spectral broadening (for the Lorentz curve) 
''')

  exit(1)


#Band width [eV]
gamma=float(argv[2])
#N parameter
N=float(argv[1])


c=2.9979e10
a0=5.29177e-9

i = 1

for line1, line2 in zip(dane[0:], dane2[0:]):

  words1 = line1.split()
  words2 = line2.split()

#  state = int(words1[0])

  EE = float(words1[0])

  D = float(words1[1])

  f = float(words2[0])

  sigma=(N*pi**2*alfa*a0**5*(EE/(2*ev))**2*D)/(c*gamma/ev) * 1e50

  print ('& %5.2f & %8.5f  & %.5f &'% (EE,  f, sigma ))
  i+=1  


