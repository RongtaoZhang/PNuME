function gaussw = gw2dref(n)
    gaussw = zeros(n*n,1);
    w = gw(n);
    k=1;
    for i  = 1:n
        for j = 1:n
            gaussw(k) = w(i) * w(j);
            k=k+1;
        end
    end
 
%     switch n
%         case 1
%             gaussw = [4.0];
%         case 2
%             gaussw = [1.0; 1.0; 1.0; 1.0];
%         case 3
%             gaussw = [0.308642; 0.493827; 0.308642; 0.493827; 0.790123; 0.493827; 0.308642; 0.493827; 0.308642];
%     end
end