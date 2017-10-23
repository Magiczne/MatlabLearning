function [s, a] = sum_and_avg_when_can_divide_by_3(data)
    divisible_by_3 = data( rem(data, 3) == 0 );
    
    s = sum(divisible_by_3);
    a = mean(divisible_by_3);
    