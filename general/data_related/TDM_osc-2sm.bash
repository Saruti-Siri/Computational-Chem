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

#rm raw.txt 
rm trans_mo.txt OPA.txt trans_com.txt
#rm ee.txt trans_sqr.txt
#checker;
paste ee.txt tdm > check1
awk '{print 2/3*$1*($2^2)}' < check1 > check
paste check osc_str.txt
rm check1

head -n-5 raw.txt > kek
awk FNR%3==1'{print $4}' kek > x_tdm 
awk FNR%3==2'{print $4}' kek > y_tdm
awk FNR%3==0'{print $4}' kek > z_tdm
paste x_tdm y_tdm z_tdm > kek1
nl kek1 > kek2
awk '{print "        "$1" "$2"\t"$3"\t"$4}' kek2 > tdm_xyz
rm kek* raw.txt *_tdm

#check files are copied correctly, also copy the 'au' version of 'dpm-dft-scripts' folder to dpm folder. Need *_raw in a.u.
cp ../double*/dpm-*/*_raw .
cp ../double*/dpm-*/gDPM .
paste x_raw y_raw z_raw > temp
cat gDPM temp > temp2
awk '{print $1}' temp2 > x_raw
awk '{print $2}' temp2 > y_raw
awk '{print $3}' temp2 > z_raw
#due to dalton printing DPM diff, find ES-dpm via 'GS-ES = diff'
awk 'function abs(x) {return x>0?x:-x} NR==1{D=$0}{$0=(D-$0); print}' x_raw > x_raw2
awk 'function abs(x) {return x>0?x:-x} NR==1{D=$0}{$0=(D-$0); print}' y_raw > y_raw2
awk 'function abs(x) {return x>0?x:-x} NR==1{D=$0}{$0=(D-$0); print}' z_raw > z_raw2
paste x_raw2 y_raw2 z_raw2 > temp3
sed -i '1d' temp3
cat gDPM temp3 > temp4
awk '{print $1}' temp4 > x_raw4
awk '{print $2}' temp4 > y_raw4
awk '{print $3}' temp4 > z_raw4

sed -i 's/^/    X=        /' x_raw4
sed -i 's/^/  Y= /' y_raw4
sed -i 's/^/  Z= /' z_raw4
paste x_raw4 y_raw4 z_raw4 > dpm_xyz
rm temp* *_raw*

cat dpm_xyz tdm_xyz
