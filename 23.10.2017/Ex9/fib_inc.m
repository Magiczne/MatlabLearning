function [ ret ] = fib_inc(cnt)
    if cnt < 0 
        disp('Invalid argument cnt')
        return
    end
    
    if cnt == 0 
        ret = 0;
        return
    end
    
    if cnt == 1
        ret = 1;
        return
    end
    
    prevPrev = 0;
    prev = 1;
    result = 0;
    
    for i = 2:cnt
        result = prev + prevPrev;
        prevPrev = prev;
        prev = result;
    end
    
    ret = result;