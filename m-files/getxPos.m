function x = getxPos(nodes, xi, eta)
    Ni = linquadref(xi,eta);
    x = nodes'* Ni;
end