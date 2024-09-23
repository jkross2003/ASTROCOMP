#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# written by Christoph Federrath, 2019-2022

import numpy as np

### define some global constants ###########################################
import cfpack as cfp
from cfpack import print, stop, matplotlibrc
from cfpack.defaults import *
from cfpack.constants import *

############################################################################

### append to the matplotlib config dir, so we get access to mpl styles ####
import os
os.environ['MPLCONFIGDIR'] = os.environ['PYTHONPATH']+"/matplotlib"
############################################################################
