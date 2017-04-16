
/*
/////////////////////////////////////////////////////////////////////////////

U(1) Lattice Gauge Theory Simulator | James Graham

In this version of the code, we do some linked-list / oop shenanigans with
pointers. The lattice will be an array of pointers to Site objects, each of
which stores its x, y and t links as doubles and stores its x, y and t
neighbours' addresses.

/////////////////////////////////////////////////////////////////////////////
*/

#include "simulate.h"

int main(){

  simulate();

  return 0;
}
