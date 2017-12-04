function [xw, xp, xb, SPLw1, SPLp1, SPLb1, SPLw2, SPLp2, SPLb2, f ]=Test_Nth_octave_Band2(Fs, td, N, min_f, max_f, num_x_filter, sensor, settling_time, filter_program, resample_filter)
% % Test_third_oct_filters: Tests Nth octave filters with white, pink, and brown noise. 
% %  
% % Syntax:
% % 
% % [xw, xp, xb, SPLw1, SPLp1, SPLb1, SPLw2, SPLp2, SPLb2, f ]=Test_Nth_octave_Band2(Fs, td, N, min_f, max_f, num_x_filter, sensor, settling_time, filter_program, resample_filter);
% % 
% % **********************************************************************
% % 
% % Description 
% % 
% % Program tests the spectra of the Nth octave band filters for
% % white, pink, and brown noise. 
% % 
% % A figure showing the three Nth octave band spectra is output.  
% % Additionally the white, pink, and brown noise spectra are output 
% % along with the frequency array.  
% % 
% % The input and output variables are described in more detail in the
% % sections below respectively.  
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
% % The input and output variables are described in more detail in the
% % respective sections below.
% %
% % 
% % **********************************************************************
% % 
% % Input Variables
% % 
% % Fs=50000;           % (Hz) sampling rate.
% %                     % default is Fs=50000;
% % 
% % td=10;              % (seconds) time duration of test signal.
% %                     % There are three test signal white, pink, and 
% %                     % brown noise.
% %                     % default is td=10;
% % 
% % N=3;                % is the number of frequency bands per octave.  
% %                     % Can be any number > 0.  
% %                     % Default is N=3 for third octave bands.  
% % 
% % min_f=20;           % is the minimum frequency band to calculate (Hz).
% %                     % Must be graeater than 0.  
% %                     % default is min_f=20; 
% % 
% % max_f=20000;        % max_f is the maximum frequency band to calculate
% %                     % (Hz).  Must be graeater than 0.  
% %                     % default is max_f=20000;
% %
% %
% % num_x_filter=2;     % This is the number of times the time record 
% %                     % should be filtered.  
% %                     % default is num_x_filter=2;
% % 
% % sensor=1;           % acoustic microphone
% %                     % output is in dB
% %                     % default is sensor=1;
% % 
% % settling_time=1;    % (seconds) Time requiered for the filter to settle 
% %                     % usually 0.1 seconds or less.  
% %                     % This quantity is usually frequency dependent.  
% %                     % settling_time=1; 
% % 
% % filter_program=1;   % 1 is for using the filter progam otherwise the
% %                     % filtfilt program is used.  
% %                     % filter.m runs faster and may settle 
% %                     % more quickly.    
% %                     % filtfilt.m is used to remove phase shift. 
% %                     % default is filter_program=1,  use filter progam.
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
% % xw is the white noise output time record.   
% % 
% % xp is the pink noise output time record.     
% % 
% % xb is the brown noise output time record.    
% % 
% % SPLw1 is the white noise output spectra from Nth_oct_time_filter. 
% % 
% % SPLp1 is the pink noise output spectra from Nth_oct_time_filter. 
% % 
% % SPLb1 is the brown noise output spectra from Nth_oct_time_filter. 
% % 
% % SPLw2 is the white noise output spectra from Nth_oct_time_filter2. 
% % 
% % SPLp2 is the pink noise output spectra from Nth_oct_time_filter. 
% % 
% % SPLb2 is the brown noise output spectra from Nth_oct_time_filter. 
% % 
% % f is the Nth octave band output frequency spectra.
% % 
% % 
% % **********************************************************************
% 
%
% Example='1';
% 
% % Try running the program with no input variables and no output
% % variables.
% % 
% % The brown noise should drop at a rate of 3 dB per octave.
% % The white noise should increase at 3 dB per octave.
% % The pink noise should be constant.
% 
% Test_Nth_octave_Band2;
% 
% % **********************************************************************
% % 
% % References Standards
% % 
% % ANSI S1.11-1986 Specifications for Octave-band and fractional-octave band
% % analog and digital filters.  
% % 
% % **********************************************************************
% % 
% % 
% % 
% % List of Dependent Subprograms for 
% % Test_Nth_octave_Band2
% % 
% % FEX ID# is the File ID on the Matlab Central File Exchange
% % 
% % 
% % Program Name   Author   FEX ID#
% %  1) bessel_antialias		Edward L. Zechmann			
% %  2) bessel_digital		Edward L. Zechmann			
% %  3) bessel_down_sample		Edward L. Zechmann			
% %  4) convert_double		Edward L. Zechmann			
% %  5) filter_settling_data3		Edward L. Zechmann			
% %  6) geospace		Edward L. Zechmann			
% %  7) LMSloc		Alexandros Leontitsis		801	
% %  8) match_height_and_slopes2		Edward L. Zechmann			
% %  9) moving		Aslak Grinsted		8251	
% % 10) nth_freq_band		Edward L. Zechmann			
% % 11) Nth_oct_time_filter		Edward L. Zechmann			
% % 12) Nth_oct_time_filter2		Edward L. Zechmann			
% % 13) Nth_octdsgn		Edward L. Zechmann			
% % 14) remove_filter_settling_data		Edward L. Zechmann			
% % 15) resample_interp3		Edward L. Zechmann			
% % 16) rms_val		Edward L. Zechmann			
% % 17) sd_round		Edward L. Zechmann			
% % 18) spatialPattern		Jon Yearsley		5091	
% % 19) sub_mean		Edward L. Zechmann			
% % 
% % **********************************************************************
% %
% % Program was written by Edward L. Zechmann
% % 
% %     date 22 December    2008    Created program
% % 
% % modified  7 January     2008    Update Comments
% %
% % modified  4 August      2010    Updated Comments
% %
% % 
% % **********************************************************************
% %
% % 
% % Please feel free to modify this code.
% % 
% % See Also: Nth_oct_time_filter, Nth_oct_time_filter2, octave, resample, filter, filtfilt
% % 
 

