
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

#include <random>
#include <cmath>
#include <array>
#include <vector>

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#include "Site.h"
#include "globals.h"

int main(){

  const size_t N_sites = Lx*Ly*Lt;

  std::array<Site*, N_sites> lattice;

  for (int i = 0; i < N_sites; i++){
    lattice[i] = new Site();
  }

  for (int x = 0; x < Lx; x++){
    for (int y = 0; y < Ly; y++){
      for (int t = 0; t < Lt; t++){

        lattice[x + Lx*y + Lx*Ly*t]->xnext = lattice[(x+1)%Lx + Lx*y + Lx*Ly*t];
        lattice[x + Lx*y + Lx*Ly*t]->xprev = lattice[(x+Lx-1)%Lx + Lx*y + Lx*Ly*t];
        lattice[x + Lx*y + Lx*Ly*t]->ynext = lattice[x + Lx*((y+1)%Ly) + Lx*Ly*t];
        lattice[x + Lx*y + Lx*Ly*t]->yprev = lattice[x + Lx*((y+Ly-1)%Ly) + Lx*Ly*t];
        lattice[x + Lx*y + Lx*Ly*t]->tnext = lattice[x + Lx*y + Lx*Ly*((t+1)%Lt)];
        lattice[x + Lx*y + Lx*Ly*t]->tprev = lattice[x + Lx*y + Lx*Ly*((t+Lt-1)%Lt)];

        lattice[x + Lx*y + Lx*Ly*t]->xlink = x + Lx*y;
      }
    }
  }

  for (int i = 0; i < N_sites; i++){
    std::cout << lattice[i]->xlink << " ";
  }
  std::cout << std::endl;

  for (int i = 0; i < N_sites; i++){
    std::cout << lattice[i]->xnext->xlink << " ";
  }
  std::cout << std::endl;

  for (int i = 0; i < N_sites; i++){
    std::cout << lattice[i]->xprev->xlink << " ";
  }
  std::cout << std::endl;

  for (int i = 0; i < N_sites; i++){
    std::cout << lattice[i]->ynext->xlink << " ";
  }
  std::cout << std::endl;

  for (int i = 0; i < N_sites; i++){
    std::cout << lattice[i]->yprev->xlink << " ";
  }
  std::cout << std::endl;

  for (int i = 0; i < N_sites; i++){
    delete lattice[i];
  }

  return 0;
}
