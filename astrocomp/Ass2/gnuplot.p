reset
set term post eps color enhanced dashed dashlength 3.3 linewidth 1.5 "Times-Roman" 16

set style line 99 lt 0 lw 1.5 pt 0 ps 1.0
set style line 1 lt 1 lw 1.5 pt 1 ps 1.0
set style line 2 lt 2 lw 1.5 pt 2 ps 1.0
set style line 3 lt 3 lw 1.5 pt 3 ps 1.0
set style line 4 lt 4 lw 1.5 pt 4 ps 1.0
set style line 5 lt 5 lw 1.5 pt 5 ps 1.0
set style line 6 lt 6 lw 1.5 pt 6 ps 1.0
set style line 7 lt 7 lw 1.5 pt 7 ps 1.0
set style line 8 lt 8 lw 1.5 pt 8 ps 1.0

set style function lines
set term aqua

outfile = "gnuplot.eps"
set out outfile
unset title
set key spacing 1.5 samplen 3
set key at graph 0.95, graph 0.95
set xlabel "x_{axis}"
set ylabel "y_{axis}"
set tics scale 1.3
set mxtics 10
set mytics 10
unset log y
unset log x
set size 1.0, 1.0
set origin 0.0, 0.0

p [-5:5] [0:1] x ls 3 t "This is y=x", x**2 ls 1 title "This is x^{2}", "EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data" u 1:3 ls 4 t "This is a density PDF"

print outfile." created."

# Section 1
