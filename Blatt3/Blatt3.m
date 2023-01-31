%% 
clc;
clear all;
close all;
addpath('../m-files/');
format long;
%% 
y = [0.0,1.0,3.0,1.0];
x_i_1 = 0;
eta_1 = 0;
x_i_2 = 0.577;
eta_2 = -0.577;

val_0 = linquadref(x_i_1,eta_1);
val_1 = linquadref(x_i_2,eta_2);

deriv_0 = linquadderivref(x_i_1,eta_1);
deriv_1 = linquadderivref(x_i_2,eta_2);

f_L_0 = y*val_0;
f_L_1 = y*val_1;
f_Ld_0 = y * deriv_0;
f_Ld_1 = y * deriv_1;
fprintf("fL(0.0;0.0)=%f\nfL(0.577;−0.577)=%f\n",f_L_0,f_L_1);
fprintf("fL_d_xi(0.0;0.0)=%f\nfL_d_eta(0.0;0.0)=%f\nfL_d_xi(0.577;−0.577)=%f\nfL_d_eta(0.577;−0.577)=%f\n",f_Ld_0(1),f_Ld_0(2),f_Ld_1(1),f_Ld_1(2));
