#!/bin/bash

echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 2.2/beta = 1.6/g; w' | tr \; '\012' | ed -s globals.h

g++ -std=c++11 main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 1.6/beta = 1.5/g; w' | tr \; '\012' | ed -s globals.h

g++ -std=c++11 main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 1.5/beta = 1.4/g; w' | tr \; '\012' | ed -s globals.h

g++ -std=c++11 main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 1.4/beta = 1.3/g; w' | tr \; '\012' | ed -s globals.h

g++ -std=c++11 main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 1.3/beta = 1.2/g; w' | tr \; '\012' | ed -s globals.h

g++ -std=c++11 main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 1.2/beta = 2.6/g; w' | tr \; '\012' | ed -s globals.h

g++ -std=c++11 main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 2.6/beta = 2.7/g; w' | tr \; '\012' | ed -s globals.h

g++ -std=c++11 main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 2.7/beta = 2.8/g; w' | tr \; '\012' | ed -s globals.h

g++ -std=c++11 main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 2.8/beta = 2.9/g; w' | tr \; '\012' | ed -s globals.h

g++ -std=c++11 main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 2.9/beta = 3.0/g; w' | tr \; '\012' | ed -s globals.h

g++ -std=c++11 main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 3.0/beta = 1.1/g; w' | tr \; '\012' | ed -s globals.h

g++ -std=c++11 main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 1.1/beta = 1.0/g; w' | tr \; '\012' | ed -s globals.h

g++ -std=c++11 main.cpp Site.cpp operators.cpp update.cpp write.cpp -o main
./main
echo ',s/Lx = 10/Lx = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Ly = 10/Ly = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/Lt = 10/Lt = 10/g; w' | tr \; '\012' | ed -s globals.h
echo ',s/beta = 1.0/beta = 2.2/g; w' | tr \; '\012' | ed -s globals.h

python analysis.py params.txt
