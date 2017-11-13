% Date: 13.11.2017
% Author: Micha³ Kleszczyñski

function [ data_start, data_end ] = find_longest( data )
    data_avg = mean( data );

    max_start_idx = 1;
    max_end_idx = 1;
    max_length = 1;

    current_start_idx = 1;
    current_end_idx = 1;
    current_length = 1;
    
    for i = 1:length( data )
    	% If value if bigger than average
    	if data( i ) >= data_avg
    		% If current data is longer than the maximum
     		if current_length > max_length
     			max_start_idx=current_start_idx;
                max_end_idx=current_end_idx;
     			max_length=current_length;
            end
            
            % Set current position to the next value
            if i < length( data )
                current_start_idx=i+1;
                current_end_idx=i+1;
                current_length=1;
            end
            
    	else 	% In every other case
    		current_end_idx=i;
    		current_length=current_length+1;
    	end
    end
    
    data_start = max_start_idx;
    data_end = max_end_idx;
end