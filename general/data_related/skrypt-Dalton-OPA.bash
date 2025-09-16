echo "###############################"
echo "#Wyszukuje bledy i ostrzezenia#"
echo "###############################"
grep -i warn *.out
grep -i error *.out
grep -i error *.log



grep -o 'Oscillator strength (LENGTH)   :.*' output.log >> OPA.txt
grep -o 'Excitation energy :  .*' output.log >> OPA.txt
grep -o '@                       .*' output.log >> OPA.txt
grep -o 'Transition moment : .*' output.log >> OPA.txt

