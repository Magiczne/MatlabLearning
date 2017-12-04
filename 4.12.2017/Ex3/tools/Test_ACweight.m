function [f, A_atten, A_atten2, C_atten, C_atten2]=Test_ACweight(Fs, N, flag2, resample_filter)
% % Test_ACweight:  Tests the A and C weighting filters using pure tones and tone bursts
% %
% % Syntax;
% %
% % [f, A_atten, A_atten2, C_atten, C_atten2]=Test_ACweight(Fs, N, flag2, resample_filter);
% %
% % **********************************************************************
% %
% % Description
% %
% % Test_ACweight(Fs, N);
% % Returns four figures quantifying the performance of the A and C weight
% % filters and the error of the A and C-weighting filters respectively
% % compared to the Type0, 1, and 2 filter tolerance specifications of
% % ANSI S1.4.  The performance of the filters is calculated at the
% % sampling rate Fs (Hz) for a number of bands, N per octave.
% %
% % [f, A_atten, A_atten2, C_atten, C_atten2]=Test_Aweight2(Fs, N, flag2);
% % Returns the center frequency of each band and the theoretical and
% % actual attenuation for the A and C-weighting filters respectively.
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
% % Fs=50000;           % (Hz) sampling rate in Hz.  
% %                     % default is 50000 Hz.
% % 
% % N=3;                % Number of frequency bands per octave.
% %                     % Can be any number > 0.  
% %                     % Default is N=3; (third octave bands)
% %
% % flag2=1;            % Boolean which determines whether to test rms 
% %                     % levels with sinusoids or peak levels with 
% %                     % ringing impulses from analytic_impulse.  
% %                     % flag2=1 tests the pure tones.  Otherwise the
% %                     % peak levels aerea tested.
% %                     % default is flag2=1; Testing pure tones.
% %
% % resample_filter=1;  % type of filter to use when resamling
% %                     % 1 resample function Kaiser window fir filter
% %                     % 2 Bessel filter 
% %                     % otherwise resample function Kaiser window fir
% %                     % filter
% %                     % default is resample_filter=1; (Kaiser window)
% %
% %
% %
% % ***********************************************************
% %
% % Output Variables
% %
% % f (Hz) is the center frequency bands of the filters.
% %
% % A_atten (dB) is the theoretical attenuation of the A-weighting filters.
% %
% % A_atten2 (dB) is the actual attenuation of the A-weighting filters.
% %
% % C_atten (dB) is the theoretical attenuation of the C-weighting filters.
% %
% % C_atten2 (dB) is the actual attenuation of the C-weighting filters.
% %
% %
% % **********************************************************************
%
% Example='1';
% % Test the filters for six sampling rates.
% 
% cd..
% mkdir('Resample');
% cd('Resample');
% Fsa=1000*[20 50 100 200 500 1000];
% N=3;
% flag2=1;
% resample_filter=1;
% for e1=1:length(Fsa);
%   close all;
%   Fs=Fsa(e1);
%   Test_ACweight(Fs, N, flag2, resample_filter);
% end
% 
% cd..
% mkdir('Bessel');
% cd('Bessel');
% resample_filter=2;
% for e1=1:length(Fsa);
%   close all;
%   Fs=Fsa(e1);
%   Test_ACweight(Fs, N, flag2, resample_filter);
% end
% 
% 
% 
% Example='2';
% % Test the filters for six sampling rates.
% Fsa=1000*[20 50 100 200 500 1000];
% N=12;
% flag2=1;
% for e1=1:length(Fsa);
%   close all;
%   Fs=Fsa(e1);
%   Test_ACweight(Fs, N, flag2);
% end
%
%
%
% Example='3';
% % Test the filters for six sampling rates.
% Fsa=1000*[20 50 100 200 500 1000];
% N=3;
% flag2=0;
% for e1=1:length(Fsa);
%   close all;
%   Fs=Fsa(e1);
%   Test_ACweight(Fs, N, flag2);
% end
%
%
%
% Example='4';
% % Test the filters for six sampling rates.
% Fsa=1000*[20 50 100 200 500 1000];
% N=12;
% flag2=0;
% resample_filter=1;
% for e1=1:length(Fsa);
%   close all;
%   Fs=Fsa(e1);
%   Test_ACweight(Fs, N, flag2, resample_filter);
% end
%
%
% % **********************************************************************
% % 
% % References
% % 
% % IEC/CD 1672: Electroacoustics-Sound Level Meters, Nov. 1996. 
% % 
% % ANSI S1.4: Specifications for Sound Level Meters, 1983. 
% % 
% % **********************************************************************
% %
% % 
% % 
% % Subprograms
% %
% % This program requires the Matlab Signal Processing Toolbox
% %
% % 
% % 
% % List of Dependent Subprograms for 
% % Test_ACweight
% % 
% % FEX ID# is the File ID on the Matlab Central File Exchange
% % 
% % 
% % Program Name   Author   FEX ID#
% %  1) AC_weight_NB		William Murphy			
% %  2) ACdsgn		Edward L. Zechmann			
% %  3) ACweight_time_filter		Edward L. Zechmann			
% %  4) bessel_antialias		Edward L. Zechmann			
% %  5) bessel_digital		Edward L. Zechmann			
% %  6) bessel_down_sample		Edward L. Zechmann			
% %  7) convert_double		Edward L. Zechmann			
% %  8) file_extension		Edward L. Zechmann			
% %  9) filter_settling_data3		Edward L. Zechmann			
% % 10) flat_top		Edward L. Zechmann			
% % 11) geospace		Edward L. Zechmann			
% % 12) get_p_q2		Edward L. Zechmann			
% % 13) Leq_all_calc		Edward L. Zechmann			
% % 14) LMSloc		Alexandros Leontitsis		801	
% % 15) match_height_and_slopes2		Edward L. Zechmann			
% % 16) moving		Aslak Grinsted		8251	
% % 17) nth_freq_band		Edward L. Zechmann			
% % 18) Nth_oct_time_filter2		Edward L. Zechmann			
% % 19) Nth_octdsgn		Edward L. Zechmann			
% % 20) number_of_averages		Edward L. Zechmann			
% % 21) pressure_spectra		Edward L. Zechmann			
% % 22) remove_filter_settling_data		Edward L. Zechmann			
% % 23) resample_interp3		Edward L. Zechmann			
% % 24) rms_val		Edward L. Zechmann			
% % 25) save_a_plot_reverb_time		Edward L. Zechmann			
% % 26) sd_round		Edward L. Zechmann			
% % 27) spatialPattern		Jon Yearsley		5091	
% % 28) spectra_estimate		Edward L. Zechmann			
% % 29) sub_mean		Edward L. Zechmann			
% % 30) tone_burst		Edward L. Zechmann			
% % 31) window_correction_factor		Edward L. Zechmann										
% %
% %
% % **********************************************************************
% %
% % Program was written by Edward L. Zechmann
% %
% % created                 2007
% %
% % modified 18 November    2008    Updated Comments
% %
% % modified 11 December    2008    Began modifying A and C weighting
% %                                 filters with resampling and filter
% %                                 settling.
% %
% % modified 17 December    2008    Added Type0, 1, and 2 tolerance curves
% %                                 Added ability to test peak levels.
% %
% % modified  2 August      2010    Modified filter settling data program
% %                                 Added resampling using a Bessel Filter.
% %                                 Updated Comments.
% %
% %
% % **********************************************************************
% %
% % Please feel free to modify this code.
% %
% % See Also: filter, filtfilt, resample, ACweight_time_filter,
% %           hand_arm_time_fil, whole_body_time_filter
% %


