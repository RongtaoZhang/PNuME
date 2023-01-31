function x = solveCG(A,b,x0,rtol,itermax)
    r = b - A*x0;
    x= x0;
    p = r;
    k=0;
    while (norm(r)>rtol && k < itermax)
       v = A*p;
       alpha = r'* r / ( p' * v );
       x = x + alpha * p;
       a = norm(r);
       r = r - alpha * v;
       b = norm(r);
       beta = b/a;
       p = r + beta^2 * p;
       k = k+1;
    end
    k
end