#!/bin/bash

g++ main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 2.2/beta = 2.0/g; w' | tr \; '\012' | ed -s globals.h
g++ main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 2.0/beta = 2.3/g; w' | tr \; '\012' | ed -s globals.h
g++ main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 2.3/beta = 2.2/g; w' | tr \; '\012' | ed -s globals.h
