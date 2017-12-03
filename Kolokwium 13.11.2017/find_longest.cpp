
// [ 7 3 3 4 4 7 8 7 3 4 ]

std::vector<double> v;

std::pair<size_t, size_t> find_longest(std::vector<double> v)
{
	double avg = std::avg(v.begin(), v.end());

	size_t max_start_idx = 0;
	size_t max_end_idx = 0;
	size_t max_length = 1;

	size_t current_start_id = 0;
	size_t current_end_idx = 0;
	size_t current_length = 1;

	for(int i = 0; i < v.length(); i++) {
		// Value bigger than average
		if ( v[i] >= avg ) {			
			if ( current_length > max_length ) {
				max_start_idx 		= current_start_id;
				max_end_idx 		= current_end_idx;
				max_length 			= current_length;
			}

			if ( i < v.length() ) {
				current_start_id 	= i + 1;
				current_end_idx 	= i + 1;
				current_length 		= 1;
			}
		} else {				// In other case
			current_end_idx = i;
			current_length++;
		}
	}

	return std::make_pair( max_start_idx, max_end_idx );
}