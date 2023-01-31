function deriv = linquadderivref(xi,eta)
    deriv = [-1/4*(1-eta),-1/4*(1-xi);
              1/4*(1-eta),-1/4*(1+xi);
              1/4*(1+eta), 1/4*(1+xi);
             -1/4*(1+eta), 1/4*(1-xi)];
end