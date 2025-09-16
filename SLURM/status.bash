while IFS= read line;
do

        echo "$line" | for l in $line
                do
# StdOut = source location of calculation
# add other grep options for other statuses
			scontrol show job "$l" > "$l"-temp && grep "StdOut=" "$l"-temp > "$l"-stat ;  
                        done
done < $1
rm *-temp
