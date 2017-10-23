function [ z1, z2 ] = func3(x, y)
    if x > 0
       z1 = x^3 + 3*x*y^2;
    else
        z1 = x^3 - 3*x*y^2;
    end
   
    if x > 0 && y > 0
        z2 = -x^3 - 12*x*y; 
    else
        z2 = x^3 + 12*x*y;
    end
    