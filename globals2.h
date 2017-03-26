
/*
/////////////////////////////////////////////////////////////////////////////

U(1) Lattice Gauge Theory Simulator | James Graham

Global parameters

/////////////////////////////////////////////////////////////////////////////
*/

// Parameters for the size of the array

const int Lx = 18;
const int Ly = 18;
const int Lt = 24;

// Parameters for the number of iterations, etc.

const double beta = 2.0;

const int N_equilibration_configs = 2000;
const int N_configs_per_sample = 500;
const int N_samples = 10;

const int N_configs = N_configs_per_sample * N_samples;

const size_t N_sites = Lx*Ly*Lt;
const int N_links = 3*Lx*Ly*Lt;
const int N_plaquettes = 3*Lx*Ly*Lt;

// Parameters for selecting a new link

const int N_V = 200;
const double mu = 0;
const double sigma = 1.2;
