
#############################################################################
#
# U(1) Lattice Gauge Theory Simulator | James Graham
#
# Here we get our data analysis on
#
#############################################################################

import sys

import numpy
import matplotlib.pyplot as plt

fin = open(sys.argv[1], 'r')

Lx = int(fin.readline().split("=")[1])
Ly = int(fin.readline().split("=")[1])
Lt = int(fin.readline().split("=")[1])

beta = {"2.0":2.0, "2.2":2.2, "2.3":2.3}

avg_plaquette_data = []

for i in beta.keys():
    prefix = "data/"
    suffix = "_" + str(Lx) + "x" + str(Ly) + "x" + str(Lt) + "_beta" + i + ".csv"

    plaquette = open(prefix + "plaquette" + suffix, "r")
    # mplus = open(prefix + "mplus" + suffix, "r")
    # mminus = open(prefix + "mminus" + suffix, "r")
    # flux_re = open(prefix + "flux_re" + suffix, "r")
    # flux_im = open(prefix + "flux_im" + suffix, "r")

    plaquette.readline()

    temp = []

    for line in plaquette.readlines():
        data = line.split(",")

        # because we care for neither what sample number it has, nor the "\n"
        for i in xrange(1,len(data)-1):
            temp.append(float(data[i]))



    plaquette.close()
    # mplus.close()
    # mminus.close()
    # flux_re.close()
    # flux_im.close()

    avg_plaquette_data.append(temp)

plt.boxplot(avg_plaquette_data, labels=beta.keys())
plt.show()
