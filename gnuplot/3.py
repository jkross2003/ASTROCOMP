#!/usr/bin/env python
# -*- coding: utf-8 -*-
# written by Jessica Ross

## Section 3

import numpy as np
import matplotlib.pyplot as plt

# Section 3.1 (in PDF upload)
# 3.2

# Define the IMF function
def IMF(M):
    IMF_values = np.zeros_like(M)
    
    # Log-normal part for M <= 1
    low_mass_mask = M <= 1
    IMF_values[low_mass_mask] = (0.093 * np.exp(-((np.log10(M[low_mass_mask]) - np.log10(0.2))**2) / (2 * 0.55**2))) / (M[low_mass_mask] * np.log(10))
    
    # Power-law part for M > 1
    high_mass_mask = M > 1
    IMF_values[high_mass_mask] = (0.041 * M[high_mass_mask]**(-2.45)) / np.log(10)
    return IMF_values

def IMF_discretised(M_min, M_max, N_bins):
    # Create a logarithmically spaced grid of mass M (bin edges)
    bins = np.logspace(np.log10(M_min), np.log10(M_max), N_bins+1)
    
    # Calculate the centre of each bin for evaluating the IMF
    bin_centres = 0.5 * (bins[:-1] + bins[1:])
    
    # Evaluate the IMF at each bin centre
    IMF_values = np.array([IMF(M) for M in bin_centres])
    
    # The mass width for each bin (in M)
    bin_widths = np.diff(bins)
    
    # Return bin centres, IMF values, and bin widths
    return bin_centres, IMF_values, bin_widths

# Section 3.3
def plot_IMF(M_min, M_max, N_bins):
    # Get the discretised IMF data
    bin_centres, IMF_values, bin_widths = IMF_discretised(M_min, M_max, N_bins)
    
    # Plot the IMF values
    plt.figure(figsize=(10, 6))
    plt.bar(bin_centres, IMF_values, width=bin_widths, align='center', log=True)
    plt.xscale('log')
    plt.yscale('log')
    plt.xlabel(r'Mass [$M_\odot$]')
    plt.ylabel(r'IMF $(dN/dM)$')
    plt.title(f'Discretised IMF with {N_bins} Bins')
    plt.grid(True, which='both', linestyle='--', linewidth=0.5)
    plt.show()
    
# Define the mass range
m_min = 0.01  # Minimum mass in solar masses
m_max = 100   # Maximum mass in solar masses
n_bins = 200 # Number of bins

plot_IMF(m_min, m_max, n_bins)

# Section 3.4
def find_IMF_mode(M_min, M_max, N_bins):
    bin_centres, IMF_values, bin_widths = IMF_discretised(M_min, M_max, N_bins)
    mode_mass = bin_centres[np.argmax(IMF_values)]  # Find M corresponding to the max IMF value
    return mode_mass

mode_mass = find_IMF_mode(m_min, m_max, n_bins)
print(f"The mode of the IMF occurs at mass M = {mode_mass:.4f} M_sun")

# Section 3.5
# Function to compute the average mass of stars by numerical integration
def average_star_mass(M_min, M_max, N_bins):
    # Logarithmically spaced mass bins (edges)
    bin_edges = np.logspace(np.log10(M_min), np.log10(M_max), N_bins + 1)
        
    # Calculate IMF values at bin edges
    IMF_edges = IMF(bin_edges)
    
    # Calculate the midpoint of each bin
    bin_midpoints = (bin_edges[:-1] + bin_edges[1:]) / 2
    
    # Calculate the IMF at the midpoints using staggered binning
    IMF_midpoints = (IMF_edges[:-1] + IMF_edges[1:]) / 2
    
    # Calculate the bin widths (logarithmically spaced bins)
    bin_widths = bin_edges[1:] - bin_edges[:-1]
    
    # Normalise the IMF to make it a PDF
    normalisation_factor = np.sum(IMF_midpoints * bin_widths)
    IMF_midpoints /= normalisation_factor  # Now IMF_midpoints is a PDF
    
    # Compute the average star mass using the normalized IMF
    avg_mass = np.sum(bin_midpoints * IMF_midpoints * bin_widths)
    
    return avg_mass

average_mass = average_star_mass(m_min, m_max, n_bins)
print(f"The average mass of stars is M = {average_mass:.4f} M_sun")

