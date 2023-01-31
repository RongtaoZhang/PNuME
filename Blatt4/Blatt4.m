%% 
clc;
clear all;
addpath('../m-files');
format long;
%% 
aufgabe1();
aufgabe2();
%% 
function aufgabe1()
    f = @Funktion;
    x_0 = 0.6;
    h = 0.1;
    f_2p = (f(x_0)-f(x_0-h))/h;
    f_3pe = (-3*f(x_0)+4*f(x_0+h)-f(x_0+2*h))/(2*h);
    f_3pm = (f(x_0+h)-f(x_0-h))/(2*h);
    f_5pm = (f(x_0-2*h)-8*f(x_0-h)+8*f(x_0+h)-f(x_0+2*h))/(12*h);
    fprintf("f_2p'(x=0.6)=%f\n",f_2p);
    fprintf("f_3pe'(x=0.6)=%f\n",f_3pe);
    fprintf("f_3pm'(x=0.6)=%f\n",f_3pm);
    fprintf("f_5pm'(x=0.6)=%f\n",f_5pm);
end
%% 
function aufgabe2()
    x_0 = 0.6;
    f = @Funktion;
    df = @Funktion2;
    h = logspace(-5,0,1000);
    fd2 = abs(df(x_0)-(f(x_0)-f(x_0-h))./h);
    fd3e = abs(df(x_0)-(-3*f(x_0)+4*f(x_0+h)-f(x_0+2*h))./(2*h));
    fd3m = abs(df(x_0)-(f(x_0+h)-f(x_0-h))./(2*h));
    fd5m = abs(df(x_0)-(f(x_0-2*h)-8*f(x_0-h)+8*f(x_0+h)-f(x_0+2*h))./(12*h));
    figure();
    loglog(h,h,'--k');
    hold on;
    loglog(h,h.^2,'-.k');
    hold on;
    loglog(h,h.^4,':k');
    hold on;
    loglog(h,fd2);
    hold on;
    loglog(h,fd3e);
    hold on;
    loglog(h,fd3m);
    hold on;
    loglog(h,fd5m);
    legend("h","h^2","h^4","fd2","fd3e","fd3m","fd5m",'Location','northwest');
    title('Konvergenzplot Finite Differenzen (x_0 = 0.6)');
    xlabel('h');
    ylabel("| f '(x = x_0) - f '_a_p_p_r_o_x(x = x_0) |");
    
    x_0 = 2;
    h = logspace(-5,0,1000);
    fd2 = abs(df(x_0)-(f(x_0)-f(x_0-h))./h);
    fd3e = abs(df(x_0)-(-3*f(x_0)+4*f(x_0+h)-f(x_0+2*h))./(2*h));
    fd3m = abs(df(x_0)-(f(x_0+h)-f(x_0-h))./(2*h));
    fd5m = abs(df(x_0)-(f(x_0-2*h)-8*f(x_0-h)+8*f(x_0+h)-f(x_0+2*h))./(12*h));
    figure();
    loglog(h,h,'--k');
    hold on;
    loglog(h,h.^2,'-.k');
    hold on;
    loglog(h,h.^4,':k');
    hold on;
    loglog(h,fd2);
    hold on;
    loglog(h,fd3e);
    hold on;
    loglog(h,fd3m);
    hold on;
    loglog(h,fd5m);
    legend("h","h^2","h^4","fd2","fd3e","fd3m","fd5m",'Location','northwest');
    title('Konvergenzplot Finite Differenzen (x_0 = 2)');
    xlabel('h');
    ylabel("| f '(x = x_0) - f '_a_p_p_r_o_x(x = x_0) |");
end


function y = Funktion(x)
    y = (x./(1+x)).^5;
end

function dy = Funktion2(x)
    dy = 5 * (x / (1+x))^4 *((1/(1+x))-x/(1+x)^2);
end