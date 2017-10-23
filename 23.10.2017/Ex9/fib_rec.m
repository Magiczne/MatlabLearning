function [ ret ] = fib_rec(cnt)
    if cnt < 0 
        disp('Invalid argument cnt')
        return
    end

    if cnt == 0
        ret = 0;
        return
    elseif cnt == 1
        ret = 1;
        return
    else
        ret = fib_rec(cnt - 1) + fib_rec(cnt - 2);
    end
        