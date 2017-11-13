% Date: 13.11.2017
% Author: Micha³ Kleszczyñski

function most_common = most_common( processed_data )
    % Powinno byæ [ ~, max_idx ] = max(  processed_data(:, 2) );
    % ¯eby zniwelowaæ niepotrzebne u¿ycie pierwszego parametru
    % Ale na kartce napisa³em ju¿ tak wiêc trzymajmy siê tej wersji

    [ max_cnt, max_idx ] = max( processed_data(:, 2) );
    
    most_common =  processed_data( max_idx, 1 );
end