if (nargin < 1 || isempty(Fs)) || ~isnumeric(Fs)
    Fs=50000;
end

if (nargin < 2 || isempty(N)) || (logical(N < 0) || ~isnumeric(N))
    N=3;
end

if (nargin < 3 || isempty(N)) || (logical(N < 0) || ~isnumeric(N))
    flag2=1;
end

if (nargin < 4 || isempty(resample_filter)) || ~isnumeric(resample_filter)
    resample_filter=1;
end


close('all');

% List the frequencies and the response tolerances for the Type0, Type 1,
% and Type 2 filters
ftype=[10 12.5 16 20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
a=[-70.4  -63.4 -56.7 -50.5 -44.7 -39.4 -34.6 -30.2 -26.2 -22.5 -19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1 0.5 -0.1 -1.1 -2.5 -4.3 -6.6 -9.3];
%b=[-38.2 -33.2 -28.5 -24.2 -20.4 -17.1 -14.2 -11.6 -9.3 -7.4 -5.6 -4.2 -3.0 -2.0 -1.3 -0.8 -0.5 -0.3 -0.1 0 0 0 0 -0.1 -0.2 -0.4 -0.7 -1.2 -1.9 -2.9 -4.3 -6.1 -8.4 -11.1];
c=[-14.3 -11.2 -8.5 -6.2 -4.4 -3.0 -2.0 -1.3 -0.8 -0.5 -0.3 -0.2 -0.1 0 0 0 0 0 0 0 0 0 -0.1 -0.2 -0.3 -0.5 -0.8 -1.3 -2.0 -3.0 -4.4 -6.2 -8.5 -11.2];

% Response limits of the Type0 filters
type0_h= [2 2 2 2 1.5 1 1 1 1 1 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 1 1   1 2 2 2 2 ];
type0_l=-[5 4 3 2 1.5 1 1 1 1 1 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 1 1.5 2 3 3 3 3 ];

% Response limits of the Type1 filters
type1_h= [4 3.5 3 2.5 2 1.5 1.5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1.5 1.5 1.5 2 3 3   3];
type1_l=-[4 3.5 3 2.5 2 1.5 1.5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1.5 2   3   4 6 inf inf];

% Response limits of the Type2 filters
type2_h= [5   5   5   3 3 3 2 2 2 2 1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5  2 2 2.5 2.5 3 3.5 4.5 5 5   5   5   5];
type2_l=-[inf inf inf 3 3 3 2 2 2 2 1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5  2 2 2.5 2.5 3 3.5 4.5 5 inf inf inf inf];

% Calculate the center band frequencies of the signals
min_f=10;
max_f=min([Fs/3, 50000]);
[f] = nth_freq_band(N, min_f, max_f);

% Calculate the powers of 10 for plotting the frequency in the xtick
[f_plot, buf2, buf3, f_str] = nth_freq_band(3/10, min_f, max_f);


cf=1;
settling_time=0.1;

num_bands=length(f);

A_atten2=zeros(num_bands, 1);
C_atten2=zeros(num_bands, 1);


for e1=1:length(f);

    td=max([10/Fs, 10/f(e1), 0.2]);

    % Create the pure tone or a tone burst time record
    if isequal(flag2, 1)
        % produce a sinusoid with 10 full periods.
        t_SP=(0:(1/Fs):td);
        y=sin(2*pi*t_SP*f(e1));
    else
        % produce a pure tone.
        delay=0.1;
        A1=0;
        A2=1;
        num_waves=10;
        [y]=tone_burst(Fs, f(e1), td, delay, num_waves, A1, A2);
    end
    
    [LeqA, LeqA8, LeqC, LeqC8, Leq, Leq8, peak_dB, peak_dBA, peak_dBC, peak_Pa, peak_PaA, peak_PaC]=Leq_all_calc(y, Fs, cf, settling_time, resample_filter);

    if isequal(flag2, 1)
        A_atten2(e1)=LeqA-Leq;
        C_atten2(e1)=LeqC-Leq;
    else
        A_atten2(e1)=peak_dBA-peak_dB;
        C_atten2(e1)=peak_dBC-peak_dB;
    end

end

[Wa, Wc]=AC_weight_NB(f, 0);
A_atten=Wa;
C_atten=Wc;

LW=2;
if isequal(flag2, 1)
    title_blurb='RMS';
else
    title_blurb='Peak';
end

% Plot the A-weight Filter performance curve
figure(1);
semilogx(f, A_atten2, 'r', 'LineWidth', LW );
hold on;
semilogx(f, A_atten, 'b', 'LineWidth', LW );
semilogx(ftype, a+type0_h, '--g', 'LineWidth', LW);
semilogx(ftype, a+type1_h, '-.m', 'LineWidth', LW);
semilogx(ftype, a+type2_h, ':r', 'LineWidth', LW);
semilogx(ftype, a+type0_l, '--g', 'LineWidth', LW);
semilogx(ftype, a+type1_l, '-.m', 'LineWidth', LW);
semilogx(ftype, a+type2_l, ':r', 'LineWidth', LW);

legend({'Actual', 'Theoretical', 'Type-0', 'Type-1', 'Type-2'}, 'Location', 'South');
xlabel('Frequency Hz', 'Fontsize', 28);
ylabel('Attnuation dB', 'Fontsize', 28);
title( {[title_blurb, ' A-weight Filter'], [num2str(Fs/1000) , ' KHz Sampling Rate']},  'Fontsize', 40 );
set(gca, 'Fontsize', 28);
set( gca, 'XTickMode', 'manual', 'XTick', f_plot, 'XTickLabel', f_str);
xlim([min(f), 50000]);
ylim([-80 20]);


% Plot the C-weight Filter performance curve
figure(2);
semilogx(f, C_atten2, 'color', 'b', 'LineWidth', LW);
hold on;
semilogx(f, C_atten, 'k', 'LineWidth', LW);
semilogx(ftype, c+type0_h, '--g', 'LineWidth', LW);
semilogx(ftype, c+type1_h, '-.m', 'LineWidth', LW);
semilogx(ftype, c+type2_h, ':r', 'LineWidth', LW);
semilogx(ftype, c+type0_l, '--g', 'LineWidth', LW);
semilogx(ftype, c+type1_l, '-.m', 'LineWidth', LW);
semilogx(ftype, c+type2_l, ':r', 'LineWidth', LW);

legend({'Actual', 'Theoretical', 'Type-0', 'Type-1', 'Type-2'}, 'Location', 'South');
xlabel('Frequency Hz', 'Fontsize', 28);
ylabel('Attnuation dB', 'Fontsize', 28);
title( {[title_blurb, ' C-weight Filter'], [num2str(Fs/1000) , ' KHz Sampling Rate']},  'Fontsize', 40 );
set(gca, 'Fontsize', 28);
set( gca, 'XTickMode', 'manual', 'XTick', f_plot, 'XTickLabel', f_str);
xlim([min(f), 50000]);
ylim([-80 20]);


% Plot the A-weight Filter performance error curve
figure(3);
semilogx(f, -A_atten+A_atten2, 'k', 'LineWidth', LW, 'marker', 'p', 'markersize', 7);
hold on;
semilogx(ftype, type0_h, '--g', 'LineWidth', LW);
semilogx(ftype, type1_h, '-.m', 'LineWidth', LW);
semilogx(ftype, type2_h, ':r', 'LineWidth', LW);
semilogx(ftype, type0_l, '--g', 'LineWidth', LW);
semilogx(ftype, type1_l, '-.m', 'LineWidth', LW);
semilogx(ftype, type2_l, ':r', 'LineWidth', LW);

legend({'Actual error', 'Type-0', 'Type-1', 'Type-2'}, 'Location', 'South');
xlabel('Frequency Hz', 'Fontsize', 28);
ylabel('Absolute Error dB', 'Fontsize', 28);
title( {[title_blurb, ' A-weight Filter Error'], [num2str(Fs/1000) , ' KHz Sampling Rate']},  'Fontsize', 40 );
set(gca, 'Fontsize', 28);
set( gca, 'XTickMode', 'manual', 'XTick', f_plot, 'XTickLabel', f_str);
xlim([min(f), 50000]);
ylim(10*[-1 1]);

% Plot the C-weight Filter performance error curve
figure(4);
semilogx(f, -C_atten+C_atten2, 'k', 'LineWidth', LW, 'marker', 'd', 'markersize', 7);
hold on;
semilogx(ftype, type0_h, '--g', 'LineWidth', LW);
semilogx(ftype, type1_h, '-.m', 'LineWidth', LW);
semilogx(ftype, type2_h, ':r', 'LineWidth', LW);
semilogx(ftype, type0_l, '--g', 'LineWidth', LW);
semilogx(ftype, type1_l, '-.m', 'LineWidth', LW);
semilogx(ftype, type2_l, ':r', 'LineWidth', LW);

legend({'Actual error', 'Type-0', 'Type-1', 'Type-2'}, 'Location', 'South');
xlabel('Frequency Hz', 'Fontsize', 28);
ylabel('Absolute Error dB', 'Fontsize', 28);
title( {[title_blurb, ' C-weight Filter Error'], [num2str(Fs/1000) , ' KHz Sampling Rate']},  'Fontsize', 40 );
set(gca, 'Fontsize', 28);
set( gca, 'XTickMode', 'manual', 'XTick', f_plot, 'XTickLabel', f_str);
xlim([min(f), 50000]);
ylim(10*[-1 1]);

% Save the plots to Fig and Tiff File formats
figure(1); save_a_plot_reverb_time(2, [title_blurb, '_A_curve_', num2str(Fs/1000), 'KHZ'], 1);
figure(1); save_a_plot_reverb_time(6, [title_blurb, '_A_curve_', num2str(Fs/1000), 'KHZ'], 1);

figure(2); save_a_plot_reverb_time(2, [title_blurb, '_C_curve_', num2str(Fs/1000), 'KHZ'], 1);
figure(2); save_a_plot_reverb_time(6, [title_blurb, '_C_curve_', num2str(Fs/1000), 'KHZ'], 1);

figure(3); save_a_plot_reverb_time(2, [title_blurb, '_A_error_', num2str(Fs/1000), 'KHZ'], 1);
figure(3); save_a_plot_reverb_time(6, [title_blurb, '_A_error_', num2str(Fs/1000), 'KHZ'], 1);

figure(4); save_a_plot_reverb_time(2, [title_blurb, '_C_error_', num2str(Fs/1000), 'KHZ'], 1);
figure(4); save_a_plot_reverb_time(6, [title_blurb, '_C_error_', num2str(Fs/1000), 'KHZ'], 1);

