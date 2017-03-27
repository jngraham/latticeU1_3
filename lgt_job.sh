#!/bin/bash

echo ',s/Lx = 10/Lx = 18/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 18/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 24/g; w' | tr \; '\012' | ed -s globals.h

g++ main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_small

echo ',s/Lx = 18/Lx = 22/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 18/Ly = 22/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 24/Lt = 36/g; w' | tr \; '\012' | ed -s globals.h

g++ main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_med

echo ',s/Lx = 22/Lx = 28/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 22/Ly = 28/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 36/Lt = 40/g; w' | tr \; '\012' | ed -s globals.h

g++ main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main_large

echo ',s/Lx = 28/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 28/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 40/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h

screen -d -m -S lgt_small ./main_small
screen -d -m -S lgt_med ./main_med
screen -d -m -S lgt_large ./main_large
