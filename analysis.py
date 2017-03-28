
#############################################################################
#
# U(1) Lattice Gauge Theory Simulator | James Graham
#
# Here we get our data analysis on
#
#############################################################################

import sys

import numpy as np
import matplotlib.pyplot as plt

beta = [2.0, 2.2, 2.3]
# folders = ["18_18_24"]
folders = ["18_18_24", "22_22_36", "28_28ores _40"]

for i in range(len(folders)):

    prefix = "data/" + folders[i] + "/"

    avg_plaquette_data = []
    avg_p_table = r'\begin{tabular}{c | c c} $\beta$ & $\mu$ & $\sigma$'

    labels = [];

    for j in beta:

        avg_p_table += r'\\'

        labels.append(r'$\beta=$'+str(j))
        suffix = "_beta" + str(j) + ".csv"

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
            for k in xrange(1,len(data)-1):
                temp.append(float(data[k]))

        plaquette.close()
        # mplus.close()
        # mminus.close()
        # flux_re.close()
        # flux_im.close()

        avg_plaquette_data.append(temp)
        avg_p_table += str(j) + r'&' + str(np.mean(temp)) + r'& ' + str(np.std(temp))

    avg_p_table += '\end{tabular}'

    bp = plt.figure("Average Plaquette")
    # plt.subplot(121)
    plt.boxplot(avg_plaquette_data, labels=labels, bootstrap=None)
    plt.ylabel(r'$\langle\cos(U_p)\rangle$')
    #
    # plt.subplot(122)
    # plt.cla()
    # plt.text(0,0,avg_p_table)
    plt.savefig(prefix + 'avg_plaquette.pdf', bbox_inches = "tight")
