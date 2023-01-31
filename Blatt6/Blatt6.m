%%
clc;
clear all;
addpath('../m-files');
format long;

%% 
% aufgabe1();
aufgabe2();
%% 
function aufgabe1()
    fi0 = 0;
    dt1=0.1;
    dt2 = 0.2;
    dt3 = 0.4;
    t1 = 0:dt1:2;
    t2 = 0:dt2:2;
    t3 = 0:dt3:2;
    fi1 = allgemeine_fun(t1,fi0,0);%Vorwaerts-Euler dt = 0.1
    fi2 = allgemeine_fun(t2,fi0,0);%Vorwaerts-Euler dt = 0.2
    fi3 = allgemeine_fun(t3,fi0,0);%Vorwaerts-Euler dt = 0.4
    fi_ex = exakte(t1);
    figure();
    plot(t1,fi1);
    hold on;
    plot(t2,fi2);
    hold on;
    plot(t3,fi3);
    hold on;
    plot(t1,fi_ex);
    legend('dt = 0.1','dt = 0.2','dt = 0.4','exakte wert');
    xlabel('t');
    ylabel('fi');
    title('Vorwärts-Euler Verfahren');

    fi1 = allgemeine_fun(t1,fi0,1);%Rückwärts-Euler dt = 0.1
    fi2 = allgemeine_fun(t2,fi0,1);%Rückwärts-Euler dt = 0.2
    fi3 = allgemeine_fun(t3,fi0,1);%Rückwärts-Euler dt = 0.4
    figure();
    plot(t1,fi1);
    hold on;
    plot(t2,fi2);
    hold on;
    plot(t3,fi3);
    hold on;
    plot(t1,fi_ex);
    legend('dt = 0.1','dt = 0.2','dt = 0.4','exakte wert');
    xlabel('t');
    ylabel('fi');
    title('Rückwärts-Euler Verfahren');

    fi1 = allgemeine_fun(t1,fi0,0.5);%Trapezregel dt = 0.1
    fi2 = allgemeine_fun(t2,fi0,0.5);%Trapezregel dt = 0.2
    fi3 = allgemeine_fun(t3,fi0,0.5);%Trapezregel dt = 0.4
    figure();
    plot(t1,fi1);
    hold on;
    plot(t2,fi2);
    hold on;
    plot(t3,fi3);
    hold on;
    plot(t1,fi_ex);
    legend('dt = 0.1','dt = 0.2','dt = 0.4','exakte wert');
    xlabel('t');
    ylabel('fi');
    title('Trapezregel');
