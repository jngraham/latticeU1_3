
/*
/////////////////////////////////////////////////////////////////////////////

U(1) Lattice Gauge Theory Simulator | James Graham

Global parameters

/////////////////////////////////////////////////////////////////////////////
*/

// Parameters for the size of the array

const int Lx = 10;
const int Ly = 10;
const int Lt = 10;

// Parameters for the number of iterations, etc.

const double beta=2.2;

const int N_equilibration_configs = 20000;
const int N_configs_per_sample = 10000;
const int N_samples = 25;

const int N_configs = N_configs_per_sample * N_samples;
const int N_pts = N_configs_per_sample * Lt;

const size_t N_sites = Lx*Ly*Lt;
const int N_links = 3*Lx*Ly*Lt;
const int N_plaquettes = 3*Lx*Ly*Lt;

// Parameters for selecting a new link

const int N_V = 400;
const double mu = 0;
const double sigma = 0.75;
