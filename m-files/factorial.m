function [output] = factorial(n)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if n <= 1
    output = 1;
else 
    output = n * factorial(n-1);
end
end

