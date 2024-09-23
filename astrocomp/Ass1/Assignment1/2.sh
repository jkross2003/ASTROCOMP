# 2.2 Download file from the internet
wget http://www.mso.anu.edu.au/~chfeder/teaching/astr_4004_8004/material/ mM4_10048_pdfs/EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data

# 2.3 Search and show all lines with 'sigma' in them
grep "sigma" EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data

# 2.4 Extract the next line after 'sigma'
grep -A 1 "sigma" EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data | grep -v "sigma"

# 2.5 Extract the line with the data
grep -A 1 "sigma" EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data | tail -n 1

# 2.6 Display the help message of Bash
bash --help

# 2.7 Display the two lines that explain the usage details of Bash
bash --help | grep -A 1 "Usage:" 

# 2.8 Show the number of words in the last output
bash --help | grep -A 1 "Usage:" | tr -d '\n' | wc -w

# 2.9 Add 'Number of words:' in front of the previous output and print to the screen
echo "Number of words: $(bash --help | grep -A 1 "Usage:" | tr -d '\n' | wc -w)"

# 2.10 Extract the entire header of the file downloaded. Redirect the output of this to a file called header.txt
awk 'NR<=11' EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data > header.txt

# 2.11 Extract the first column of the downloaded file without the header
awk 'NR>11 {print $1}' EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data > column1.txt