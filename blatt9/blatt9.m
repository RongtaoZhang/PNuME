clc;
clear all;
addpath('../m-files');
format long;
%% 
n = 300;
phi = 5.1;
A = diag(phi*ones(1,n));
A = A + diag(-2*ones(1,n-1),1) + diag(-2*ones(1,n-1),-1);
A(1,1) = 1;
b = ones(n,1);
rtol = 1e-7;
itermax = 1000000;
x0 = zeros(n,1);
%% 
% solveG(A,b,x0,rtol,itermax);
% solveCG(A,b,x0,rtol,itermax);
%phi = 10    G:183, CG:14
%phi = 6    G:405      CG:22
%phi = 5.1    G:3145      CG:32
%phi = 5.01    G:30569      CG:36
%phi = 5.001    G:304819      CG:40
%% 
tic;
% solveGauss(A,b);
solveG(A,b,x0,rtol,itermax);
% solveCG(A,b,x0,rtol,itermax);
toc;
%phi = 10    G:183     CG:14    Gauss
%phi = 6    G:405      CG:22    Gauss: 
%phi = 5.1    G:0.060181     CG:0.009739     Gauss: 0.024609
%phi = 5.01    G:0.507975      CG:0.010362      Gauss: 0.025391
%phi = 5.001    G:4.993032      CG:0.010289     Gauss:0.027581
%phi = 5.00001    G:      CG:       Gauss
%phi = 5.0000001    G:      CG:
%phi = 5.000000001    G:      CG:
%phi = 5.00000000001    G:      CG: