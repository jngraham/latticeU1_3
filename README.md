# latticeU1_3

This is my third and best attempt to do the U(1) Lattice Gauge Theory simulation in C++ for my NPQFT problem set, again using the Metropolis algorithm.

We are dealing with U(1), and more specifically the representation of elements of U(1) as complex exponentials, so when in the maths we store and multiply link matrices, in the code we store and add phases. This approach is computationally cheaper and means we do not have to deal with complex numbers.

## Outline

My code has seven important files:
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

Then we initialize `V`. This is accomplished by sampling from a normal distribution, whose mean and standard deviation are given in `globals.h`. `V` has `N_V` many elements, so we sample from the normal distribution `N_V/2` times, since `V` must have both the sample and its additive inverse so the probabilities of selecting <img src="https://latex.codecogs.com/svg.latex?{U_l}" alt="{U_l}"> given <img src="https://latex.codecogs.com/svg.latex?{U_l'}" alt="{U_l'}"> and vice versa are equal (and consequently for ergodicity, per problem 3, to hold). The mean is naturally zero, and I found that setting the standard deviation to 0.75 bought me an acceptance rate in `update()` of around 50 percent, the value recommended in the problem set. After `V` has been populated, we relax the initial distribution of phases using `update()` a total of `N_equilibration_configs` times, which is given in `globals.h`.

Then we do the real calculation. This amounts to a loop over samples, within which is a loop over configurations per sample. Both relevant quantities are global variables. Inside every loop we `update()` the configuration (details given below) and calculate various data (again, more details on how these quantities are calculated are given below). The first datum is the average plaquette, which we divide by `N_configs_per_sample` and add to the appropriate entry in `avg_plaquette_data`. The next data are the values of <img src="https://latex.codecogs.com/svg.latex?{\Phi(0)}" alt="{\Phi(0)}"> for the other data we need: the lightest glueball operators and the real and imaginary parts of the flux tube operator. We calculate these first because we will need to refer to them `Lt` times when we calculate the correlators. Then we loop over all time coordinates to calculate all the <img src="https://latex.codecogs.com/svg.latex?{\Phi^\dagger(t)\Phi(0)}" alt="{\Phi^\dagger(t)\Phi(0)}">, divide them by `N_configs_per_sample` and add them to the appropriate entry in our data arrays (with the index for sample `i` and time `t` as given above).

Now the meat of the calculation is complete. We delete the pointers to our `Site` objects in `lattice` and write our data to CSV files, with names given by the name of the data array, the size of the lattice and the value of `beta`. Each file for average plaquette contains only two columns: one for the sample number and one for the values. All the other CSV files have many columns; on the vertical axis, as it were, we have the sample number, and on the horizontal axis we have the time coordinate, ranging from zero to `Lt-1`.

## `update()` Details

The function `update()` takes as arguments `beta` by value, and `lattice` and `V` by reference. The purpose of the function is to iterate over all the `Site*` elements of `lattice` and use the Metropolis algorithm to update each link pointed to by each `Site`. I have a `for` loop over all the indices in `lattice` but to access data I use the `Site**` that is passed as an argument and increment it each time I loop. This is a fairly half-baked method of iterating through the lattice. Within each loop, I attempt to update the x, y and t links associated with each `Site`. I attempt this only once, rather than as many as five times as suggested in the lecture. To illustrate, I describe my implementation of the Metropolis algorithm to update the x link; the procedure has minor differences (namely which links we dereference) when we update the y and t links.

First we store the current x link in a dummy variable `old_link` and obtain a trial link by adding a phase to `old_link`, where the phase is uniformly sampled from `V`, which has been prepared as an array of samples from a normal distribution as discussed above.

Since the lattice is in 2+1 dimensions, each link belongs to four plaquettes, so we have to calculate four 'staples', which we combine with the link matrix of the current link to calculate the action. Each `Site` has pointers to its neighbours, so we can dereference as many times as we like to find the appropriate links and their phases to calculate the staples. For example, each x link belongs to two plaquettes that lie in the xy plane. The (correctly oriented) staples associated with these plaquettes, for example, are calculated by
```
staple1 = (*ptr)->xnext->ylink - (*ptr)->ynext->xlink - (*ptr)->ylink;
staple2 = - (*ptr)->xnext->yprev->ylink - (*ptr)->yprev->xlink + (*ptr)->yprev->ylink;
```
where `ptr` is a pointer to `lattice[i]`, which itself is a pointer to a `Site`. Once we have calculated all the staples, we can calculate the action for the old and new links. Strictly, the integrand in our path integral is
<img src="https://latex.codecogs.com/svg.latex?{e^{-\beta S[U]}}" alt="{e^{-beta S[U]}}">
with action given by
<img src="https://latex.codecogs.com/svg.latex?{S[U]=\sum_p \left(1-\textrm{Re}\textrm{Tr}U_p\right)=\sum_p \left(1-\cos\theta_p\right)}" alt="{S[U]=\sum_p \left(1-\textrm{Re}\textrm{Tr}U_p\right)=\sum_p \left(1-\cos\theta_p\right)}">
but the 1 in the action amounts to a constant in front of the path integral and the minus signs cancel out. Furthermore, the Metropolis algorithm relies on the ratio
<img src="https://latex.codecogs.com/svg.latex?{C= e^{-\beta S[U']}/e^{-\beta S[U]}}" alt="{C= e^{-\beta S[U']}/e^{-\beta S[U]}}">
When we change one link, the only change in the action comes from the cosines of the plaquettes around that link. So the salient part of the action, and the part we calculate for both the old link phase and new link phase, is

