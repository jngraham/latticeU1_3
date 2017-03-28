#!/bin/bash

sed -i 's/Lx = 10/Lx = 18/g' globals.h
sed -i 's/Ly = 10/Lx = 18/g' globals.h
sed -i 's/Lt = 10/Lx = 24/g' globals.h

g++ -std=c++11 main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_small

sed -i 's/Lx = 18/Lx = 22/g' globals.h
sed -i 's/Ly = 18/Lx = 22/g' globals.h
sed -i 's/Lt = 24/Lx = 36/g' globals.h

g++ -std=c++11 main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_med

sed -i 's/Lx = 22/Lx = 28/g' globals.h
sed -i 's/Ly = 22/Lx = 28/g' globals.h
sed -i 's/Lt = 36/Lx = 40/g' globals.h

g++ -std=c++11 main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_large

sed -i 's/Lx = 28/Lx = 10/g' globals.h
sed -i 's/Ly = 28/Lx = 10/g' globals.h
sed -i 's/Lt = 40/Lx = 10/g' globals.h
