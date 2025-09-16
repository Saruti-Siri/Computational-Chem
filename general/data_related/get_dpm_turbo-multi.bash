grep -A 19 Ground ../high*curswitch/escf.log > raw-gs_dpm
#gs_dpm#
tail -n4 raw-gs_dpm > raw2-gs_dpm
awk '{print $4}' raw2-gs_dpm > gsdpm_xyz
sed -i '/^[[:space:]]*$/d' gsdpm_xyz
awk '{print $6}' raw2-gs_dpm > kek
head -n 1 kek > raw3-gs_dpm
awk '{print $8}' raw2-gs_dpm >> raw3-gs_dpm
sed -i '/^[[:space:]]*$/d' raw3-gs_dpm
printf 'a.u.\ndeb\n' > kek
paste kek raw3-gs_dpm > gs_dpm-au+deb
tail -n 1 raw3-gs_dpm > gs_temp
#es_dpm#change 'dpm-exopt_no_fldopt' folder location when needed
grep -B 4 "| dipole moment |" ../dpm-exopt_no_fldopt/egrad.log > raw-es_dpm
grep -B 4 "| dipole moment |" s2/egrad.log >> raw-es_dpm
grep -B 4 "| dipole moment |" s3/egrad.log >> raw-es_dpm
grep -B 4 "| dipole moment |" s4/egrad.log >> raw-es_dpm
grep -B 4 "| dipole moment |" egrad.log >> raw-es_dpm
awk '{print $9}' raw-es_dpm > raw-es_dpm2
sed '/^[[:space:]]*$/d' raw-es_dpm2 > es_dpm-deb
awk 'FNR==5{print $6};FNR==10{print $6};FNR==15{print $6};FNR==20{print $6};FNR==25{print $6};' raw-es_dpm > es_dpm-au
#es_dpm_xyz
#for ever 5 lines, print 6th column of lines 1-3
#awk 'FNR%5==1,FNR%5==3{print $6}' raw-es_dpm 
awk 'FNR==1,FNR==3{print $6}' raw-es_dpm > raw-es1dpm_xyz
awk 'FNR==6,FNR==8{print $6}' raw-es_dpm > raw-es2dpm_xyz  
awk 'FNR==11,FNR==13{print $6}' raw-es_dpm > raw-es3dpm_xyz
awk 'FNR==16,FNR==18{print $6}' raw-es_dpm > raw-es4dpm_xyz
awk 'FNR==21,FNR==23{print $6}' raw-es_dpm > raw-es5dpm_xyz
#DPM diff
paste gsdpm_xyz raw-es1dpm_xyz raw-es2dpm_xyz raw-es3dpm_xyz raw-es4dpm_xyz raw-es5dpm_xyz > comb_xyz
awk '{print $1-$2"  "$1-$3"  "$1-$4"  "$1-$5"  "$1-$6}' comb_xyz > raw2-comb_xyz
awk '{print $1*$1"  "$2*$2"  "$3*$3"  "$4*$4"  "$5*$5}' raw2-comb_xyz > raw-square_xyz
awk '{s+=$1} END {print s}' raw-square_xyz > raw3-comb_xyz
awk '{s+=$2} END {print s}' raw-square_xyz >> raw3-comb_xyz
awk '{s+=$3} END {print s}' raw-square_xyz >> raw3-comb_xyz
awk '{s+=$4} END {print s}' raw-square_xyz >> raw3-comb_xyz
awk '{s+=$5} END {print s}' raw-square_xyz >> raw3-comb_xyz
awk '{print $1^(1/2)}' raw3-comb_xyz > dpm_sf-au
awk '{print $1/0.393456}' dpm_sf-au > dpm_sf-deb
sed -i '1s/^/0\n/' dpm_sf-deb

cat gs_temp es_dpm-deb > temp 
awk 'function abs(x) {return x>0?x:-x} NR==1{D=$0}{$0=($0-D); print}' temp > dpm_st-deb
sed -i 's/-//g' dpm_st-deb

paste temp dpm_sf-deb dpm_st-deb > total

column -t total

rm *raw* kek *temp*
rm comb_xyz dpm_sf-au
