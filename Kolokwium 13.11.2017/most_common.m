% Date: 13.11.2017
% Author: Micha� Kleszczy�ski

function most_common = most_common( processed_data )
    % Powinno by� [ ~, max_idx ] = max(  processed_data(:, 2) );
    % �eby zniwelowa� niepotrzebne u�ycie pierwszego parametru
    % Ale na kartce napisa�em ju� tak wi�c trzymajmy si� tej wersji

    [ max_cnt, max_idx ] = max( processed_data(:, 2) );
    
    most_common =  processed_data( max_idx, 1 );
end