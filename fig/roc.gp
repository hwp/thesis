set term tikz size 10,10
unset key 
set xlabel 'false positive rate' offset 0,-.5
set ylabel 'true positive rate' offset -2,0
set label 'random' at .48,.48
set label 'perfect' at .02,.98
set size square
plot x dt 3 , '-' w l lw 3, '-' w l lw 3 
0 0
.001 .999
1 1
e
0 0
.1 .4
.2 .7
.3 .85
.5 .88
.7 .90
1 1
e

