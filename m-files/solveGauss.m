function x = solveGauss(A,b)
    for i = 1:length(A)-1
        for j = i+1:length(A)
           m = A(j,i)/A(i,i);
           A(j,:) = A(j,:) - m*A(i,:);
           b(j) = b(j) - m*b(i);
        end
    end
    
    x = zeros(length(A),1);
    x(length(A)) = b(length(A))/A(length(A),length(A));
    for i = length(A)-1:-1:1
        up = b(i);
        for j = i+1:length(A)
            up = up - A(i,j)*x(j);
        end
        x(i) = up/A(i,i);
    end
end