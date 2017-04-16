
/*
/////////////////////////////////////////////////////////////////////////////

U(1) Lattice Gauge Theory Simulator | James Graham

Here we have the function to write out the data to my .csv files because I want
main to be very straightforward

/////////////////////////////////////////////////////////////////////////////
*/

#include <cmath>
#include <iostream>
#include <fstream>
#include <string>

#include "globals.h"

int write(double* avg_plaquette_data, double* jpc_plus_data, double* jpc_minus_data, double* flux_re_data, double* flux_im_data){

  // Output data to .csv so I can use excel or mathematica or python or whatever

  std::ofstream plaquette_output;
  std::ofstream mplus_output;
  std::ofstream mminus_output;
  std::ofstream flux_re_output;
  std::ofstream flux_im_output;

  double fractpart, intpart;
  fractpart = modf(beta, &intpart);

  std::string b = std::to_string(beta);
  std::string params = "_beta";
  params += b[0];
  params += b[1];
  params += b[2];
  // std::string params = "_" + std::to_string(Lx) + "_" + std::to_string(Ly) + "_" + std::to_string(Lt) + "_beta" + b[0] + b[1] + b[2];
  std::string path = "data/" + std::to_string(Lx) + "_" + std::to_string(Ly) + "_" + std::to_string(Lt) + "/";
  plaquette_output.open(path + "plaquette"+params+".csv");
  mplus_output.open(path + "mplus"+params+".csv");
  mminus_output.open(path + "mminus"+params+".csv");
  flux_re_output.open(path + "flux_re"+params+".csv");
  flux_im_output.open(path + "flux_im"+params+".csv");

  plaquette_output << "Sample #,value,\n";

  mplus_output << "Sample #,";
  mminus_output << "Sample #,";
  flux_re_output << "Sample #,";
  flux_im_output << "Sample #,";

  for (size_t t = 0; t < Lt; t++){
    mplus_output << "time " << t << ",";
    mminus_output << "time " << t << ",";
    flux_re_output << "time " << t << ",";
    flux_im_output << "time " << t << ",";
  }

  mplus_output << "\n";
  mminus_output << "\n";
  flux_re_output << "\n";
  flux_im_output << "\n";

  for (size_t i = 0; i < N_samples; i++){

    plaquette_output << i << "," << avg_plaquette_data[i] << ",\n";

    mplus_output << i << ",";
    mminus_output << i << ",";
    flux_re_output << i << ",";
    flux_im_output << i << ",";

    for (size_t t = 0; t < Lt; t++){
      mplus_output << jpc_plus_data[Lt*i + t] << ",";
      mminus_output << jpc_minus_data[Lt*i + t] << ",";
      flux_re_output << flux_re_data[Lt*i + t] << ",";
      flux_im_output << flux_im_data[Lt*i + t] << ",";
    }

    mplus_output << "\n";
    mminus_output << "\n";
    flux_re_output << "\n";
    flux_im_output << "\n";
  }

  plaquette_output.close();
  mplus_output.close();
  mminus_output.close();
  flux_re_output.close();
  flux_im_output.close();

  return 0;
}
