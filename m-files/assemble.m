function [sysmat,rhs] = assemble(elemat,elerhs,sysmat,rhs,ele)
    for i = 1:4
        for j = 1:4
            sysmat(ele(i),ele(j)) = sysmat(ele(i),ele(j)) +elemat(i,j);
        end
        rhs(ele(i)) = rhs(ele(i))+elerhs(i);
    end
end