if (nargin < 1 || isempty(Fs)) || ~isnumeric(Fs)
    Fs=3;
end

if (nargin < 2 || isempty(td)) || ~isnumeric(td)
    td=10;
end

if (nargin < 3 || isempty(N)) || ~isnumeric(N)
    N=3;
end

if (nargin < 4 || isempty(min_f)) || (logical(min_f < 0) || ~isnumeric(min_f))
    min_f=20;
end

if (nargin < 5 || isempty(max_f)) || (logical(max_f < 0) || ~isnumeric(max_f))
    max_f=20000;
end

if (nargin < 6 || isempty(num_x_filter)) || ~isnumeric(num_x_filter) 
    num_x_filter=2;
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



% Calculate the number of points in the time records 
num_pts=ceil(Fs*td);

if num_pts < 100
    num_pts=100;
end


% Compare the spectra of white noise, pink noise, and brown noise.  


% % **********************************************************************
%
% Create the time records for the three type of noise
%
xw = spatialPattern([1,num_pts],0);     % white noise has a linearly
                                        % increasing spectrum

xp = spatialPattern([1,num_pts],-1);    % pink noise has a constant
                                        % spectrum

xb = spatialPattern([1,num_pts],-2);    % brown noise has a linearly
                                        % decreasing spectra

                                
% % **********************************************************************
% 
% % Compute the Nth octave band spectra for the Nth_oct_time_filter
% 
[f, SPLw1]=Nth_oct_time_filter(xw, Fs, num_x_filter, N, min_f, max_f, sensor, settling_time, filter_program, resample_filter);
[f, SPLp1]=Nth_oct_time_filter(xp, Fs, num_x_filter, N, min_f, max_f, sensor, settling_time, filter_program, resample_filter);
[f, SPLb1]=Nth_oct_time_filter(xb, Fs, num_x_filter, N, min_f, max_f, sensor, settling_time, filter_program, resample_filter);


% % **********************************************************************
% 
% % Plot the results for the Nth_oct_time_filter
% 
figure(1); 
semilogx(f, SPLw1, 'color', [1 1 1],         'linewidth', 2,                    'marker', 's', 'MarkerSize', 8);
hold on;
semilogx(f, SPLp1, 'color', [1 0.6 0.784],   'linewidth', 2, 'linestyle', '--', 'marker', 'o', 'MarkerSize', 8);
semilogx(f, SPLb1, 'color', [0.682 0.467 0], 'linewidth', 2, 'linestyle', ':',  'marker', 'x', 'MarkerSize', 12);
set(gca, 'color', 0.7*[1 1 1]);
legend({'White Noise', 'Pink Noise', 'Brown Noise'}, 'location', 'SouthEast');
xlabel('Frequency Hz', 'Fontsize', 28);
ylabel('Sound Pressure Level (dB ref. 20 \mu Pa)', 'Fontsize', 28);
title({'Nth oct time filter', 'Classical Third Octave Band Spectra'}, 'Fontsize', 40);
set(gca, 'Fontsize', 20);


fc=f;
% % **********************************************************************
% 
% % Compute the Nth octave band spectra for the Nth_oct_time_filter2
% 
[f, SPLw2]=Nth_oct_time_filter2(xw, Fs, num_x_filter, N, fc, sensor, settling_time, filter_program, resample_filter);
[f, SPLp2]=Nth_oct_time_filter2(xp, Fs, num_x_filter, N, fc, sensor, settling_time, filter_program, resample_filter);
[f, SPLb2]=Nth_oct_time_filter2(xb, Fs, num_x_filter, N, fc, sensor, settling_time, filter_program, resample_filter);



% % **********************************************************************
% 
% % Plot the results for the Nth_oct_time_filter2
% 
figure(2); 
semilogx(f, SPLw2, 'color', [1 1 1],         'linewidth', 2,                    'marker', 's', 'MarkerSize', 8);
hold on;
semilogx(f, SPLp2, 'color', [1 0.6 0.784],   'linewidth', 2, 'linestyle', '--', 'marker', 'o', 'MarkerSize', 8);
semilogx(f, SPLb2, 'color', [0.682 0.467 0], 'linewidth', 2, 'linestyle', ':',  'marker', 'x', 'MarkerSize', 12);
set(gca, 'color', 0.7*[1 1 1]);
legend({'White Noise', 'Pink Noise', 'Brown Noise'}, 'location', 'SouthEast');
xlabel('Frequency Hz', 'Fontsize', 28);
ylabel('Sound Pressure Level (dB ref. 20 \mu Pa)', 'Fontsize', 28);
title({'Nth oct time filter2', 'Classical Third Octave Band Spectra'}, 'Fontsize', 40);
set(gca, 'Fontsize', 20);


