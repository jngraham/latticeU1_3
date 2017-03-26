
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

  }

  return p_sum / N_plaquettes;

  return 0;
}
