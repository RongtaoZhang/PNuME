0%%
clc;
clear all;
addpath('../m-files');
format long;
%% 
r = 0.02;
b = 0.3;
h = 0.3;
elements = [1,2,6,5;2,3,7,6;3,4,8,7;
            5,6,10,9;6,7,11,10;7,12,14,11;7,8,13,12;
            9,10,16,15;10,11,17,16;11,14,18,17];
dbc=[1 600;2 600;3 600;4 600; 12 300;13 300;14 300;18 300];
[T,nodes] = result(r,b,h,elements,dbc);
while T(15)>450||T(16)>450||T(17)>450||T(18)>450
     r = r+0.01;
     [T,nodes] = result(r,b,h,elements,dbc);
 end
% [elemat,elevec] = evaluate_stat([0,0;1,0;1,2;0,2],gx2dref(3),gw2dref(3))
% [sysmat,rhs] = assemble([1,2,3,4;5,6,7,8;9,10,11,12;13,14,15,16],[17,18,19,20],eye(5,5),ones(5,1),[5,3,1,2])
% [sysmat,rhs] = assignDBC([12,12,10,0,9;15,17,14,0,13;7,8,7,0,5;0,0,0,1,0;3,4,2,0,2],[20;21;19;1;18],[2,-7;5,-2])
T
quadplot(nodes,elements,T)
shading interp; grid on
colormap(hot);
colorbar
disp(r);
%% 
function [T,nodes] =result(r,b,h,elements,dbc)
    nodes = [0,0;
             b/3,0;
             2*b/3,0;
             b,0;
             0,h/3;
             b/3,h/3;
             2/3*b,h/3;
             b,h/3;
             0,2/3*h;
             b/3,2/3*h;
             2/3*b,2/3*h;
             b-r*sin(pi/6),h-r*cos(pi/6);
             b,h-r;
             b-r*cos(pi/6),h-r*sin(pi/6);
             0,h;
             b/3,h;
             b/2,h;
             b-r,h
            ];
    sysmat=zeros(18,18);%length(nodes) * length(nodes)
    rhs=zeros(18,1); %length(nodes)
    %% 
    for n=1:size(elements,1)
        %一共有size(elements,1)个elements，这里是10个
        node = nodes(elements(n,:),:);
        [elemat,elevec]=evaluate_stat(node,gx2dref(2),gw2dref(2));
        %这里是把每个element对应的点代入进行运算
        [sysmat,rhs]=assemble(elemat,elevec,sysmat,rhs,elements(n,:));
        %每个element在local对应的是1 2 3 4个点，但在global就不是了，看给的图就明白了，直接给出了每个element的四个点在global对应的点编号。
    end
    [sysmat,rhs]=assignDBC(sysmat,rhs,dbc);
    T=sysmat\rhs;
    %mldivide(sysmat,rhs)
end

