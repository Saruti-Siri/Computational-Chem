pcregrep -C 3 -M '@ B excited state no., symmetry, spin:             1    1    0*\n.*@ C excited state no., symmetry, spin:             1    1    0' output.log >> dpm.raw 

pcregrep -C 3 -M '@ B excited state no., symmetry, spin:             2    1    0*\n.*@ C excited state no., symmetry, spin:             2    1    0' output.log >> dpm.raw

pcregrep -C 3 -M '@ B excited state no., symmetry, spin:             3    1    0*\n.*@ C excited state no., symmetry, spin:             3    1    0' output.log >> dpm.raw

pcregrep -C 3 -M '@ B excited state no., symmetry, spin:             4    1    0*\n.*@ C excited state no., symmetry, spin:             4    1    0' output.log >> dpm.raw

pcregrep -C 3 -M '@ B excited state no., symmetry, spin:             5    1    0*\n.*@ C excited state no., symmetry, spin:             5    1    0' output.log >> dpm.raw

pcregrep -C 3 -M '@ B excited state no., symmetry, spin:             6    1    0*\n.*@ C excited state no., symmetry, spin:             6    1    0' output.log >> dpm.raw

pcregrep -C 3 -M '@ B excited state no., symmetry, spin:             7    1    0*\n.*@ C excited state no., symmetry, spin:             7    1    0' output.log >> dpm.raw

pcregrep -C 3 -M '@ B excited state no., symmetry, spin:             8    1    0*\n.*@ C excited state no., symmetry, spin:             8    1    0' output.log >> dpm.raw

pcregrep -C 3 -M '@ B excited state no., symmetry, spin:             9    1    0*\n.*@ C excited state no., symmetry, spin:             9    1    0' output.log >> dpm.raw

pcregrep -C 3 -M '@ B excited state no., symmetry, spin:            10    1    0*\n.*@ C excited state no., symmetry, spin:            10    1    0' output.log >> dpm.raw

grep '@ B and C excitation energies,' dpm.raw >> dpm2.raw

awk '{ print $NF }' dpm2.raw > data.raw

awk '{print $1/(0.393456)}' < data.raw > dat.raw

sed -n -e 1p -e 4p -e 7p -e 10p -e 13p -e 16p -e 19p -e 22p -e 25p -e 28p dat.raw > x_raw
sed -n -e 2p -e 5p -e 8p -e 11p -e 14p -e 17p -e 20p -e 23p -e 26p -e 29p dat.raw > y_raw
sed -n -e 3p -e 6p -e 9p -e 12p -e 15p -e 18p -e 21p -e 24p -e 27p -e 30p dat.raw > z_raw


paste x_raw y_raw z_raw > dpm0.txt

rm *raw

#cat data.raw | awk '{sum += $1; if (NR % 3 == 0) {print sum; sum=0}} END {if (NR % 3 != 0) print sum}' > comb.data

