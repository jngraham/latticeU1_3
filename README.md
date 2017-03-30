# latticeU1_3

This is my third and best attempt to do the U(1) Lattice Gauge Theory simulation in C++ for my NPQFT problem set, again using the Metropolis algorithm.

## Outline

My code has seven imporant files:
* `globals.h`, which stores all the important parameters (except for `beta`) as `const int` or `const double`;
* `main.cpp`, in which `main()` calls `simulate()` with an argument of <img src="https://latex.codecogs.com/svg.latex?{\beta}" alt="{\beta}">;
* `simulate.cpp`, in which `simulate()` creates the lattice and generates field field configurations. It also orchestrates the collection of data and writing said data to arrays;
* `update.cpp`, in which `update()` takes in a pointer to the zeroth element of the lattice, a pointer to our set <img src="https://latex.codecogs.com/svg.latex?{V}" alt="{V}"> and a value of <img src="https://latex.codecogs.com/svg.latex?{\beta}" alt="{\beta}">, and modifies all the links in the lattice according to the Metropolis algorithm.
* `operators.cpp`, which contains several functions that compute <img src="https://latex.codecogs.com/svg.latex?{\langle\Phi^\dagger(t)\Phi(0)\rangle}" alt="{\langle\Phi^\dagger(t)\Phi(0)\rangle}"> for various operators, given a time coordinate;
* `write.cpp`, in which `write()` takes in pointers to our arrays of data (necessary for calculating the various
<img src="https://latex.codecogs.com/svg.latex?{\langle\cos(U_p)\rangle}" alt="{\langle\cos(U_p)\rangle}">, <img src="https://latex.codecogs.com/svg.latex?{a^2\sigma}" alt="{a^2\sigma}">, <img src="https://latex.codecogs.com/svg.latex?{m_{0^{++}}}" alt="{m_{0^{++}}}"> and <img src="https://latex.codecogs.com/svg.latex?{m_{0^{--}}}" alt="{m_{0^{--}}}">) and writes the data to CSV files, which can be analyzed with MATLAB, Excel, Python or whatever software you like;

and most importantly, we have:
* `Site.cpp`, which defines the `Site` class and its members. Each `Site` object has a member double for the phase of each link pointing in a **positive** direction from the Site, and a member pointer to each neighbouring `Site` object (6 in total: 1 for direction on each axis). `Site` objects do not know their positions, but we take care of this with the way we set up the lattice. This class has only the default constructor, which initializes every member to zero. The null pointers are overwritten immediately, but the zero link phases are deliberate; they are relaxed to some sort of equilibrium before we calculate anything

All the arrays in my code are explicitly 1D. With the exception of the array of the samples' plaquette averages, all our arrays are implicitly multi-dimensional. Our `lattice` of pointers to `Site` objects has dimensions `Lx`, `Ly`, `Lt` so a `Site` with coordinates (x,y,t) is accessed at
```
lattice[x + Lx*y + Lx*Ly*t]
```
Our other arrays, for example `jpc_plus_data`, has dimensions `N_samples`, `Lt` and we access the data point of sample `i` for time `t` at
```
jpc_plus_data[Lt*i + t]
```

## Algorithm

The code starts, of course, in `main()`, where we have an array of <img src="https://latex.codecogs.com/svg.latex?{\beta}" alt="{\beta}"> values, over which we loop and call `simulate()` with one of those values. For the purposes of the homework assignment, we have the values 2.0, 2.2 and 2.3.

The first thing `simulate()` does is declare and initialize to zero arrays of `double` to hold our data, declare and initialize an array of `double`, called `V`, to hold all the elements of our set <img src="https://latex.codecogs.com/svg.latex?{V}" alt="{V}">, and declare an an array of `Site*`, called `lattice`. Then we loop over `lattice`, allocate memory for a `new Site()` and assign the pointer to that memory to `lattice[i]`. Then, to link up all the sites with their neighbours, we loop over all x, y and t coordinates on the lattice. To calculate the x coordinate of the next and previous sites on the x axis, for instance, we calculate `(x+1)%Lx` and `(x+Lx-1)%Lx` and get the index of the appropriate `Site*` in `lattice` according to the formula given above.

