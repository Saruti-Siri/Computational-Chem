grep -A 8 "| ||T1||  |" output.log > T1_raw
awk '{print $12}' T1_raw > T1_raw2
sed -i -e 1,4d T1_raw2
cat T1_raw2 > T1.data
rm *raw *raw2
