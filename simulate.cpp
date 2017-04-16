
/*
/////////////////////////////////////////////////////////////////////////////

U(1) Lattice Gauge Theory Simulator | James Graham

Here I write the simulator as a separate function so I can use main() to simulate
with a different beta each time.

/////////////////////////////////////////////////////////////////////////////
*/

#include <iostream>
#include <fstream>
#include <typeinfo>

#include <random>
#include <cmath>
#include <array>
#include <vector>

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#include "globals.h"
#include "Site.h"

#include "update.h"
#include "operators.h"
#include "write.h"

int simulate(){

  clock_t t1 = clock();

  // set up the RNG

  std::mt19937 generator(clock());
  // std::default_random_engine generator;
  std::normal_distribution<double> gaussian_distribution(mu,sigma);

  // declare lattice

  // std::array<Site*, N_sites> lattice;
  Site* lattice [N_sites];

  // declare V

  // std::array<double, N_V> V;
  double V [N_V] = {0};

  // declare data arrays

  // std::array<double, N_samples> avg_plaquette_data;
  // std::array<double, N_samples*Lt> jpc_plus_data;
  // std::array<double, N_samples*Lt> jpc_minus_data;
  // std::array<double, N_samples*Lt*2> flux_data;

  double avg_plaquette_data [N_samples] = {0};
  double jpc_plus_data [Lt*N_samples] = {0};
  double jpc_minus_data [Lt*N_samples] = {0};
  double flux_re_data [Lt*N_samples] = {0};
  double flux_im_data [Lt*N_samples] = {0};

  // declare the plaquette average

  double zero_avg_plaquette;
  double jpc_plus_zero;
  double jpc_minus_zero;
  double flux_re_zero;
  double flux_im_zero;
  double flux_re;
  double flux_im;

  // initialize, set up links among our sites

  for (int i = 0; i < N_sites; i++){
    lattice[i] = new Site();
  }

  // std::cout << (*(lattice + 1))->xlink << std::endl;
  // std::cout << lattice[1]->xlink << std::endl;

  // std::cout << typeid(*lattice[0]).name() << std::endl;

  int ythis;
  int tthis;

  for (int t = 0; t < Lt; t++){

    tthis = Lx*Ly*t;

    for (int y = 0; y < Ly; y++){

      ythis = Lx*y;

      for (int x = 0; x < Lx; x++){

        lattice[x + ythis + tthis]->xnext = lattice[(x+1)%Lx + ythis + tthis];
        lattice[x + ythis + tthis]->xprev = lattice[(x+Lx-1)%Lx + ythis + tthis];
        lattice[x + ythis + tthis]->ynext = lattice[x + Lx*((y+1)%Ly) + tthis];
        lattice[x + ythis + tthis]->yprev = lattice[x + Lx*((y+Ly-1)%Ly) + tthis];
        lattice[x + ythis + tthis]->tnext = lattice[x + ythis + Lx*Ly*((t+1)%Lt)];
        lattice[x + ythis + tthis]->tprev = lattice[x + ythis + Lx*Ly*((t+Lt-1)%Lt)];
      }
    }
  }

  // initialize V

  for (size_t i = 0; i < N_V; i += 2){
    double number = gaussian_distribution(generator);
    V[i] = number;
    V[i+1] = -number;
  }

  clock_t t2 = clock();

  // relax the initial configuration

  for (int i = 0; i < N_equilibration_configs; i++){
    update(lattice, V, beta);
  }
  // do the simulation

  int op_sample;

  for (int i = 0; i < N_samples; i++){

    op_sample = Lt*i;

    for (int j = 0; j < N_configs_per_sample; j++){

      update(lattice, V, beta);

      zero_avg_plaquette = avg_p_xy(lattice);

      avg_plaquette_data[i] += avg_p(lattice) / N_configs_per_sample;

      for (int T = 0; T < Lt; T++){

        jpc_plus_zero = m_plus(lattice, T, zero_avg_plaquette);
        jpc_minus_zero = m_minus(lattice, T);

        flux(lattice, T, &flux_re_zero, &flux_im_zero);

        for (int t = 0; t < Lt; t++){

          jpc_plus_data[op_sample + t] += jpc_plus_zero*m_plus(lattice, t+T, zero_avg_plaquette);
          jpc_minus_data[op_sample + t] += jpc_minus_zero*m_minus(lattice, t+T);

          // we need two numbers out of this, which is not ideal
          flux(lattice, t+T, &flux_re, &flux_im);

          flux_re_data[op_sample + t] += (flux_re_zero*flux_re + flux_im_zero*flux_im);
          flux_im_data[op_sample + t] += (flux_re_zero*flux_im - flux_im_zero*flux_re);
        }
      }
    }

    // avg_plaquette_data[i] = avg_plaquette_data[i] / N_configs_per_sample;

    std::cout << "sample " << (i+1) << " of " << N_samples << " complete\n";

  }

  // delete pointers at the very end

  for (int i = 0; i < N_sites; i++){
    delete lattice[i];
  }

// got to actually have averages

  for (int j =0; j < Lt*N_samples; j++) {
    jpc_plus_data[j] /= N_pts;
    jpc_minus_data[j] /= N_pts;
    flux_re_data[j] /= N_pts;
    flux_im_data[j] /= N_pts;
  }

  write(avg_plaquette_data, jpc_plus_data, jpc_minus_data, flux_re_data, flux_im_data, beta);

  clock_t t3 = clock();

  for (int i = 0; i < N_samples; i++){
    std::cout << avg_plaquette_data[i] << std::endl;
  }

  std::cout << "setup time: " << (double(t2) - double(t1)) / CLOCKS_PER_SEC << std::endl;
  std::cout << "compute time: " << (double(t3) - double(t2)) / CLOCKS_PER_SEC << std::endl;

  return 0;
}
