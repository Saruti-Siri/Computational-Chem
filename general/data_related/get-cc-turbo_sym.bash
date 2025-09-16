grep '|  linear (para)    |' output.log > TPA_raw.txt
grep oscillator output.log > OPA_raw.txt
grep -A 14 'Excitation energ' output.log > ee_raw.txt

awk '{ print $(NF-3) }' TPA_raw.txt > TPA.txt
sed 's/|//' TPA.txt > dat.txt
sed 's/*/0/g' dat.txt > dat2.txt

#tail -n 5 OPA_raw.txt >> OPA_ra.txt
#awk '{ print $(NF-3) }' OPA_ra.txt >> OPA.txt
awk '{print $6}' OPA_raw.txt > OPA.txt

tail -n 11 ee_raw.txt > ee_ra.txt
awk '{print $8}' ee_ra.txt > ee.txt
awk '{print $2" "$4" "$12}' ee_ra.txt > scheme-temp
sed -i '/^[[:space:]]*$/d' ee.txt
sed -i '/^[[:space:]]*$/d' scheme-temp
awk '{print $1" &"$2" &"$3" &"}' scheme-temp > scheme+t1

paste ee.txt dat2.txt | awk '{print $1,$2}' > data.txt

#rm TPA_raw.txt
rm TPA.txt OPA_raw.txt OPA_ra.txt ee_raw.txt ee_ra.txt dat.txt dat2.txt scheme-temp

