%{

Script: main.m
Version of the MATLAB implemented: 2017a.

Author: Nadia Matos
email: nadiamatos.18@gmail.com

This script call the Adaline.m script.

%}

clc; clear ('all'); close all;
format long;

%database = readtable('database-or.txt'); %Working!!!
database = readtable('database6.txt')
inputs = size(database, 2)-1;

rna = Adaline(database, 90, inputs);
rna.training();
rna.operation();
