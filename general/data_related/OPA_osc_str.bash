echo "###############################"
echo "#Wyszukuje bledy i ostrzezenia#"
echo "###############################"
grep -i warn *.out
grep -i error *.out
grep -i error *.log



grep -o 'Transition moment : .*' output.log > raw.txt
grep -o 'Excitation energy :  .*' output.log >> raw.txt

awk '{ print $4}' raw.txt >> OPA.txt

tail -n -5 OPA.txt >> ee.txt

head -n -5 OPA.txt > trans_mo.txt 

awk '{print $1 * $1}' < trans_mo.txt > trans_sqr.txt

cat trans_sqr.txt | awk '{sum += $1; if (NR % 3 == 0) {print sum; sum=0}} END {if (NR % 3 != 0) print sum}' > trans_com.txt

awk '{print $1*(2/3)}' < trans_com.txt > trans_c.txt

paste trans_c.txt ee.txt > comb.txt

awk '{print $1*$2}' < comb.txt > osc_str.txt

rm raw.txt OPA.txt trans_mo.txt trans_sqr.txt trans_com.txt trans_c.txt comb.txt ee.txt

