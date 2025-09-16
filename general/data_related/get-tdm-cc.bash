#cp ../output.log .
grep -A 16 '| Oscillator strength  | ' output.log > temp1
awk '{ print $8 " " $10 }' temp1 > temp2
tail -15 temp2 > temp3
awk '{ print $2 }' temp3 > OSC-tdm.txt
awk '{ print $1 }' temp3 > temp-dpm.txt
sed -i -e 's/-//g' temp-dpm.txt
awk '{print sqrt($1)}' temp-dpm.txt > temp 
awk '{print $1/0.393456}' temp > DPM-tdm.txt

#rm temp*
