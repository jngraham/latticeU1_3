#!/bin/bash

g++ main.cpp Site.cpp simulate.cpp update.cpp operators.cpp write.cpp -o main

screen -dm -S lgt ./main
