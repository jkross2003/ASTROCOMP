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

# Section 1.1

# Set output file
outfile1 = 'Section1.1.eps'
set out outfile1
unset title
set key spacing 1.5 samplen 3
set key at graph 0.95, graph 0.95

# Define Gaussian function
f(x) = 1/(sqrt(2*pi)*sigma) * exp(-(x-mean)**2 / (2*sigma**2))

# Set initial guesses for sigma and mean
sigma = 1.0
mean = 1.0

# Fit the function to the data in columns 1 and 3
fit f(x) 'EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data' using 1:3 via sigma, mean
# Plot data and fit
set title "Turbulent Density PDF"
set xlabel "ln(density/density_0)"
set ylabel "PDF"

# Plot column 1 vs column 3 as crosses
p 'EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data' u 1:3, f(x)

print outfile1." created."

reset
set term post eps color enhanced dashed dashlength 3.3 linewidth 1.5 "Times-Roman" 16

# Section 1.2

# Set titles and labels
set title "Turbulent Density PDF with Gaussian Fit"
set xlabel "ln(density/density0)"
set ylabel "PDF"

# Set legend position
set key top right


# Set output file
outfile2 = 'Section1.2.eps'
set out outfile2
unset title
set key spacing 1.5 samplen 3
set key at graph 0.95, graph 0.95

# Plot again to save the output
p [-10:10] 'EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data' u 1:3 with points pt 7 title 'Density PDF', \
     f(x) with lines lc 'black' lw 2 title 'Gaussian Fit'

print outfile2." created."