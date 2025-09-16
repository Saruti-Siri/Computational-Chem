sed 's/OW/O/g' cleaned.pdb >> tmp1.txt
sed 's/HW/H/g' tmp1.txt >> tmp2.txt
sed 's/WAT/TP3/g' tmp2.txt >> tmp3.txt
sed 's/HA/1HG2/g' tmp3.txt > tmp4.txt
sed 's/HG21/1HG2/g' tmp4.txt > test.txt
#sed 's/HG21/1HG2/g' tmp3 > tmp4.txt


rm tmp*.txt

