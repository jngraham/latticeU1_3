
/*
/////////////////////////////////////////////////////////////////////////////

U(1) Lattice Gauge Theory Simulator | James Graham

Site struct

/////////////////////////////////////////////////////////////////////////////
*/

#pragma once

class Site{

public:
  double xlink;
  double ylink;
  double tlink;

  Site* xnext;
  Site* xprev;

  Site* ynext;
  Site* yprev;

  Site* tnext;
  Site* tprev;

  Site();

};
