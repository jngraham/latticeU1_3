
/*
/////////////////////////////////////////////////////////////////////////////

U(1) Lattice Gauge Theory Simulator | James Graham

Global parameters

/////////////////////////////////////////////////////////////////////////////
*/

// Parameters for the size of the array

const int Lx = 3;
const int Ly = 3;
const int Lt = 3;

// Parameters for the number of iterations, etc.

const double beta = 2.2;

const int N_equilibration_configs = 2000;
const int N_configs_per_sample = 500;
const int N_samples = 10;

const int N_configs = N_configs_per_sample * N_samples;

const int N_links = Lx * Ly * Lt * 3;

// Parameters for selecting a new link

const int N_V = 200;
const double mu = 0;
const double sigma = 1.2;
