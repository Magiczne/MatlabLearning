function [ ret ] = ciung(cnt)
    if cnt == 1
        ret = 1;
        return
    else
        ret = -ciung(cnt - 1) * cnt;
    end