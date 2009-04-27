#!/bin/bash

#Scrape out the MATLAB, prepare it to be run
name=`echo "$1" | perl -pe 's/\.tex//'`
echo "try" > "$name.m"
perl -0777 -ne 'undef $/; print for m/<\?ml.*?>/msg' "$1" | perl -pe 's/<\?ml/thisisalinebreak=1/g; s/\?>//g;' >> "$name.m"
echo "thisisalinebreak=1" >> "$name.m"
echo "exit" >> "$name.m"
echo "catch ME" >> "$name.m"
echo "exit" >> "$name.m"
echo "end" >> "$name.m"

#Run matlab, cat output to a file
matlab -r "$name" > "$name.out"

./mattex.py "$name.out" "$name.tex" > "$name.parsed.tex"

open "$name.parsed.tex"
