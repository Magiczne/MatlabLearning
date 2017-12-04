function [SP_rms_levels_a, SP_peak_levels_a, SP_theo_peak_on, SP_theo_level_on]=Test_Nth_oct_filters1b(flag2, N, num_x_filter, filter_program, filename_out, Fsa, Fca, F_siga, resample_filter)
% % Test_third_oct_filters: Tests Nth octave filters with pure tones and tone bursts
% %  
% % Syntax:
% % 
% % [SP_rms_levels_a, SP_peak_levels_a, SP_theo_peak_on, SP_theo_level_on]=Test_Nth_oct_filters1b(flag2, N, num_x_filter, filter_program, filename_out, Fsa, Fca, F_siga, , resample_filter);
% % 
% % **********************************************************************
% % 
% % Description 
% % 
% % Program tests the accuracy of the Nth octave band filters with
% % pure tones and tone bursts.  For pure tones, the test signal consists 
% % of 200 full sinusoidal waves at specified frequencies.  
% % For impulsive noise, a tone burst with 7 full waves with a specified 
% % frequency and amplitude are used (see tone_burst.m)
% % 
% % Matlab data are output adn the data are also saved to a user 
% % specified file named with the input variable "filename_out".  
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
% % The are several input and output variables are they are described 
% % in detail in the respective sections below.   
% % 
% % 
% % **********************************************************************
% % 
% % Input Variables
% % 
% % flag2=0;            % Controls whether to use sinusiodal input or 
% %                     % the tone bursts.
% %                     % 0 is for testing sinusoids.
% %                     % 1 is for testing tone bursts (impulsive).
% %                     % 
% % 
% % N=3;                % is the number of frequency bands per octave.  
% %                     % Can be any number > 0.  
% %                     % Default is 3 for third octave bands.  
% % 
% % num_x_filter=2;     % This is the number of times the time record 
% %                     % should be filtered.  
% %                     % default is num_x_filter=2;
% %
% % filter_program=1;   % 1 is for using the filter progam otherwise the
% %                     % filtfilt program is used.  
% %                     % filter.m runs faster and may settle 
% %                     % more quickly.    
% %                     % filtfilt.m is used to remove phase shift. 
% %                     % default is filter_program=1 using filter progam.
% % 
% % filename_out='test_data'; 
% %                     % save the simulation results to a matlab data file.
% % 
% % Fsa=[50000, 100000];% (Hz) array of sampling rates
% % 
% % Fca=[100 1000 10000];
% %                     % (Hz) array of filter center frequencies
% % 
% % F_siga=[100 1000 10000];
% %                     % (Hz) array of signal frequencies 
% % 
% % 
% % 
% % **********************************************************************
% %
% % Output Variables
% % 
% % Each of the outputs is a three dimensional array of size
% % [num_sampling rates, num_signal frequencies, num_center frequencies]
% % 
% % SP_levels_a         % (dB) Measured sound pressure levels for each 
% %                     % frequency band 
% % 
% % SP_peak_levels_a    % (dB) Measured peak sound pressure levels for each 
% %                     % frequency band 
% % 
% % SP_theo_peak_on      % (dB) Theoretical peak sound pressure levels for each 
% %                     % frequency band 
% % 
% % SP_theo_level_on     % (dB) Theoretical sound pressure levels for each each
% %                     % frequency band 
% %
% % **********************************************************************
% 
%
% Example='1';
% 
% flag2=0;                    % Test with sinusoidal signals
% N=3;                        % Test the third octave band data
% num_x_filter=2;             % Filter the signal twice to increase attenuation
% filter_program=2;           % Test the filtfilt program
% filename_out='RMS_data';    % Name the output Matlab File
% 
% Create the vector of sampling rates from third octave band center
% Fsa=1000*[20 50 100 200 500 1000];
% 
% 
% Create the vector of third octave band center frequencies for the third
% octave band filter set.
% Nc=3;
% min_f=20;
% max_f=100000;
% 
% [Fca] = nth_freq_band(Nc, min_f, max_f);
% num_cen_freq=length(Fca);
% 
% 
% Create the vector of Nth octave band center frequencies for the test 
% signals.
% N=3;
% min_f=20;
% max_f=100000;
% 
% [F_siga] = nth_freq_band(N, min_f, max_f);
% num_sig_freq=length(F_siga);
% 
% 
% [SP_rms_levels_a, SP_peak_levels_a, SP_theo_peak_on, SP_theo_level_on]=Test_Nth_oct_filters1b(flag2, N, num_x_filter, filter_program, filename_out, Fsa, Fca, F_siga);
% 
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
% % 
% % Subprograms
% %
% % This program requires the Matlab Signal Processing Toolbox
% % This program uses a recreation of  oct3dsgn	by Christophe Couvreur	69
% % 
% % 
% % List of Dependent Subprograms for 
% % Test_Nth_oct_filters2
% % 
% % 
% % Program Name   Author   FEX ID#
% %  1) convert_double		
% %  2) estimatenoise		John D'Errico		16683	
% %  3) filter_settling_data		
% %  4) moving		Aslak Grinsted		8251	
% %  5) Nth_oct_time_filter2		
% %  6) Nth_octdsgn		
% %  7) progressbar		Dirk Poot		16265	
% %  8) sub_mean		
% %  9) tone_burst		
% % 10) wsmooth		Damien Garcia					
% % 
% % 
% % **********************************************************************
% %
% % Program was written by Edward L. Zechmann
% % 
% %     date 20 August      2008
% % 
% % modified 21 August      2008  
% % 
% % modified  2 September   2008  
% % 
% % modified 18 December    2008    Updated comments.
% %                                 Began generalizing program to Nth 
% %                                 octave filters. 
% % 
% % modified 22 December    2008    Finished generalizing program to test
% %                                 the Nth_oct_filter progam.  
% % 
% % modified  3 January     2008    Modified Program to run tone_burst.m.
% % 
% % modified  7 January     2008    Updated comments.
% % 
% % **********************************************************************
% %
% % 
% % Please feel free to modify this code.
% % 
% % See Also: Nth_oct_time_filter2, octave, resample, filter, filtfilt
% % 
 

