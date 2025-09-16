grep -A 12 '|  %t1   |' ricc2.log > sch_temp1
awk '{print $14}' sch_temp1 > sch_temp2
sed -i 's/|//g' sch_temp2
sed '/^$/d' sch_temp2 > T1
rm sch_temp*
