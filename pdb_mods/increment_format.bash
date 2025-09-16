tr -s ' '  '\n' < $1 > temp
awk '{print i++ " " $0}' < temp > bond_final
rm temp*
