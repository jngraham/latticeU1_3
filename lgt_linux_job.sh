#!/bin/bash

sed -i 's/Lx = 10/Lx = 18/g' globals.h
sed -i 's/Ly = 10/Ly = 18/g' globals.h
sed -i 's/Lt = 10/Lt = 24/g' globals.h

g++ -std=c++11 main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_small20
sed -i 's/beta = 2.0/beta=2.2/g' globals.h
g++ -std=c++11 main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_small22
sed -i 's/beta = 2.2/beta=2.3/g' globals.h
g++ -std=c++11 main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_small23
sed -i 's/beta = 2.3/beta=2.0/g' globals.h

sed -i 's/Lx = 18/Lx = 22/g' globals.h
sed -i 's/Ly = 18/Ly = 22/g' globals.h
sed -i 's/Lt = 24/Lt = 36/g' globals.h

g++ -std=c++11 main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_med20
sed -i 's/beta = 2.0/beta=2.2/g' globals.h
g++ -std=c++11 main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_med22
sed -i 's/beta = 2.2/beta=2.3/g' globals.h
g++ -std=c++11 main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_med23
sed -i 's/beta = 2.3/beta=2.0/g' globals.h

sed -i 's/Lx = 22/Lx = 28/g' globals.h
sed -i 's/Ly = 22/Ly = 28/g' globals.h
sed -i 's/Lt = 36/Lt = 40/g' globals.h

g++ -std=c++11 main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_large20
sed -i 's/beta = 2.0/beta=2.2/g' globals.h
g++ -std=c++11 main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_large22
sed -i 's/beta = 2.2/beta=2.3/g' globals.h
g++ -std=c++11 main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_large23
sed -i 's/beta = 2.3/beta=2.0/g' globals.h

sed -i 's/Lx = 28/Lx = 10/g' globals.h
sed -i 's/Ly = 28/Ly = 10/g' globals.h
sed -i 's/Lt = 40/Lt = 10/g' globals.h
