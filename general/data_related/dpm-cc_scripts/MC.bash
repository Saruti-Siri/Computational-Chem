#usage - copy this folder to working dir and run this script from within the folder
cp ../output.log .
./getcc-dpm.bash
./skrypt-DPM.py > DPM.txt
./dpm-subtract
./DPM-sf.py > DPM.sf
rm dpm_sf1 dpm.txt *_dpm  
