function wert_poly = LagrangePolynom(x,n,x_node,f_node)
    wert_poly = 0;
    for i = 1:n+1
        Li = LagrangeBasis(x,n,i,x_node);
        wert_poly = wert_poly + Li*f_node(i);
    end
end