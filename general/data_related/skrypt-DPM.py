#!/usr/bin/python

from sys import argv
from math import pi

dane = open('dpm.txt', 'r').readlines()

for line1 in (dane[0:]):

  words1 = line1.split("\t")

#  state = int(words1[0])

  X = float(words1[0])

  Y = float(words1[1])

  Z = float(words1[2])

  dipmo=(((X**2)+(Y**2)+(Z**2))**0.5)
  print ('%.3f &'% (dipmo))


