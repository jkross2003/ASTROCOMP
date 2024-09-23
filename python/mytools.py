#!/usr/bin/env python
# -*- coding: utf-8 -*-
# written by Christoph Federrath

import numpy as np
from cfpack.defaults import *
from cfpack import hdfio
import cfpack as cfp

# compute and plot PDF, return PDF and bins
def get_and_plot_pdf_stats(data, bins=200, plot=True, xlabel="x", log=False, save='PDF.pdf'):
    # get PDF and bins from cfpack.get_pdf -- this is an object
    pdf_obj = cfp.get_pdf(data, bins=bins)
    # plot the PDF
    if plot:
        ylabel = "PDF("+xlabel+")" # define the y-axis label
        cfp.plot(x=pdf_obj.bin_edges, y=pdf_obj.pdf, xlabel=xlabel, ylabel=ylabel, ylog=log, type="pdf", save=save)
    # define a class object that we will return below, containing the PDF and bin information
    class ret:
        bin_edges = pdf_obj.bin_edges
        bin_center = pdf_obj.bin_center
        pdf = pdf_obj.pdf
        # compute the bin width
        bin_width = bin_edges[1:] - bin_edges[:-1]
        # get the mean by summation over the PDF
        mean = np.sum(pdf*bin_center*bin_width)
        # get the mean-squared by summation over the PDF
        msq = np.sum(pdf*bin_center**2*bin_width)
        # now we can define the standard deviation
        std = np.sqrt(msq - mean**2)
        # get the mode
        mode = bin_center[pdf == np.max(pdf)]
        # compute CDF (cumulative distribution function)
        cdf = np.cumsum(pdf*bin_width)
        median       = bin_center[cdf >= 0.50][0] # get the median
        sixteenth    = bin_center[cdf >= 0.16][0] # get the 16th percentile
        eightyfourth = bin_center[cdf >= 0.84][0] # get the 84th percentile

    return ret

# ===== the following applies in case we are running this in script mode =====
if __name__ == "__main__":

    coldens = hdfio.read("EXTREME_proj_xy_000100", "dens_proj_xy")[:,:,0]

    I = np.log( coldens / coldens.mean() )

    ret_obj = get_and_plot_pdf_stats(I, log=True)

    stop()