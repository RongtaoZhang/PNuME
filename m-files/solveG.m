function x = solveG(A,b,x0,rtol,iteramax)
    k = 0;
    r = b - A * x0;
    x = x0;
    while k < iteramax && norm(r) > rtol
        alpha = r'*r/(r'*A*r);
        x = x + alpha * r;
        r = b - A * x;
        k = k + 1;
    end
    k
end