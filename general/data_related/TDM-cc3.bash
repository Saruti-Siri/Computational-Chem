#in a.u.
grep -A 4 "| transition strength |" output.log > raw-tdm
awk '{print $8}' raw-tdm > raw-tdm2
sed -i 's/moment//' raw-tdm2
sed '/^$/d' raw-tdm2 > raw-tdm3
sed -i 's/-//' raw-tdm3
cat raw-tdm3 | awk '{sum += $1; if (NR % 3 == 0) {print sum; sum=0}} END {if (NR % 3 != 0) print sum}' > trans_com
awk '{print sqrt($1)}' trans_com > tdm-CC
rm raw* trans_com
#checker;
grep -A6 "   eV.  " output.log > ee1
awk '{print $6}' ee1 > ee2
tail -n +3 ee2 > ee.txt
paste ee.txt tdm-CC > check1
awk '{print 2/3*$1*($2^2)}' < check1 > check
paste check OPA.txt
rm check1 ee1 ee2 ee.txt 

