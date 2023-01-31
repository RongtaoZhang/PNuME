function [output] = factorial(n)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
if n <= 1
    output = 1;
else 
    output = n * factorial(n-1);
end
end