if (nargin < 1 || isempty(flag2)) || ~isnumeric(flag2)
    flag2=2;
end

if (nargin < 2 || isempty(N)) || ~isnumeric(N)
    N=3;
end

if (nargin < 3 || isempty(num_x_filter)) || ~isnumeric(num_x_filter)
    num_x_filter=2;
end

if (nargin < 4 || isempty(filter_program)) || ~isnumeric(filter_program)
    filter_program=1;
end

if (nargin < 5 || isempty(filename_out)) || ~ischar(filename_out)
    filename_out='test_data';
end

if (nargin < 6 || isempty(Fsa)) || ~isnumeric(Fsa)
    Fsa=20000;
end

if (nargin < 7 || isempty(Fca)) || ~isnumeric(Fca)
    Fca=1000;
end

if (nargin < 8 || isempty(F_siga)) || ~isnumeric(F_siga)
    F_siga=1000;
end

if (nargin < 9 || isempty(resample_filter)) || ~isnumeric(resample_filter)
    resample_filter=1;
end


close('all');
tic;

% Determine the number of elements in each frequency array.
num_sampl_rates=length(Fsa);
num_sig_freq=length(F_siga);
num_cen_freq=length(Fca);


% Initialize the ouput arrays of the sound pressure rms levels and peak
% level.
SP_rms_levels_a=zeros(num_sampl_rates, num_sig_freq, num_cen_freq); 
SP_peak_levels_a=zeros(num_sampl_rates, num_sig_freq, num_cen_freq); 


% Calculate the total number of combinations of frequency arrays to 
% process.
nums=numel(SP_peak_levels_a);


% Initialize the progressbar.
progressbar('start', [1 nums], 'Running program');


% Set the theoretical value of the sound presure rms level and peak level
SP_theo_peak_on=20*log10(1/0.00002);
SP_theo_level_on=20*log10(1/sqrt(2)/0.00002);

% Initialize some constants
settling_time=0.1;
sensor=1;
max_num_samples=500000;

% Analyze each combination of frequency arrays.  
for e1=1:num_sampl_rates;

    % Index the sampling rate frequency array 
    % Update the local sampling rate scalar
    Fs=Fsa(e1);
    
    for e2=1:num_sig_freq;
        
        % Index the signal frequency array 
        % Update the local signal frequency rate scalar
        F_sig=F_siga(e2);
        
        for e3=1:num_cen_freq;
            
            % Determine which element is being processed
            num2=(e1-1)*num_sig_freq*num_cen_freq+(e2-1)*num_cen_freq+e3;
            
            % Update the progress bar
            progressbar(num2, ['Running Case ' num2str(num2), ' of ', num2str(nums), ' .']);
            
            % Index the center frequency array 
            % Update the local center frequency scalar
            Fc=Fca(e3);
            
            if (F_sig < Fs/2.56) && logical(Fc < Fs/2.56)
            
                td=max([10/Fs, 200/F_sig, 10/Fc, 0.05]);
                   
                num_samples=ceil(Fs*td);
                
                if max_num_samples < num_samples
                
                    td=max_num_samples/Fs;
                
                end
                
                
                % Create the pure tone or a tone burst time record
                if isequal(flag2, 1)
                    delay=td./10;
                    A1=0;
                    A2=1;
                    num_waves=7;
                    [y]=tone_burst(Fs, F_sig, td, delay, num_waves, A1, A2);
                else
                    y=sin(2*pi*F_sig*(0:(1/Fs):td));
                end
                
                
                % Calculate the rms and peak levels 
                [fcout, SP_levels, SP_peak_levels]=Nth_oct_time_filter2(y, Fs, num_x_filter, N, Fc, sensor, settling_time, filter_program, resample_filter);

                % Save the rms and peak levels 
                SP_rms_levels_a(e1, e2, e3)=SP_levels;
                SP_peak_levels_a(e1, e2, e3)=SP_peak_levels;
                
            end
            
        end
    end
    
    % Update the time to process the files.
    t2=toc;
    save(filename_out, 'SP_rms_levels_a', 'SP_peak_levels_a', 'SP_theo_peak_on', 'SP_theo_level_on', 't2', 'Fsa', 'Fca', 'F_siga');
    
end






