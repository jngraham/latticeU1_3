
/*
/////////////////////////////////////////////////////////////////////////////

U(1) Lattice Gauge Theory Simulator | James Graham

Write out the operator functions

/////////////////////////////////////////////////////////////////////////////
*/

#include <iostream>
#include <cmath>

#include "globals.h"
#include "operators.h"

double avg_p(Site** lattice){

  double p_sum = 0;

  double p_xy = 0;
  double p_xt = 0;
  double p_yt = 0;

  Site** ptr = lattice;

  for (size_t i = 0; i < N_sites; i++){

    p_xy = (*ptr)->xlink + (*ptr)->xnext->ylink - (*ptr)->ynext->xlink - (*ptr)->ylink;
    p_xt = (*ptr)->xlink + (*ptr)->xnext->tlink - (*ptr)->tnext->xlink - (*ptr)->tlink;
    p_yt = (*ptr)->ylink + (*ptr)->ynext->tlink - (*ptr)->tnext->ylink - (*ptr)->tlink;

    p_sum = p_sum + cos(p_xy) + cos(p_xt) + cos(p_yt);

    ptr++;
  }

  return p_sum / N_plaquettes;
}

double avg_p_xy(Site** lattice){

  double p_sum = 0;
  double p_xy = 0;

  Site** ptr = lattice;

  for (size_t i = 0; i < N_sites; i++){

    p_xy = (*ptr)->xlink + (*ptr)->xnext->ylink - (*ptr)->ynext->xlink - (*ptr)->ylink;

    p_sum += cos(p_xy);

    ptr++;
  }

  return p_sum / N_sites;
}

double m_plus(Site** lattice, int t, double VEV){

  double jpc_plus_sum = 0;
  double p_xy = 0;

  t %= Lt;

  size_t start = Lx*Ly*t;
  size_t end = Lx*Ly*(t+1);

  Site** ptr = lattice + start;

  for (size_t i = start; i < end; i++){
    p_xy = (*ptr)->xlink + (*ptr)->xnext->ylink - (*ptr)->ynext->xlink - (*ptr)->ylink;

    jpc_plus_sum += cos(p_xy) - VEV;
    ptr++;
  }

  return jpc_plus_sum;

}

double m_minus(Site** lattice, int t){

  double jpc_minus_sum = 0;
  double p_xy = 0;

  t %= Lt;

  size_t start = Lx*Ly*t;
  size_t end = Lx*Ly*(t+1);

  Site** ptr = lattice + start;

  for (size_t i = start; i < end; i++){
    p_xy = (*ptr)->xlink + (*ptr)->xnext->ylink - (*ptr)->ynext->xlink - (*ptr)->ylink;

    jpc_minus_sum += sin(p_xy);
    ptr++;
  }

  return jpc_minus_sum;
}

void flux(Site** lattice, int t, double* re_ptr, double* im_ptr){

  double phase_sum = 0;
  double re_sum = 0;
  double im_sum = 0;

  t %= Lt;

  size_t start = Lx*Ly*t;
  size_t end = Lx*Ly*(t+1);

  Site** ptr = lattice + start;

  for (size_t i = 0; i < Ly; i++){
    for (size_t j = 0; j < Lx; j++){
      phase_sum += (*ptr)->xlink;
      ptr++;
    }

    re_sum += cos(phase_sum);
    im_sum += sin(phase_sum);

    phase_sum = 0;
  }

  *re_ptr = re_sum;
  *im_ptr = im_sum;

  return;
}
