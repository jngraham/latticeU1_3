
/*
/////////////////////////////////////////////////////////////////////////////

U(1) Lattice Gauge Theory Simulator | James Graham

Declare the various operators we need to calculate things about the lattice

/////////////////////////////////////////////////////////////////////////////
*/

#include "Site.h"

double avg_p(Site** lattice);

double avg_p_xy(Site** lattice);

double m_plus(Site** lattice, int t, double VEV);

double m_minus(Site** lattice, int t);

void flux(Site** lattice, int t, double* re_ptr, double* im_ptr);
