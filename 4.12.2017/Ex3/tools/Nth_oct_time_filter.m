function [fc_out, SP_levels, SP_peak_levels, SP_bands]=Nth_oct_time_filter(SP, Fs, num_x_filter, N, min_f, max_f, sensor, settling_time, filter_program, resample_filter)
% % Nth_oct_time_filter: Calculates the Nth octave center frequencies, sound levels, peak levels, and time records
% %
% % Syntax:
% %
% % [fc_out, SP_levels, SP_peak_levels, SP_bands]=Nth_oct_time_filter(SP, Fs, num_x_filter, N, min_f, max_f, sensor, settling_time, filter_program, resample_filter);
% %
% % **********************************************************************
% %
% % Description
% %
% % This program applies Nth octave band filters to the input time record.  
% % The program outputs the center frequency bands, the time average rms 
% % values, the peak values, and band filtered time records for each 
% % Nth octave band respectively.  
% % 
% %
% % This program applies Nth octave band filters to the input time record.
% % The program outputs the center frequency bands, the time average rms
% % values, the peak values, and band filtered time records for each
% % Nth octave band respectively.
% %
% % Nth_octdsgn computes the filter coefficients using a 3rd order
% % butterworth filter for an Nth octave band filter according to
% % ANSI S1.11.  
% % 
% % To optimize filter stability, this program uses iterative downsampling
% % to make the sampling rate reasonable before applying the third octave
% % Butterworth filters.  
% % 
% % There are two options for the downsampling filters to optimize
% % performance for continuous signals or for impulsive signals. 
% % For continuous noise the time domain does not have significant 
% % impulses; however, for impulsive time records there are often very
% % large impulses with distinctive peaks.  
% % 
% % There are two antialiasing filters and interpolation schemes available.
% % The first program is the built-in Matlab "resample" progam which
% % uses a Kaiser window fir filter for antialising and uses an unknown 
% % interpolation method.  The second program available for downsampling 
% % is bessel_down_sample which uses a Bessel filter for antialiasing 
% % and uses interp with the cubic spline option for interpolation.  
% % 
% % The resample function has good antialising up to the Nyquist frequency;
% % however, it has significant ringing effect when there are impulses.  
% % The bessel_down_sample function has good antialising; however, there is
% % excessive attenuation near the Nyquist frequency.  
% % The bessel_down_sample function experiences no ringing due to impulses
% % so it is very useful for peak estimation.  
% % 
% % 
% % To avoid phase shift, the filtfilt Matlab program can
% % be used to implement the one-Nth octave filters.  
% % 
% % The input and output variables are described in more detail in the
% % sections below respectively.  
% % 
% % **********************************************************************
% % 
% % Input Variables
% %
% % SP=randn(10, 50000);
% %                     % (Pa) is the time record of the sound pressure
% %                     % default is SP=rand(1, 50000);
% %
% % Fs=50000;           % (Hz) is the sampling rate of the time record.
% %                     % default is Fs=50000; Hz.
% %
% % num_x_filter=2;     % This is the number of times the time record 
% %                     % should be filtered.  
% %                     % default is num_x_filter=2;
% % 
% % N=3;                % is the number of frequency bands per octave.  
% %                     % Can be any number > 0.  
% %                     % Default is 3 for third octave bands.  
% % 
% % min_f=20;           % is the minimum frequency band to calculate (Hz).
% %                     % Must be graeater than 0.  
% %                     % default is 20;
% % 
% % max_f=20000;        % max_f is the maximum frequency band to calculate
% %                     % (Hz).  Must be graeater than 0.  
% %                     % default is 20000;
% %
% % sensor=1;           % Constant integer input for selecting the sensor type
% %                     % 1 is for acoustic microphone Pref=20E-6 (Pa)
% %                     %
% %                     % 2 is for accelerometer output is in same
% %                     %   units as the input (m/s^2)
% %                     %
% %                     % 3 generic sensor multiply by 1: output is in same
% %                     %   units as the input
% %                     %
% %                     % default is sensor=1; For a microphone
% % 
% % settling_time=0.1;  % (seconds) Time requiered for the filter to settle 
% %                     % usually 0.1 seconds or less.  
% %                     % This quantity is usually frequency dependent.  
% %
% % filter_program=1;   % 1 is for using the filter progam otherwise the
% %                     % filtfilt program is used.  
% %                     % filter.m runs faster and may settle 
% %                     % more quickly.    
% %                     % filtfilt.m is used to remove phase shift. 
% %                     % default is filter_program=1 using filter progam.
% % 
% % resample_filter=1;  % type of filter to use when resampling
% %                     % 1 resample function Kaiser window fir filter
% %                     % 2 Bessel filter
% %                     % otherwise resample function Kaiser window fir
% %                     % filter
% %                     % default is resample_filter=1; (Kaiser window)
% % 
% % 
% % **********************************************************************
% %
% % Output Variables
% %
% % fc_out          % (Hz) array of center frequencies
% %
% % SP_levels       % (dB)sound pressure levels for each mic channel
% %                 % and f or each frequency band
% % 
% % SP_peak_levels  % (dB) Maximum of the absolute value of the Peak
% %                 % levels and for each frequency band
% %
% % SP_bands        % Time record for each mic channel and for each
% %                 % frequency band after filtering
% %
% %
% % **********************************************************************
% %
%
% Example='1';
%
% % Compare the spectra of white noise, pink noise, and brown noise.  
% % 
% 
% x1 = spatialPattern([1,500000],0);    % white noise has a linearly
%                                       % increasing spectrum
%
% x2 = spatialPattern([1,500000],-1);   % pink noise has a constant
%                                       % spectrum
% 
% x3 = spatialPattern([1,500000],-2);   % brown noise has a linearly
%                                       % increasing spectra
%
% Fs=50000;         % (Hz) Sampling rate
%
% num_x_filter=2;   % Number of times to filter the data.  Minimum value is 1
%                   % typically a value of 2 to 10 at low
%                   % frequencies (Fc < 100), num_x_filter=10 has a
%                   % significant phase shift when using filter.
% 
% N=3;              % number of bands per octave.  
% 
% min_f=20;         % is the minimum frequency band to calculate (Hz).   
% 
% max_f=20000;       % is the maximum frequency band to calculate (Hz).  
%
% sensor=1;         % acoustic microphone
%                   % output is in dB
% 
% settling_time=1;  % (seconds) Time requiered for the filter to settle 
%                   % usually 0.1 seconds or less.  
%                   % This quantity is usually frequency dependent.  
%
% filter_program=1; % 1 is for using the filter progam otherwise the
%                   % filtfilt program is used.  
%                   % default is filter_program=1 using filter progam.
% 
% resample_filter=1;
% 
% [fc_out1, SP_levels1]=Nth_oct_time_filter(x1, Fs, num_x_filter, N, min_f, max_f, sensor, settling_time, filter_program, resample_filter);
% [fc_out2, SP_levels2]=Nth_oct_time_filter(x2, Fs, num_x_filter, N, min_f, max_f, sensor, settling_time, filter_program, resample_filter);
% [fc_out3, SP_levels3]=Nth_oct_time_filter(x3, Fs, num_x_filter, N, min_f, max_f, sensor, settling_time, filter_program, resample_filter);
%
% % Plot the results
% figure(1); 
% semilogx(fc_out1, SP_levels1, 'color', [1 1 1],         'linewidth', 2,                    'marker', 's', 'MarkerSize', 8);
% hold on;
% semilogx(fc_out2, SP_levels2, 'color', [1 0.6 0.784],   'linewidth', 2, 'linestyle', '--', 'marker', 'o', 'MarkerSize', 8);
% semilogx(fc_out3, SP_levels3, 'color', [0.682 0.467 0], 'linewidth', 2, 'linestyle', ':',  'marker', 'x', 'MarkerSize', 12);
% set(gca, 'color', 0.7*[1 1 1]);
% legend({'White Noise', 'Pink Noise', 'Brown Noise'}, 'location', 'SouthEast');
% xlabel('Frequency Hz', 'Fontsize', 28);
% ylabel('Sound Pressure Level (dB ref. 20 \mu Pa)', 'Fontsize', 28);
% title('Classical Third Octave Band Spectra', 'Fontsize', 40);
% set(gca, 'Fontsize', 20);
% 
% 
% % **********************************************************************
% % 
% % References
% % 
% % 1)  ANSI S1.11-1986 American National Stadard Specification for 
% %                     Octave-Band and Fractional-Octave-Band Analog 
% %                     and Digital Filters.
% % 
% % 
% % **********************************************************************
% % 
% % Subprograms
% %
% % This program requires the Matlab Signal Processing Toolbox
% % This program is based on the Octave Toolbox	by Christophe Couvreur
% % Matlab Central File Exchange ID 69
% % 
% % 
% % List of Dependent Subprograms for 
% % Nth_oct_time_filter
% % 
% % FEX ID# is the File ID on the Matlab Central File Exchange
% % 
% % 
% % Program Name   Author   FEX ID#
% %  1) bessel_antialias		Edward L. Zechmann			
% %  2) bessel_digital		Edward L. Zechmann			
% %  3) bessel_down_sample		Edward L. Zechmann			
% %  4) convert_double		Edward L. Zechmann			
% %  5) fastlts		Peter J. Rousseeuw		NA	
% %  6) fastmcd		Peter J. Rousseeuw		NA	
% %  7) filter_settling_data3		Edward L. Zechmann			
% %  8) geospace		Edward L. Zechmann			
% %  9) match_height_and_slopes2		Edward L. Zechmann			
% % 10) moving		Aslak Grinsted		8251	
% % 11) nth_freq_band		Edward L. Zechmann			
% % 12) Nth_oct_time_filter2		Edward L. Zechmann			
% % 13) Nth_octdsgn		Edward L. Zechmann			
% % 14) remove_filter_settling_data		Edward L. Zechmann			
% % 15) resample_interp3		Edward L. Zechmann			
% % 16) rmean		Edward L. Zechmann			
% % 17) rms_val		Edward L. Zechmann			
% % 18) sd_round		Edward L. Zechmann			
% % 19) sub_mean		Edward L. Zechmann	
% % 
% % 
% %
% % **********************************************************************
% % 
% % Program was written by Edward L. Zechmann
% % 
% %     date  7 December    2008
% % 
% % modified  8 December    2008  Updated Comments
% % 
% % modified 10 December    2008  Updated Comments
% % 
% % modified 16 December    2008    Generlaized program to Nth Octave Bands
% % 
% % modified 22 December    2008    Updated Comments.  Finished Upgrade
% % 
% % modified  5 January     2009    Added sub_mean to remove running
% %                                 average using a time constant at one- 
% %                                 half the lowest center frequency.
% %                                 
% %        
% % modified 26 March       2009    Changed progam into a wrapper for 
% %                                 Nth_oct_time_filter2
% %
% % modified 4 August       2010    Updated Comments
% %
% % modified 15 March       2012    Changed the range_size to 8 and the 
% %                                 downsample_factor to 20 to improve 
% %                                 accuaracy of low frueqnecies when 
% %                                 processing short time records.  
% % 
% % **********************************************************************
% % 
% % Please feel free to modify this code.
% %
% % See Also: Nth_oct_time_filter2, Nth_octdsgn, nth_freq_band, octave, resample, ACdsgn, filter, filtfilt
% %