<img src="https://latex.codecogs.com/svg.latex?{\sum_j\cos(\theta_l+\xi_j)}" alt="{\sum_j\cos(\theta_l+\xi_j)}">
and we find
<img src="https://latex.codecogs.com/svg.latex?{C=\exp\left(\beta\left(\sum_j\cos(\theta_l'+\xi_j)-\sum_j\cos(\theta_l+\xi_j)\right)\right)}" alt="{C=\exp\left(\beta\left(\sum_j\cos(\theta_l'+\xi_j)-\sum_j\cos(\theta_l+\xi_j)\right)\right)}}">
Then we sample a z uniformly between 0 and 1, and if z is less than C, we accept the new link and change it by `(*ptr)->xlink = new_link;`. The construction of C is helpful, since if the new action is smaller than the old action (if the sum of cosines is larger for the new link than for the old link), then C is larger than 1 and we always accept the change. If the new action is larger, then C is between 0 and 1 and we automatically accept the change with the transition probability given by equation (8) in the problem set.

## Operator Calculation Details



## Issues / Improvements

I am not very good at C++, so there are many things I could have improved along the way. Here is a selection of those thing that I can name:
* I should have made my `lattice` a linked list, not an array. This way, the size of the lattice could be dynamic, rather than `const`. Initializing all the neighbours in this case would have been `O(n^2)` rather than `O(n)`, but this is something one can live with. If `lattice` had been a linked list, I could have passed the dimensions of the lattice arguments. Another disadvantage to this approach was that I had to keep count of the indices in `lattice` when I update the configuration and calculate the data. If `lattice` had been a linked list, it would have known when we got to the end;
* I should not have used so many, or any, global variables. I suffered because of this approach in that to make all my simulations run efficiently, I needed to write a shell script to edit `globals.h` and recompile the code each time, which was a hassle because the `ed` command that edited the file on my machine wouldn't work on the Maths Institute computers, and the `sed` command that works for Ubuntu did not work with my machine. If I knew shell scripting any better, I could have made my way around this problem;
* I should have put the initialization of `lattice`, `V` — you name it — as separate functions. As it stands, `simulate()` is fairly cluttered, and if I had written a function to sample for `V` it would be easier to make the parameters for `V` arguments given at the start of the simulation, rather than in a file of globals;
* I should only use on random engine. At the moment it's sort of OK because each random engine is seeded by a different `clock()` call but it is not ideal. At the very least I have something that's pseudorandom every time. It was nice that the `default_random_engine` gave the same numbers every time while I was developing the simulation, but it's not great when I want to run an experiment;
* I should have been more concise and put my functions all into one header / cpp file and made it so I call `simulate()` with all the relevant parameters;
* I should have made `write()` create directories to save data to; I ran into a problem where there was no folder to save data to; luckily I caught it early. I am more used to Python, which does allow you to create directories by saving a file to `~/dir/file.txt` where `dir` is a directory that doesn't exist;
* In a similar vein, I should have made my MATLAB code create all the directories it needs to save figures and summary data;

and finally:
* I should have parallelized the simulation. It is important for the Metropolis algorithm to work that we take into account an updated link at a `Site` when we update the links at one of its neighbours, but there is no reason to wait until a link at one site is updated before we update a link far removed from it on the lattice. If I had a good handle on parallel computing (in any language, let alone C++) I should have made my code so that we update first the x links, then the y links, then the t links. For each direction of link we update, we can split the lattice into two parts. Imagine, for instance, we are updating links in the t direction, and picture a cross-section of the lattice spanning the x and y directions, coloured like a chess board. We can update the t links at all sites that have the same colour, since the staples for the plaquette calculations do not include any links that we are at present updating. Now consider extending a black square in the t dimension so that it becomes a rod. We can also update all the sites on that rod in parallel. This procedure could in principle reduce the generation of a new configuration to a sequence of six steps (two for each dimension of the lattice), in which each step involves on the order of ten thousand (yikes) parallel calculations, from a sequence of on the order of ten thousand calculations. I have no idea how one would multithread that so this is something of a lofty goal, especially compared to the other items in this section.

<!-- <img src="https://latex.codecogs.com/svg.latex?{}" alt="{}"> -->
