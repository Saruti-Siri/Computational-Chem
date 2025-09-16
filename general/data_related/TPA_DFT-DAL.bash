grep 'linear (para)' output.log > delta_temp
#if dTPA is smaller than 10^4 then uncomment below
#awk '{print $4$5}' delta_temp > delta_TPA
#sed -i 's/|//g' delta_TPA
grep '  Linear  ' output.log > data.txt
awk '{print $7}' data.txt > delta_TPA
./evtonm.bash data.txt
rm delta_temp
