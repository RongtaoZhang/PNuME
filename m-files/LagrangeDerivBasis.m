function wert_dbasis = LagrangeDerivBasis(x,n,i,x_node)
    wert_dbasis = 0;
    for m = 1:n+1
       if m ~= i 
           L = 1;
           for k = 1:n+1
              if k~=i && k~= m
                 L = L * (x-x_node(k))/(x_node(i)-x_node(k)); 
              end
           end
           wert_dbasis = wert_dbasis+1/(x_node(i)-x_node(m))*L;
%            fprintf("wert_db = %f\n",wert_dbasis);
       end
    end
end