clc;
clear;
a = rand(1000,1);
if a(1)>=0.5
    disp('a1 >= 0.5');
else
    disp('a1 < 0.5');
end
n05 = 0;
for i=1:5
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
