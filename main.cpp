
/*
/////////////////////////////////////////////////////////////////////////////

U(1) Lattice Gauge Theory Simulator | James Graham

Here we do some linked-list / oop shenanigans with pointers. The lattice will be
an array of pointers to Site objects, each of which stores its x, y and t links
as doubles and stores its x, y and t neighbours' addresses.

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

clock_t t1 = clock();

int main(){

  // set up the RNG

  // std::mt19937 generator(time(0));
  std::default_random_engine generator;
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

  // declare the zero-time operators

  double this_avg_plaquette;
  double jpc_plus_zero;
  double jpc_minus_zero;
  double flux_zero [2];
  double flux_pair [2];

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

  // do the simulation

  for (int i = 0; i < N_samples; i++){

    double p_sum = 0;
    double jpc_plus_sum = 0;
    double jpc_minus_sum = 0;
    double flux_re_sum = 0;
    double flux_im_sum = 0;

    for (int j = 0; j < N_configs_per_sample; j++){
      update(lattice, V);

      this_avg_plaquette = avg_p(lattice);

      p_sum += this_avg_plaquette;
    }

    avg_plaquette_data[i] = p_sum / N_configs_per_sample;
    jpc_plus_data[i] = jpc_plus_sum / N_configs_per_sample;
    jpc_minus_data[i] = jpc_minus_sum / N_configs_per_sample;
    flux_re_data[i] = flux_re_sum / N_configs_per_sample;
    flux_im_data[i] = flux_im_sum / N_configs_per_sample;

    std::cout << "sample " << i << " of " << N_samples << " complete\n";

  }
  // delete pointers at the very end

  for (int i = 0; i < N_sites; i++){
    delete lattice[i];
  }

  clock_t t3 = clock();

  for (int i = 0; i < N_samples; i++){
    std::cout << avg_plaquette_data[i] << std::endl;
  }

  std::cout << "setup time: " << (double(t2) - double(t1)) / CLOCKS_PER_SEC << std::endl;
  std::cout << "compute time: " << (double(t3) - double(t2)) / CLOCKS_PER_SEC << std::endl;

  return 0;
}
