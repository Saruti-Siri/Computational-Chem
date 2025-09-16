#in a.u.
grep -A 4 'transition strength' ricc2.log > raw-tdm
awk '{print $8}' raw-tdm > raw-tdm2
sed -i 's/moment//' raw-tdm2
sed '/^$/d' raw-tdm2 > raw-tdm3
sed -i 's/-//' raw-tdm3
cat raw-tdm3 | awk '{sum += $1; if (NR % 3 == 0) {print sum; sum=0}} END {if (NR % 3 != 0) print sum}' > trans_com
awk '{print sqrt($1)}' trans_com > tdm-CC_au
awk '{print ($1/0.393430)}' tdm-CC_au > tdm-CC_deb

awk '{print $1^(1/2)}' raw-tdm3 > trans_mom
awk 'FNR%3==1{print $1}' trans_mom > transx
awk 'FNR%3==2{print $1}' trans_mom > transy
awk 'FNR%3==0{print $1}' trans_mom > transz
paste transx transy transz > trans_
nl trans_ > trans__
awk '{print "        "$1" "$2"\t"$3"\t"$4}' trans__ > trans_xyz
awk '{print $1}' xyz_comb > x_dpm
awk '{print $2}' xyz_comb > y_dpm
awk '{print $3}' xyz_comb > z_dpm
sed -i 's/^/    X=        /' x_dpm
sed -i 's/^/  Y= /' y_dpm
sed -i 's/^/  Z= /' z_dpm
paste x_dpm y_dpm z_dpm > dpm_xyz
cat dpm_xyz trans_xyz

rm raw-tdm raw-tdm1 raw-tdm2 raw-tdm3 trans_com trans_mom transx transy transz trans_ trans__ *_dpm
#checker;
grep -A7 "|    eV      |" ricc2.log > ee1
awk '{print $8}' ee1 > ee2
tail -n +3 ee2 > ee.txt
paste ee.txt tdm-CC > check1
awk '{print 2/3*$1*($2^2)}' < check1 > check
paste check OPA.txt
rm check1 ee1 ee2 ee.txt 
