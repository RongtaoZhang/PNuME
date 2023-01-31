function [J,detJ,invJ] = getJacobian(nodes, xi, eta)
    J = nodes' * linquadderivref(xi,eta);
    detJ = det(J);
    invJ = inv(J);
end

