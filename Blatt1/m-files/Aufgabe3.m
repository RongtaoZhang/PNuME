clc;
clear;
x = linspace(-pi,pi,100);
y = sin(x);
figure();
plot(x,y);
title('2D-Plot');
xlabel('x');
ylabel('sin(x)');
figure();
nodes = [-1,-1;0,-1;1,-1;-1,0;0,0;1,0;-1,1;0,1;1,1];
elements = [1,2,5,4;2,3,6,5;4,5,8,7;5,6,9,8];
sol = [2;1;2;1;0;1;2;1;2];
quadplot(nodes,elements,sol);