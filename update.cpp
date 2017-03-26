
/*
/////////////////////////////////////////////////////////////////////////////

U(1) Lattice Gauge Theory Simulator | James Graham

Write out the update function

/////////////////////////////////////////////////////////////////////////////
*/

#include <iostream>
#include <random>
#include <cmath>
#include <stdlib.h>
#include <time.h>

#include "globals.h"
#include "update.h"

// std::mt19937 update_generator(time(0));
std::default_random_engine update_generator;
std::uniform_int_distribution<int> int_distribution(0,N_V-1);
std::uniform_real_distribution<double> real_distribution(0.0,1.0);

int update(Site** array, double* gauss){

  double old_link;
  double new_link;

  double staple1;
  double staple2;
  double staple3;
  double staple4;

  double minus_old_action;
  double minus_new_action;

  double C;
  double z;

  // int N_acceptances = 0;

  Site** ptr = array;

  for (size_t i = 0; i < N_sites; i++){

    // update the x link

    old_link = (*ptr)->xlink;
    new_link = old_link + gauss[int_distribution(update_generator)];
    // new_link = old_link + gauss[int_distribution(generator)];

    staple1 = (*ptr)->xnext->ylink - (*ptr)->ynext->xlink - (*ptr)->ylink;
    staple2 = - (*ptr)->xnext->yprev->ylink - (*ptr)->yprev->xlink + (*ptr)->yprev->ylink;
    staple3 = (*ptr)->xnext->tlink - (*ptr)->tnext->xlink - (*ptr)->tlink;
    staple4 = - (*ptr)->xnext->tprev->tlink - (*ptr)->tprev->xlink + (*ptr)->tprev->tlink;

    minus_old_action = cos(old_link + staple1) + cos(old_link + staple2) + cos(old_link + staple3) + cos(old_link + staple4);
    minus_new_action = cos(new_link + staple1) + cos(new_link + staple2) + cos(new_link + staple3) + cos(new_link + staple4);

    // note that if the new action is smaller than the old action, then
    // C > 1 so we accept the new link.
    C = exp(beta * minus_new_action)/exp(beta * minus_old_action);

    z = real_distribution(update_generator);
    // z = real_distribution(generator);

    if (z < C){
      // N_acceptances++;
      (*ptr)->xlink = new_link;
    }

    // update the y link

    old_link = (*ptr)->ylink;
    new_link = old_link + gauss[int_distribution(update_generator)];
    // new_link = old_link + gauss[int_distribution(generator)];

    staple1 = (*ptr)->ynext->xlink - (*ptr)->xnext->ylink - (*ptr)->xlink;
    staple2 = - (*ptr)->xprev->ynext->xlink - (*ptr)->xprev->ylink + (*ptr)->xprev->xlink;
    staple3 = (*ptr)->ynext->tlink - (*ptr)->tnext->ylink - (*ptr)->tlink;
    staple4 = - (*ptr)->tprev->ynext->tlink - (*ptr)->tprev->ylink + (*ptr)->tprev->tlink;

    minus_old_action = cos(old_link + staple1) + cos(old_link + staple2) + cos(old_link + staple3) + cos(old_link + staple4);
    minus_new_action = cos(new_link + staple1) + cos(new_link + staple2) + cos(new_link + staple3) + cos(new_link + staple4);

    // note that if the new action is smaller than the old action, then
    // C > 1 so we accept the new link.
    C = exp(beta * minus_new_action)/exp(beta * minus_old_action);

    z = real_distribution(update_generator);
    // z = real_distribution(generator);

    if (z < C){
      // N_acceptances++;
      (*ptr)->ylink = new_link;
    }

    // update the t link

    old_link = (*ptr)->tlink;
    new_link = old_link + gauss[int_distribution(update_generator)];
    // new_link = old_link + gauss[int_distribution(generator)];

    staple1 = (*ptr)->tnext->xlink - (*ptr)->xnext->tlink - (*ptr)->xlink;
    staple2 = - (*ptr)->xprev->tnext->xlink - (*ptr)->xprev->tlink + (*ptr)->xprev->xlink;
    staple3 = (*ptr)->tnext->ylink - (*ptr)->ynext->tlink - (*ptr)->ylink;
    staple4 = - (*ptr)->yprev->tnext->ylink - (*ptr)->yprev->tlink + (*ptr)->yprev->ylink;

    minus_old_action = cos(old_link + staple1) + cos(old_link + staple2) + cos(old_link + staple3) + cos(old_link + staple4);
    minus_new_action = cos(new_link + staple1) + cos(new_link + staple2) + cos(new_link + staple3) + cos(new_link + staple4);

    // note that if the new action is smaller than the old action, then
    // C > 1 so we accept the new link.
    C = exp(beta * minus_new_action)/exp(beta * minus_old_action);

    z = real_distribution(update_generator);
    // z = real_distribution(generator);

    if (z < C){
      // N_acceptances++;
      (*ptr)->tlink = new_link;
    }

    ptr++;

  }

  // std::cout << "acceptance rate: " << double(N_acceptances) / double(N_links) << std::endl;

  return 0;
}
