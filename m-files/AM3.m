function [LHS,RHS] = AM3(timestep,M,B,C,sol)
    LHS = M-5*timestep/12*B(1);
    RHS = M*sol(1)+timestep/12*(5*C(1)+8*(B(2)*sol(1)+C(2))-(B(3)*sol(2)+C(3)));
end