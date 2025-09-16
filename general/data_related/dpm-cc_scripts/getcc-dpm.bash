awk 'c&&!--c;/Electric/{c=10}' output.log >> x_raw
awk 'c&&!--c;/Electric/{c=11}' output.log >> y_raw
awk 'c&&!--c;/Electric/{c=12}' output.log >> z_raw
awk '{print $3}' x_raw > x_2 
awk '{print $3}' y_raw > y_2
awk '{print $3}' z_raw > z_2
paste x_2 y_2 z_2 >> dpm.txt
#tr -d '-' < dpm2.txt > dpm3.txt
#sed 's/e/e-/' dpm3.txt > dpm.txt

awk '{print $1}' dpm.txt > x_dpm
awk '{print $2}' dpm.txt > y_dpm
awk '{print $3}' dpm.txt > z_dpm

rm *_raw *2.txt *3.txt *_2

#paste file1 file2 | awk '{s += ($1-$2)^2}; END{print (s+0)/NR}'

#paste file1 file2 | awk '{s += ($1-$2)^2}; END{print (s+0)/NR}'

#cat data.raw | awk '{sum += $1; if (NR % 3 == 0) {print sum; sum=0}} END {if (NR % 3 != 0) print sum}' > comb.data

#awk '{print $1/(0.393456)}' < comb.data > dpm.data
