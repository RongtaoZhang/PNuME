clc;
clear all;
close all;

addpath('../m-files/');

format long;

% Aufgabe1();

% Aufgabe2();

Aufgabe3();

% mtest();


%% 
function Aufgabe1()
A = 3 * eye(4);
v = [1;2;3;4];
a = v'* v;
B = v * v';
C = A * B;
eig_C = eig(C);
x = inv(C-A)*(a.*v);
C(:,2) = v;
b = C(3,:);
c = 10:0.5:100;
f = c.*(5+c)+1./c+2.^c;
lf = length(f);
end
%% 
function Aufgabe2()
a = rand(1000,1);
if a(1)>=0.5
    disp('a1 >= 0.5');
else
    disp('a1 < 0.5');
end
n05 = 0;
for i=1:1000
    if a(i)>= 0.5
        n05 = n05 + 1;
    end
end
fprintf('n05 = %d\n',n05);
i = 1;
while(i ~= length(a))
    if a(i)<=0.501 && a(i)>=0.499
        fprintf('Der erste Eintrag gilt 0.499-0.501 ist a_%d = %d\n',i,a(i));
        break
    end
    i = i + 1;
end
if i == length(a) +1
    fprintf('Kein Element 0.499 <= a_i <=0.501\n');
end
fprintf('5! = %d, 0! = %d\n',factorial(5),factorial(0));
end
%% 

function Aufgabe3()
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
end