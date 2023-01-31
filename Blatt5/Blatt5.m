%% 
clc;
clear all;
addpath('../m-files');
format long;

% %% 
% aufgabe1();
% aufgabe2();
s = GaussQuadratur2d2(3);
disp(s)
%% 
function aufgabe1()
    a = 0;
    b = 4;
    f = @Funktion;
    % Mittelpunktregel
    Im = f((a+b)/2)*(b-a);
    %Trapezregel
    It = 1/2*(f(a)+f(b))*(b-a);
    fprintf('Im = %f\nIt = %f\n',Im,It);
    %Gauß-Quadratur mit einer Stützstelle
    I_G1 = (b-a)/2*gw(1)*f(transform(a,b,gx(1)));
    I_G2 = (b-a)/2*gw(2)*f(transform(a,b,gx(2)));
    I_G3 = (b-a)/2*gw(3)*f(transform(a,b,gx(3)));
    fprintf('I_G1 = %f\nI_G2 = %f\nI_G3 = %f\n',I_G1,I_G2,I_G3);
end
%% 
function aufgabe2()
    [J,detJ,invJ] = getJacobian([2, 1; 4, 1; 4, 3; 2, 2], 0.577, -0.577);
    m12G1 = GaussQuadratur2d(1);
    m12G2 = GaussQuadratur2d(2);
    m12G3 = GaussQuadratur2d(3);
    display(J);
    display(detJ);
    display(invJ);
    
    display(m12G1);
    display(m12G2);
    display(m12G3);
end
function aufgabe3()
    
end
%% 
function y = Funktion(x)
    y = (x./(1+x)).^5;
end

function s = GaussQuadratur2d(n)

    gaussx = gx2dref(n);
    gaussw = gw2dref(n);
    s=0;
    for i=1:n*n
        [~,detJ,~] = getJacobian([2, 1; 4, 1; 4, 3; 2, 2], gaussx(i,1), gaussx(i,2));
        N1=1/4*(1-gaussx(i,1))*(1-gaussx(i,2));
        N2=1/4*(1+gaussx(i,1))*(1-gaussx(i,2));
        s=s+N1*N2*detJ*gaussw(i);
    end
end

function s = GaussQuadratur2d2(n)
    gaussx = gx2dref(n);
    gaussw = gw2dref(n);
    s = 0;
    for i = 1:n*n
       [~, detJ, ~] = getJacobian([2, 1; 4, 1; 4, 3; 2, 2],gaussx(i,1), gaussx(i,2));
       x = getxPos([2, 1; 4, 1; 4, 3; 2, 2],gaussx(i,1), gaussx(i,2));
       s = s+(x(1)^2+x(2)^3)*detJ*gaussw(i);
    end
end