function val = linquadref(xi,eta)
    val = [1/4*(1-xi)*(1-eta);
           1/4*(1+xi)*(1-eta);
           1/4*(1+xi)*(1+eta);
           1/4*(1-xi)*(1+eta)];
end