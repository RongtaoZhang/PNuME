                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             %% 
clc;
clear all;
addpath('../m-files/');
%% 
Aufgabe1();
Aufgabe2();

%% aufgabe 1 Rechengenauigkeit
function Aufgabe1()
    P1=[0 1];

    Theta=logspace(-20,5,1000); 

    P2=[Theta;Theta+1];

    x_ex=1;%实际上y=2和P1，P2点组成的直线相交点的横坐标是1

    x_num=zeros(1000,1);%这个是用Matlab算出来的这两条线交点的横坐标
    for i = 1:1000
        x_num(i) = lineintersection(P1,P2(:,i));
    end
    error=abs(x_ex-x_num);

    figure();

    loglog(Theta,error,'b','linewidth',1)
    axis([10e-20,10e5,10e-20,10e5]);
    grid on
end
%% 
function Aufgabe2()
    x = 0.6;
    x_node = [0.0,1.0,2.0,3.0,4.0];
    f_node = [0.000000000000, 0.031250000000, 0.131687242798, 0.237304687500, 0.327680000000];
    f_L1 = LagrangePolynom(x,1,x_node,f_node);
    f_L1d = LagrangeDerivPolynom(x,1,x_node,f_node);
    fprintf("f_L1(0.6) = %f,\nf_L1d(0.6) =%f\n",f_L1,f_L1d);
    f_L4 = LagrangePolynom(x,4,x_node,f_node);
    f_L4d = LagrangeDerivPolynom(x,4,x_node,f_node);
    fprintf("f_L4(0.6) = %f,\nf_L4d(0.6) =%f\n",f_L4,f_L4d);
    x_node2 = linspace(0,4,81);
    f_node2 = (x_node2./(1+x_node2)).^5;    
    f_L80 = LagrangePolynom(x,80,x_node2,f_node2);
    f_L80d = LagrangeDerivPolynom(x,80,x_node2,f_node2);
    fprintf("f_L80(0.6) = %f,\nf_L80d(0.6) =%f\n",f_L80,f_L80d);
    x = 0:0.01:4;
    y = zeros(size(x));
    y_d = zeros(size(x));
    for i = 1:length(x)
        y(i) = LagrangePolynom(x(i),4,x_node,f_node);
        y_d(i) = LagrangeDerivPolynom(x(i),4,x_node,f_node);
    end
    figure();
    scatter(x_node,f_node,'k','filled');
    hold on;
    plot(x,y);
    hold on;
    plot(x,y_d);
end
