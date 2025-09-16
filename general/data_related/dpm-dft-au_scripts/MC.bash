./get-dpm.bash
tr -s ' ' < gDPM > gDPM.swp
awk '{print $1*0.3934303 " " $2*0.3934303 " " $3*0.3934303}' < gDPM.swp > gDPM2.swp
sed 's|^ *||g' gDPM2.swp > gDPM3.swp
sed 's| |\t|g' gDPM3.swp > gDPM4.swp
cat gDPM4.swp dpm0.txt > dpm.txt

./skrypt-DPM.py > DPM.txt
./dpm-subtract
./DPM-sf.py > DPM.sf
rm *.swp 
#rm dpm_sf1 dpm.txt

awk '{print $1/0.3934303}' < DPM.sf > DPM-deb.sf
