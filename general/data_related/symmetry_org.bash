awk '{print $2}' data.txt > temp_delta
paste scheme+t1 TPA+OPA temp_delta > temp_org
#d2h
#FOR DALTON SIMPLIFIED SYMMETRY
#1Ag = delta_g
#1Ag-2 = Sigma+_g
#B2g/B3g = Pi_g
#grep '1Ag &1' temp_org > dat_org
#grep B1g temp_org >> dat_org
#grep 'B2g &1' temp_org >> dat_org
#grep '1Ag &2' temp_org >> dat_org
#grep B3g temp_org >> dat_org
#grep Au temp_org >> dat_org
#grep B1u temp_org >> dat_org
#grep B2u temp_org >> dat_org
#grep B3u temp_org >> dat_org
#c2v
#grep A1 temp_org > dat_org
#grep A2 temp_org >> dat_org
#grep B1 temp_org >> dat_org
#grep B2 temp_org >> dat_org
#Cs
grep "A'" temp_org > dat_org
grep 'A"' temp_org >> dat_org

#organize
awk '{print $1" "$2" "$3" & "$5" & & "$9" & & "$11" & "$7}' dat_org > data_org

#head -n3 data_org > data_org2
#tail -n1 data_org >> data_org2
rm temp_* dat_org ee.txt OPA.txt
