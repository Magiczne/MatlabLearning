function  Test_Nth_oct_filters1(resample_filter)
% % Test_Nth_oct_filters1: This program tests the Nth octave time filters for continuous and impulsive noise
% % 
% % Syntax:
% % 
% % Test_Nth_oct_filters1;
% % 
% % **********************************************************************
% %
% % Description
% % 
% % Warning: this program may take two hours or more to run on a 4.0 GHz desktop PC.  
% % 
% % This program tests the Nth_oct_time_filter2 program using sinusiods 
% % with 200 waves and tone bursts with 7 full sinusoidal waves.   
% % Plots and 3 dimensional tables are output which describe the accuracy 
% % of estimating the Leq (dB) and Peak level (dB).   
% % 
% % This test is not part of ANSI S1.11 and does not verify performance 
% % according to ANSI S1.11; however, it does indicate how well
% % Nth_oct_time_filter2 will estimate Leq (dB) and Peak level (dB) for 
% % sinusoids and tone bursts respectively.   
% % 
% % Data files *.mat and image files *.fig and *.tiff are saved to  
% % subfolders named Sinusoid and Tone_Burst.  
% % The file names are descriptive and indicate whether the test 
% % signals are testing the RMS level or Peak level.  The file names
% % indicate the number of bands per octave of the filter.  
% % Also the file name indicates the sampling rate (KHz).  
% % 
% % This program has no inputs and no outputs so it can be run from the
% % command line very easily.  See the example fro more details.
% % 
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
% % The input and output variables are described in more detail in the
% % respective sections below.
% % 
% % ***********************************************************
% %
% % Input Variables
% %
% % resample_filter=1;  % type of filter to use when resamling
% %                     % 1 resample function Kaiser window fir filter
% %                     % 2 Bessel filter 
% %                     % otherwise resample function Kaiser window fir
% %                     % filter
% %                     % default is resample_filter=1; (Kaiser window)
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
% Test_Nth_oct_filters1;
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
% % Test_Nth_oct_filters1
% % 
% % FEX ID# is the File ID on the Matlab Central File Exchange
% % 
% % 
% % Program Name   Author   FEX ID#
% %  1) bessel_antialias		Edward L. Zechmann			
% %  2) bessel_digital		Edward L. Zechmann			
% %  3) bessel_down_sample		Edward L. Zechmann			
% %  4) convert_double		Edward L. Zechmann			
% %  5) file_extension		Edward L. Zechmann			
% %  6) filter_settling_data3		Edward L. Zechmann			
% %  7) geospace		Edward L. Zechmann			
% %  8) LMSloc		Alexandros Leontitsis		801	
% %  9) match_height_and_slopes2		Edward L. Zechmann			
% % 10) moving		Aslak Grinsted		8251	
% % 11) nth_freq_band		Edward L. Zechmann			
% % 12) Nth_oct_time_filter2		Edward L. Zechmann			
% % 13) Nth_octdsgn		Edward L. Zechmann			
% % 14) plot_test_Nth_oct_filters		Edward L. Zechmann			
% % 15) progressbar		Dirk Poot		16265	
% % 16) remove_filter_settling_data		Edward L. Zechmann			
% % 17) resample_interp3		Edward L. Zechmann			
% % 18) rms_val		Edward L. Zechmann			
% % 19) save_a_plot_reverb_time		Edward L. Zechmann			
% % 20) sd_round		Edward L. Zechmann			
% % 21) sub_mean		Edward L. Zechmann			
% % 22) Test_Nth_oct_filters1b		
% % 23) tone_burst		Edward L. Zechmann								
% % 
% % 
% % **********************************************************************
% %
% % Program was written by Edward L. Zechmann
% % 
% % created   2 September 2008
% % 
% % modified 18 December    2008    Updated Comments
% % 
% % modified 22 December    2008    Generalized code to test the
% %                                 Nth_oct_filter progam.  
% % 
% % modified  3 January     2008    Modified Program to run tone_burst.m.
% %
% % modified 4 August       2010    Updated Comments
% %
% % 
% % 
% % **********************************************************************
% % 
% % Please feel free to modify this code.
% %
% % See Also: Test_Nth_oct_filters, Nth_oct_time_filter, octave, resample, filter, filtfilt
% %


if (nargin < 1 || isempty(resample_filter)) || ~isnumeric(resample_filter)
    resample_filter=1;
end



% Create the vector of sampling rates from third octave band center
% frequencies
%min_f=20000;
%max_f=1000000;

%[Fs] = nth_freq_band(N, min_f, max_f);

% This array has sampling rates from 20 KHz to 1000 KHz
Fsa=1000*[20 50 100 200 500 1000];


% Create the vector of third octave band center frequencies for the third
% octave band filter set.
Nc=3;
min_f=20;
max_f=100000;

[Fca] = nth_freq_band(Nc, min_f, max_f);


% Create the vector of Nth octave band signal frequencies for the test 
% signals.
N=3;
min_f=20;
max_f=100000;

[F_siga] = nth_freq_band(N, min_f, max_f);



% % **********************************************************************
%
% Test the Nth_oct_filter set for continuous and impulsive noise
% 
paths={'Sinusoid', 'Tone_Burst',};
path=cd;

% % **********************************************************************
%
% Test Nth_oct_filter set for continuous noise with sinusoids 
%
[status,message,messageid] = mkdir(paths{1});
cd(paths{1});
flag2=0;                    % Test with sinusoidal signals
N=3;                        % Test the third octave band data
num_x_filter=2;             % Filter the signal twice to increase attenuation
filter_program=2;           % Test the filtfilt program
filename_out='RMS_data';    % Name the output Matlab File


[SP_rms_levels_a, SP_peak_levels_a, SP_theo_peak_on, SP_theo_level_on]=Test_Nth_oct_filters1b(flag2, N, num_x_filter, filter_program, filename_out, Fsa, Fca, F_siga, resample_filter);
file_str={'RMS', 'Peak'};
method=1;
plot_test_Nth_oct_filters(SP_rms_levels_a, SP_peak_levels_a, SP_theo_peak_on, SP_theo_level_on, Fsa, Fca, F_siga, file_str, N, method);




% % **********************************************************************
%
% Test Nth_oct_filter set for the impulsive noise with ringing impulses
%
cd(path);
[status,message,messageid] = mkdir(paths{2});
cd(paths{2});
flag2=1;                    % Test with sinusoidal signals
N=3;                        % Test the third octave band data
num_x_filter=2;             % Filter the signal twice to increase attenuation
filter_program=2;           % Test the filtfilt program
filename_out='Peak_data';   % Name the output Matlab File
[SP_rms_levels_a, SP_peak_levels_a, SP_theo_peak_on, SP_theo_level_on]=Test_Nth_oct_filters1b(flag2, N, num_x_filter, filter_program, filename_out, Fsa, Fca, F_siga);
file_str={'RMS', 'Peak'};
method=2;
plot_test_Nth_oct_filters(SP_rms_levels_a, SP_peak_levels_a, SP_theo_peak_on, SP_theo_level_on, Fsa, Fca, F_siga, file_str, N, method);

% Return to the original path
cd(path);


