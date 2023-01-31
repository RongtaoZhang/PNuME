function gaussx = gx2dref(n)
    gaussx = zeros(n*n,2);
    k = 1;
    x = gx(n);
    for i = 1:n
        for j = 1:n
            gaussx(k,:) = [x(i),x(j)];
            k = k+1;
        end
    end
%         case 1
%             gaussx = [0.0, 0.0];
%         case 2
%             gaussx = [-a, -a; -a, a; a, -a; a, a];
%         case 3
%             gaussx = [-b, -b; -b, 0; -b, b; 0, -b; 0, 0; 0, b; b, -b; b, 0; b, b];
end