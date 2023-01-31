function gaussw = gw(n)
    if n == 1
        gaussw = 2;
    elseif n == 2
        gaussw = [1 1];
    elseif n == 3
        gaussw = [5/9 8/9 5/9];
    end
end