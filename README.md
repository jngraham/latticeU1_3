# latticeU1_3

This is a third and best attempt to do the U(1) Lattice Gauge Theory simulation in C++ for my NPQFT problem set, using the Metropolis algorithm.

My code has six files:
* `main.cpp`, in which `main()` calls `simulate()` with an argument of <img src="https://latex.codecogs.com/svg.latex?{\(\beta\)}" alt="{\beta}">;
* `simulate.cpp`, in which `simulate()` creates the lattice and generates field field configurations. It also orchestrates the collection of data and writing said data to arrays;
* `update.cpp`, in which `update()` takes in a pointer to the zeroth element of the lattice, a pointer to our set <img src="https://latex.codecogs.com/svg.latex?{V}" alt="{V}"> and a value of <img src="https://latex.codecogs.com/svg.latex?{\beta}" alt="{\beta}">, and modifies all the links in the lattice according to the Metropolis algorithm.
* `operators.cpp`, which contains several functions that compute <img src="https://latex.codecogs.com/svg.latex?{\langle\Phi^\dagger(t)\Phi(0)\rangle}" alt="{\langle\Phi^\dagger(t)\Phi(0)\rangle}"> for various operators, given a time coordinate;
* `write.cpp`, in which write() takes in pointers to our arrays of data (necessary for calculating the various
<img src="https://latex.codecogs.com/svg.latex?{\langle\cos(U_p)\rangle}" alt="{\langle\cos(U_p)\rangle}">, <img src="https://latex.codecogs.com/svg.latex?{a^2\sigma}" alt="{a^2\sigma}">, <img src="https://latex.codecogs.com/svg.latex?{m_{0^{++}}}" alt="{m_{0^{++}}}"> and <img src="https://latex.codecogs.com/svg.latex?{m_{0^{--}}}" alt="{m_{0^{--}}}">) and writes the data to CSV files;

most importantly, we have:
* `Site.cpp`, which defines the `Site` class and its members. Each `Site` object has a member double for each link pointing in a **positive** direction from the Site, and a member pointer to each neighbouring `Site` object (6 in total: 1 for direction on each axis). `Site` objects do not know their positions, but we take care of this with the way we set up the lattice.