end
%% 
function aufgabe2()
    [LHS,RHS] = OST(0.5, 0.2, [1.1], [1.4, 1.5], [1.7, 1.8], [2.0]);
    [LHS,RHS] = AB2(0.2, [1.1], [1.5, 1.6], [1.8, 1.9], [2.0, 2.1]);
    [LHS,RHS] = AM3(0.2, [1.1], [1.4, 1.5, 1.6], [1.7, 1.8, 1.9], [2.0, 2.1]);
    [LHS,RHS] = BDF2(0.2, [1.1], [1.4], [1.7], [2.0, 2.1]);
    M = 1;
    B = -6;
    C = @Ct;
    dt1=0.1;
    dt2 = 0.2;
    dt3 = 0.4;
    t1 = 0:dt1:2;
    t2 = 0:dt2:2;
    t3 = 0:dt3:2;
    %Vorwaerts-euler-verfahren
    fi_vor = zeros(1,length(t1));
    %Rückwärts-Euler-Verfahren
    fi_Rue = zeros(1,length(t1));
    %Trapezregel
    fi_tra = zeros(1,length(t1));
    fi_ab2 = zeros(1,length(t1));
    fi2 = allgemeine_fun(t1(1:2),0,0.5);
    fi_ab2(2) = fi2(2);
    fi_am3 = fi_ab2;
    fi_bdf2 = fi_ab2;
    fi_ex = exakte([0:0.05:2]);
    for i = 1:length(t1)-1
       [LHS,RHS] = OST(0,dt1,M,[B,B],[C(t1(i+1)),C(t1(i))],fi_vor(i));
       fi_vor(i+1) = RHS/LHS;
       [LHS,RHS] = OST(1,dt1,M,[B,B],[C(t1(i+1)),C(t1(i))],fi_Rue(i));
       fi_Rue(i+1) = RHS/LHS;
       [LHS,RHS] = OST(0.5,dt1,M,[B,B],[C(t1(i+1)),C(t1(i))],fi_tra(i));
       fi_tra(i+1) = RHS/LHS;
       if i >= 2
            [LHS,RHS] = AB2(dt1,M,[B,B],[C(t1(i)),C(t1(i-1))],[fi_ab2(i),fi_ab2(i-1)]);
            fi_ab2(i+1) = RHS/LHS;
            [LHS,RHS] = AM3(dt1,M,[B,B,B],[C(t1(i+1)),C(t1(i)),C(t1(i-1))],[fi_am3(i),fi_am3(i-1)]);
            fi_am3(i+1) = RHS/LHS;
            [LHS,RHS] = BDF2(dt1,M,B,C(t1(i+1)),[fi_bdf2(i),fi_bdf2(i-1)]);
            fi_bdf2(i+1) = RHS/LHS;
       end
    end
    figure();
    plot(t1,fi_vor,'linewidth',1);
    hold on;
    plot(t1,fi_Rue,'linewidth',1);
    hold on;
    plot(t1,fi_tra,'linewidth',1);
    hold on;
    plot(t1,fi_ab2,'linewidth',1);
    hold on;
    plot(t1,fi_am3,'linewidth',1);
    hold on;
    plot(t1,fi_bdf2,'linewidth',1);
    hold on;
    plot([0:0.05:2],fi_ex,'k--','linewidth',1);
    legend('Euler Vorwaerts','Euler Ruekwaerts','Trapez','AB2','AM3','BDF2','exakt');
    title('Lösung Mit Zeitschrittlänge: 0.1','FontWeight','bold')
    xlabel('t');
    ylabel('\phi(t)');
    %% dt = 0.2
     %Vorwaerts-euler-verfahren
    fi_vor = zeros(1,length(t2));
    %Rückwärts-Euler-Verfahren
    fi_Rue = zeros(1,length(t2));
    %Trapezregel
    fi_tra = zeros(1,length(t2));
    fi_ab2 = zeros(1,length(t2));
    fi2 = allgemeine_fun(t2(1:2),0,0.5);
    fi_ab2(2) = fi2(2);
    fi_am3 = fi_ab2;
    fi_bdf2 = fi_ab2;
    for i = 1:length(t2)-1
       [LHS,RHS] = OST(0,dt2,M,[B,B],[C(t2(i+1)),C(t2(i))],fi_vor(i));
       fi_vor(i+1) = RHS/LHS;
       [LHS,RHS] = OST(1,dt2,M,[B,B],[C(t2(i+1)),C(t2(i))],fi_Rue(i));
       fi_Rue(i+1) = RHS/LHS;
       [LHS,RHS] = OST(0.5,dt2,M,[B,B],[C(t2(i+1)),C(t2(i))],fi_tra(i));
       fi_tra(i+1) = RHS/LHS;
       if i >= 2
            [LHS,RHS] = AB2(dt2,M,[B,B],[C(t2(i)),C(t2(i-1))],[fi_ab2(i),fi_ab2(i-1)]);
            fi_ab2(i+1) = RHS/LHS;
            [LHS,RHS] = AM3(dt2,M,[B,B,B],[C(t2(i+1)),C(t2(i)),C(t2(i-1))],[fi_am3(i),fi_am3(i-1)]);
            fi_am3(i+1) = RHS/LHS;
            [LHS,RHS] = BDF2(dt2,M,B,C(t2(i+1)),[fi_bdf2(i),fi_bdf2(i-1)]);
            fi_bdf2(i+1) = RHS/LHS;
       end
    end
    figure();
    plot(t2,fi_vor,'linewidth',1);
    hold on;
    plot(t2,fi_Rue,'linewidth',1);
    hold on;
    plot(t2,fi_tra,'linewidth',1);
    hold on;
    plot(t2,fi_ab2,'linewidth',1);
    hold on;
    plot(t2,fi_am3,'linewidth',1);
    hold on;
    plot(t2,fi_bdf2,'linewidth',1);
    hold on;
    plot([0:0.05:2],fi_ex,'k--','linewidth',1);
    legend('Euler Vorwaerts','Euler Ruekwaerts','Trapez','AB2','AM3','BDF2','exakt');
    title('Lösung Mit Zeitschrittlänge: 0.2','FontWeight','bold')
    xlabel('t');
    ylabel('\phi(t)');
    %% dt = 0.4
    %Vorwaerts-euler-verfahren
    fi_vor = zeros(1,length(t3));
    %Rückwärts-Euler-Verfahren
    fi_Rue = zeros(1,length(t3));
    %Trapezregel
    fi_tra = zeros(1,length(t3));
    fi_ab2 = zeros(1,length(t3));
    fi2 = allgemeine_fun(t3(1:2),0,0.5);
    fi_ab2(2) = fi2(2);
    fi_am3 = fi_ab2;
    fi_bdf2 = fi_ab2;
    for i = 1:length(t3)-1
       [LHS,RHS] = OST(0,dt3,M,[B,B],[C(t3(i+1)),C(t3(i))],fi_vor(i));
       fi_vor(i+1) = RHS/LHS;
       [LHS,RHS] = OST(1,dt3,M,[B,B],[C(t3(i+1)),C(t3(i))],fi_Rue(i));
       fi_Rue(i+1) = RHS/LHS;
       [LHS,RHS] = OST(0.5,dt3,M,[B,B],[C(t3(i+1)),C(t3(i))],fi_tra(i));
       fi_tra(i+1) = RHS/LHS;
       if i >= 2
            [LHS,RHS] = AB2(dt3,M,[B,B],[C(t3(i)),C(t3(i-1))],[fi_ab2(i),fi_ab2(i-1)]);
            fi_ab2(i+1) = RHS/LHS;
            [LHS,RHS] = AM3(dt3,M,[B,B,B],[C(t3(i+1)),C(t3(i)),C(t3(i-1))],[fi_am3(i),fi_am3(i-1)]);
            fi_am3(i+1) = RHS/LHS;
            [LHS,RHS] = BDF2(dt3,M,B,C(t3(i+1)),[fi_bdf2(i),fi_bdf2(i-1)]);
            fi_bdf2(i+1) = RHS/LHS;
       end
    end
    figure();
    plot(t3,fi_vor,'linewidth',1);
    hold on;
    plot(t3,fi_Rue,'linewidth',1);
    hold on;
    plot(t3,fi_tra,'linewidth',1);
    hold on;
    plot(t3,fi_ab2,'linewidth',1);
    hold on;
    plot(t3,fi_am3,'linewidth',1);
    hold on;
    plot(t3,fi_bdf2,'linewidth',1);
    hold on;
    plot([0:0.05:2],fi_ex,'k--','linewidth',1);
    legend('Euler Vorwaerts','Euler Ruekwaerts','Trapez','AB2','AM3','BDF2','exakt','location','northwest');
    title('Lösung Mit Zeitschrittlänge: 0.4','FontWeight','bold')
    ylim([0,9e-3]);
    xlabel('t');
    ylabel('\phi(t)');
end
%% 
function y = exakte(t)
    y = exp(-5*t).*(t.^2 - 2*t+2)-2*exp(-6*t);
end
function c = Ct(t)
    c = t^2*exp(-5*t);
end
function f = derivf(t,fi)
    f = t^2*exp(-5*t)-6*fi;
end
function fi = allgemeine_fun(t,fi0,theta)
    f = @derivf;
    dt = t(2)-t(1);
    fi = zeros(1,length(t));
    fi(1) = fi0;
    for i = 1:length(t)-1
        fi(i+1) = 1/(1 + 6*theta*dt)* (fi(i)+theta * dt *( t(i+1) ^2*exp(-5*t(i+1)))+(1-theta)*dt*f(t(i),fi(i)));
    end
end