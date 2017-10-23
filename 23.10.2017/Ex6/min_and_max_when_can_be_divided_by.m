function [dMin, dMax] = min_and_max_when_can_be_divided_by(data, divider)
    divisible_by_divider = data( rem(data, divider) == 0 );
    
    dMin = min(divisible_by_divider);
    dMax = max(divisible_by_divider);