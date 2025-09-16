grep '|  linear (para)    |' output.log >> TPA_raw.txt
grep -A 6 Oscillator output.log >> OPA_raw.txt
grep -A 8 'Excitation energ' output.log >> ee_raw.txt

awk '{ print $(NF-3) }' TPA_raw.txt >> TPA.txt
sed 's/|//' TPA.txt >> dat.txt
sed 's/*/0/g' dat.txt >> dat2.txt

tail -n 5 OPA_raw.txt >> OPA_ra.txt
awk '{ print $(NF-3) }' OPA_ra.txt >> OPA.txt

tail -n 5 ee_raw.txt >> ee_ra.txt
awk '{print $8}' ee_ra.txt >> ee.txt

paste ee.txt dat2.txt | awk '{print $1,$2}' >> data.txt

rm TPA_raw.txt TPA.txt OPA_raw.txt OPA_ra.txt ee_raw.txt ee_ra.txt dat.txt dat2.txt

