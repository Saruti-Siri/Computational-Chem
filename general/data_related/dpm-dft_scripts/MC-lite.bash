./get-dpm.bash
tr -s ' ' < gDPM > gDPM.swp
sed 's|^ *||g' gDPM.swp > gDPM2.swp
sed 's| |\t|g' gDPM2.swp > gDPM3.swp
cat gDPM3.swp dpm0.txt > dpm.txt