Then we initialize `V`. This is accomplished by sampling from a normal distribution, whose mean and standard deviation are given in `globals.h`. `V` has `N_V` many elements, so we sample from the normal distribution `N_V/2` times, since `V` must have both the sample and its additive inverse in order for <img src="https://latex.codecogs.com/svg.latex?{\tilde{P}()}" alt="{\tilde{P}()}"> (and consequently ergodicity, per problem 3) to hold. The mean is naturally zero, and I found that setting the standard deviation to 0.75 bought me an acceptance rate in `update()` of around 50 percent, the value recommended in the problem set. After `V` has been populated, we relax the initial distribution of phases using `update()` a total of `N_equilibration_configs` times, which is given in `globals.h`.

Then we do the real calculation. This amounts to a loop over samples, within which is a loop over configurations per sample. Both relevant quantities are global variables. Inside every loop we `update()` the configuration (details given below) and calculate various data (again, more details on how these quantities are calculated are given below). The first datum is the average plaquette, which we divide by `N_configs_per_sample` and add to the appropriate entry in `avg_plaquette_data`. The next data are the values of <img src="https://latex.codecogs.com/svg.latex?{\Phi(0)}" alt="{\Phi(0)}"> for the other data we need: the lightest glueball operators and the real and imaginary parts of the flux tube operator. We calculate these first because we will need to refer to them `Lt` times when we calculate the correlators. Then we loop over all time coordinates to calculate all the <img src="https://latex.codecogs.com/svg.latex?{\Phi^\dagger(t)\Phi(0)}" alt="{\Phi^\dagger(t)\Phi(0)}">, divide them by `N_configs_per_sample` and add them to the appropriate entry in our data arrays (with the index for sample `i` and time `t` as given above).

Now the meat of the calculation is complete. We delete the pointers to our `Site` objects and write our data to CSV files, with names given by the name of the data array, the size of the lattice and the value of `beta`. Each file for average plaquette contains only two columns: one for the sample number and one for the values. All the other CSV files have many columns; on the vertical axis, as it were, we have the sample number, and on the horizontal axis we have time coordinate, ranging from zero to `Lt-1`.

## `update()` details



## Operator Calculation Details



## Issues / Improvements

I am not very good at C++, so there are many things I could have improved along the way. Here is a selection of those thing that I can name:
* I should have made my `lattice` a linked list, not an array. This way, the size of the lattice could be dynamic, rather than `const`. Initializing all the neighbours in this case would have been `O(n^2)` rather than `O(n)`, but this is something one can live with. If `lattice` had been a linked list, I could have passed the dimensions of the lattice as an array, rather than making it global variables. I suffered because of this approach in that to make all my simulations run efficiently, I needed to write a shell script to edit `globals.h` and recompile the code each time, which was a hassle because the `ed` command that edited the file on my machine wouldn't work on the Maths Institute computers, and the `sed` command that works for Ubuntu did not work with my machine. If I knew shell scripting any better, I could have made my way around this problem;
* I should have put the initialization of `lattice`, `V` — you name it — as separate functions. As it stands, `simulate()` is fairly cluttered, and if I had written a function to sample for `V` it would be easier to make the parameters for `V` arguments given at the start of the simulation, rather than in a file of globals;
* I should only use on random engine. At the moment it's sort of OK because each random engine is seeded by a different `clock()` call but it is not ideal. At the very least I have something that's pseudorandom every time. It was nice that the `default_random_engine` gave the same numbers every time while I was developing the simulation, but it's not great when I want to run an experiment.

<!-- <img src="https://latex.codecogs.com/svg.latex?{}" alt="{}"> -->
