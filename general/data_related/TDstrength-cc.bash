grep -A 9 'Principal values of diagonalized transition strength matrix' output.log > raw-tdm
awk '{print $2}' raw-tdm > raw-tdm2
sed -i 's/values//' raw-tdm2
sed -i 's/axis//' raw-tdm2
sed '/^$/d' raw-tdm2 > tdm-CC
rm raw*