# Section 3.6
# Iterative convergence test to find the number of bins required for 1% accuracy over 5 consecutive increases
def iterative_convergence_test(M_min, M_max, start_bins=1, increment_factor=1, tolerance=1.0, consecutive_passes=3):
    N_bins = start_bins
    last_avg_mass = average_star_mass(M_min, M_max, N_bins)
    percent_errors = []
    bin_counts = [N_bins]
    consecutive_within_tolerance = 0

    while consecutive_within_tolerance < consecutive_passes:

        # Compute the average mass for the new bin count
        avg_mass = average_star_mass(M_min, M_max, N_bins)

        # Calculate percentage error relative to the previous value
        percent_error = np.abs((avg_mass - last_avg_mass) / avg_mass) * 100
        percent_errors.append(percent_error)

        # Check if the percentage error is within tolerance
        if percent_error < tolerance:
            consecutive_within_tolerance += 1
        else:
            consecutive_within_tolerance = 0
            
        if consecutive_within_tolerance == consecutive_passes:
            Nbin_converged = bin_counts[-consecutive_passes]
            print(Nbin_converged)

        # Update the last average mass
        last_avg_mass = avg_mass
        
        bin_counts.append(N_bins)
        N_bins += 1

        print(f"Bins: {N_bins}, Avg Mass: {avg_mass:.6f}, Error: {percent_error:.4f}%")
        # Print the final number of bins where the convergence condition is satisfied
    print(f"Convergence reached with at least {bin_counts[-consecutive_passes]} bins.")

    return bin_counts, percent_errors

# Run the iterative convergence test
bin_counts, percent_errors = iterative_convergence_test(m_min, m_max)

# Plot the percentage error over the number of bins
plt.figure(figsize=(10, 6))
plt.plot(bin_counts[:-1], percent_errors, color='blue')
plt.xlabel('Number of Bins (log scale)')
plt.ylabel('Percentage Error (%)')
plt.title('Percentage Error of Average Star Mass with Increasing Number of Bins')
plt.axhline(1, color='black', linestyle='--', label='1% Error Threshold')
plt.grid(True, which="both", linestyle='--')
plt.legend()
plt.show()

# Section 3.7
# Test the convergence with M_max → ∞ (approximated)
def test_convergence_to_infinity(M_min, M_max_start, step_factor=1.5, tolerance=0.01):
    M_max = M_max_start
    prev_avg_mass = 0
    converged = False
    m_max_values = []
    avg_masses = []

    while not converged:
        N_bins = 100000  # Fixed large number of bins for accurate estimation
        avg_mass = average_star_mass(M_min, M_max, N_bins)
        
        percent_error = np.abs((avg_mass - prev_avg_mass) / avg_mass) * 100
        m_max_values.append(M_max)
        avg_masses.append(avg_mass)
        
        print(f"M_max: {M_max:.2e}, Avg Mass: {avg_mass:.6f}, Percent Error: {percent_error:.4f}%")
        
        # Check for convergence (percent error < tolerance)
        if percent_error < tolerance and prev_avg_mass != 0:
            converged = True
        else:
            prev_avg_mass = avg_mass
            M_max *= step_factor  # Increase M_max by a factor of step_factor
        
    return avg_mass, M_max, m_max_values, avg_masses

# Define the mass range and initial M_max
m_min = 0.01  # Minimum mass in solar masses
m_max_start = 1e2  # Initial maximum mass

# Test the convergence for M_max → ∞
avg_mass_converged, final_m_max, m_max_values, avg_masses = test_convergence_to_infinity(m_min, m_max_start)

print(f"\nThe converged average star mass is M = {avg_mass_converged:.6f} M_sun with M_max ≈ {final_m_max:.2e} M_sun.")

# Plot the results
plt.figure(figsize=(10, 6))
plt.plot(m_max_values, avg_masses, marker='o', linestyle='-', color='blue')
plt.xscale('log')
plt.xlabel(r'Maximum Mass ($M_{\odot}$)')
plt.ylabel(r'Average Star Mass ($M_{\odot}$)')
plt.title('Convergence of Average Star Mass with Increasing Maximum Mass')
plt.grid(True, which="both", linestyle='--', linewidth=0.5)
plt.show()

# ===== the following applies in case we are running this in script mode =====
if __name__ == "__main__":