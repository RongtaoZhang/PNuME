function [LHS,RHS] = OST(theta,timestep,M,B,C,sol)
if size(M) == 1
    LHS = M - theta * timestep * B(1);
    RHS = (M + (1 - theta) * timestep * B(2)) * sol + timestep * (theta * C(1) + (1 - theta) * C(2));
else
    LHS = M - theta * timestep * B;
    RHS = (M + (1 - theta) * timestep * B) * sol + timestep * (theta * C + (1 - theta) * C);
end