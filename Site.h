
/*
/////////////////////////////////////////////////////////////////////////////

U(1) Lattice Gauge Theory Simulator | James Graham

Site struct

/////////////////////////////////////////////////////////////////////////////
*/

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
