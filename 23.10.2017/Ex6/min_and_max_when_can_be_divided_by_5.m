function [dMin, dMax] = min_and_max_when_can_be_divided_by_5(data)
    divisible_by_5 = data( rem(data, 5) == 0 );
    
    dMin = min(divisible_by_5);
    dMax = max(divisible_by_5);