if (nargin < 1 || isempty(SP)) || ~isnumeric(SP)
    SP=rand(1, 50000);
end

% Make the data have the correct data type and size
[SP]=convert_double(SP);

[num_mics, num_pts]=size(SP);

if num_mics > num_pts
    SP=SP';
    [num_mics num_pts]=size(SP);
end

if (nargin < 2 || isempty(Fs)) || ~isnumeric(Fs)
    Fs=50000;
end

if (nargin < 3 || isempty(num_x_filter)) || ~isnumeric(num_x_filter)
    num_x_filter=2;
end

if (nargin < 4 || (isempty(N)) || ~isnumeric(N))
    N=20;
end

if (nargin < 5 || isempty(min_f)) || (logical(min_f < 0) || ~isnumeric(min_f))
    min_f=20;
end

if (nargin < 6 || isempty(max_f)) || (logical(max_f < 0) || ~isnumeric(max_f))
    max_f=20000;
end

if (nargin < 7 || isempty(sensor)) || ~isnumeric(sensor)
    sensor=1;
end

if (nargin < 8 || isempty(settling_time)) || ~isnumeric(settling_time)
    settling_time=0.1;
end

if (nargin < 9 || (isempty(filter_program)) || ~isnumeric(filter_program))
    filter_program=1;
end

if (nargin < 10 || isempty(resample_filter)) || ~isnumeric(resample_filter)
    resample_filter=1;
end

if ~isequal(resample_filter, 2)
    resample_filter=1;
end


% get the third octave band center frequencies
[fc] = nth_freq_band(N, min_f, max_f, 0);




% Call Nth_oct_time_filter2
[fc_out, SP_levels, SP_peak_levels, SP_bands]=Nth_oct_time_filter2(SP, Fs, num_x_filter, N, fc, sensor, settling_time, filter_program, resample_filter);

