#in a.u.
grep -o 'Transition moment : .*' output.log > raw.txt
grep -o 'Excitation energy :  .*' output.log >> raw.txt

awk '{ print $4}' raw.txt >> OPA.txt

tail -n -5 OPA.txt > ee.txt

head -n -5 OPA.txt > trans_mo.txt 

awk '{print $1 * $1}' < trans_mo.txt > trans_sqr.txt

cat trans_sqr.txt | awk '{sum += $1; if (NR % 3 == 0) {print sum; sum=0}} END {if (NR % 3 != 0) print sum}' > trans_com.txt

awk '{print sqrt ($1)}' trans_com.txt > tdm_au
awk '{print ($1/0.393430)}' tdm_au > tdm_deb

rm raw.txt OPA.txt trans_mo.txt trans_mo.txt trans_com.txt
#rm ee.txt trans_sqr.txt
#checker;
paste ee.txt tdm_au > check1
awk '{print 2/3*$1*($2^2)}' < check1 > check
paste check osc_str.txt
rm check1
