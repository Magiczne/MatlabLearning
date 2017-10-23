function [] = find_roots(intStart, intEnd)
    syms x
    f(x) = (x - 5)*(x - sqrt(5));
    
    if f(intStart) == 0
        disp(intStart)
        return
    end
    
    if f(intEnd) == 0
        disp(intEnd)
        return
    end
    
    if intStart * intEnd < 0
        middle = intStart + (intEnd - intStart) / 2;
        
        if abs(f(middle)) < 0.000001 
            disp(middle)
            return
        end
        
        while abs(f(middle)) > 0.000001
            if f(intStart) * f(middle) < 0
                intEnd = middle;
            else
                intStart = middle;
            end
            
            middle = intStart + (intEnd - intStart) / 2;
        end
        
        disp(middle);
    else
        disp('Przedzial jest za duzy')
        return
    end