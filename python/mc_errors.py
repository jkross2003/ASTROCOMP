#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Christoph Federrath

import argparse
import numpy as np
from cfpack.defaults import *
import cfpack as cfp
import mytools as mt


# ===== the following applies in case we are running this in script mode =====
if __name__ == "__main__":

    # parse command line arguments
    parser = argparse.ArgumentParser(description='Monte Carlo error propagation.')
    args = parser.parse_args()

    # input variables
    # a_mean = 1.0; a_err = 0.5
    a_mean = 10.; a_err = 1.0
    b_mean = 1.0; b_err = 0.1

    # derived variable
    c_mean = a_mean**2 / b_mean**2

    # standard (Gaussian) error propagation
    c_err = c_mean * np.sqrt( (2.0*a_err/a_mean)**2 + (2.0*b_err/b_mean)**2 )

    # print result of c with standard error propagation
    print('Using analytic (Gaussian) error propagation: c = ', c_mean, ' +/- ', c_err)

    # number of random numbers
    n = int(1e6)

    # generate Gaussian random numbers based on a seed
    seed = 1
    a_samples = cfp.generate_random_gaussian_numbers(n=n, mu=a_mean, sigma=a_err, seed=seed+111)
    b_samples = cfp.generate_random_gaussian_numbers(n=n, mu=b_mean, sigma=b_err, seed=seed+222)

    # number of bins
    bins = 1000

    # plot PDF of a
    ret_obj_a = mt.get_and_plot_pdf_stats(a_samples, bins=bins, xlabel=r'$a$', save="PDF_a.pdf")

    # plot PDF of b
    ret_obj_b = mt.get_and_plot_pdf_stats(b_samples, bins=bins, xlabel=r'$b$', save="PDF_b.pdf")

    # now define c
    c_samples = a_samples**2 / b_samples**2

    # plot PDF of c
    ret_obj_c = mt.get_and_plot_pdf_stats(c_samples, bins=bins, xlabel=r'$c$', save="PDF_c.pdf")

    # get the mode (most probable value)
    print('mode_c (from the PDF) = ', ret_obj_c.mode)

    # get the mean
    mean_c = np.mean(c_samples)
    print('mean_c (from the data directly) = ', mean_c)
    print('mean_c (from the PDF of c) = ', ret_obj_c.mean)

    # compute the standard deviation from the PDF
    print, 'stddev_c (from the PDF of c) = ', ret_obj_c.std

    # now compute the 16th and 84th percentile
    print('16th and 84th percentiles of c = ', ret_obj_c.sixteenth, ret_obj_c.eightyfourth)

    # compute the median
    print('median_c = (from the CDF of c) = ', ret_obj_c.median)

    # now pick your preferred best value; here let's pick the median
    err_low = ret_obj_c.median - ret_obj_c.sixteenth
    err_high = ret_obj_c.eightyfourth - ret_obj_c.median

    # print the final c
    print('c = ', ret_obj_c.median, ' (', ret_obj_c.std, ') -', err_low, ' +', err_high)

    stop()
