cp ../output.log .

./get-dpm.bash
sed -i 's/^.//' gDPM
tr -s ' ' < gDPM > gDPM.swp
sed 's|^ *||g' gDPM.swp > gDPM2.swp
sed 's| |\t|g' gDPM2.swp > gDPM3.swp
sed -s -e $'$a\\' gDPM3.swp dpm0.txt > dpm.txt
./skrypt-DPM.py > DPM.txt
./dpm-subtract
./DPM-sf.py > DPM.sf
rm *.swp dpm_sf1 dpm0.txt 
