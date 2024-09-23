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

# Section 2.1
# Set output file
outfile3 = 'Section2.1a.eps'
set out outfile3
unset title
set key spacing 1.5 samplen 3
set key at graph 0.95, graph 0.95

# Set plot title, labels, and ranges
set title "Turbulent Density PDFs"
set xlabel "ln(density/density0)"
set ylabel "PDF"
set xrange [-10:10]
set yrange [1e-5:2]
set logscale y

# Plot data with different colors and point styles
p 'EXTREME_hdf5_plt_cnt_0020_dens.pdf_ln_data' u 1:3 with points pt 7 lc rgb "red" title '0020', \
     'EXTREME_hdf5_plt_cnt_0030_dens.pdf_ln_data' u 1:3 with points pt 7 lc rgb "blue" title '0030', \
     'EXTREME_hdf5_plt_cnt_0040_dens.pdf_ln_data' u 1:3 with points pt 7 lc rgb "green" title '0040'

print outfile3." created."

reset
set term post eps color enhanced dashed dashlength 3.3 linewidth 1.5 "Times-Roman" 16

# Set output file
outfile4 = 'Section2.1b.eps'
set out outfile4
unset title
set key spacing 1.5 samplen 3
set key at graph 0.95, graph 0.95

# Set plot title, labels, and ranges
set title "Turbulent Density PDFs"
set xlabel "ln(density/density0)"
set ylabel "PDF"
set xrange [-10:10]
set yrange [1e-5:2]
set logscale y

# Plot data with shifting factors
p 'EXTREME_hdf5_plt_cnt_0020_dens.pdf_ln_data' u 1:3 with points pt 7 lc rgb "red" title '0020', \
     'EXTREME_hdf5_plt_cnt_0030_dens.pdf_ln_data' u 1:($3*2) with points pt 7 lc rgb "blue" title '0030 (shifted)', \
     'EXTREME_hdf5_plt_cnt_0040_dens.pdf_ln_data' u 1:($3*4) with points pt 7 lc rgb "green" title '0040 (shifted)'

print outfile4." created."

# Section 2.2

reset
set term post eps color enhanced dashed dashlength 3.3 linewidth 1.5 "Times-Roman" 16

# Set output file
outfile5 = 'Section2.2.eps'
set out outfile5
unset title
set key spacing 1.5 samplen 3
set key at graph 0.95, graph 0.95

# Set plot title, labels, and ranges
set title "Mass-Weighted Turbulent Density PDF"
set xlabel "ln(density/density0)"
set ylabel "Mass-Weighted PDF (exp(ln(density)) * PDF)"
set xrange [-10:10]
set yrange [1e-5:2]
set logscale y

# Plot column 1 vs exp(column 1) * column 3 for mass-weighted PDF
p 'EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data' u 1:(exp($1)*$3) with points pt 7 lc rgb "red" title '0050 Mass-Weighted PDF'

print outfile5." created."

reset
set term post eps color enhanced dashed dashlength 3.3 linewidth 1.5 "Times-Roman" 16

# Section 2.3

# Set output file
outfile6 = 'Section2.3.eps'
set out outfile6
unset title
set key spacing 1.5 samplen 3
set key at graph 0.95, graph 0.95

# Set plot title, labels, and ranges
set title "Fitted Mass-Weighted Turbulent Density PDF"
set xlabel "ln(density/density0)"
set ylabel "Mass-Weighted PDF (exp(ln(density)) * PDF)"
set xrange [-10:10]
set yrange [1e-5:2]
set logscale y

# Define Gaussian function for fitting
f(x) = 1/(sqrt(2*pi)*sigma) * exp(-(x-mean)**2 / (2*sigma**2))

# Set initial guesses for sigma and mean (values should be close to the expected ones)
sigma = 1.14
mean = 0.71

# Fit the function to the mass-weighted PDF data (column 1 vs exp(column 1)*column 3)
fit f(x) 'EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data' using 1:(exp($1)*$3) via sigma, mean

# Plot the data and the fitted Gaussian
p 'EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data' u 1:(exp($1)*$3) with points pt 7 lc rgb "red" title '0050 Mass-Weighted PDF', \
  f(x) with lines lc 'black' lw 2 title 'Fitted Gaussian'

# Print the fitted mean and standard deviation to the Gnuplot shell
print sprintf("Fitted mean = %.4f", mean)
print sprintf("Fitted standard deviation = %.4f", sigma)

print outfile6." created."

reset
