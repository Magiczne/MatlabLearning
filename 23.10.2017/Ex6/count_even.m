function [ ret ] = count_even(data)
    ret = length(find(rem(data, 2) == 0));