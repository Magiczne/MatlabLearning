function [f_sig, Wf ]=Test_hand_arm(Fs, resample_filter)
% % Test_hand_arm: Tests the accuracy of the hand-arm vibrations filters
% % 
% % Syntax:
% % 
% % [f_sig, Wf ]=Test_hand_arm(Fs, resample_filter);
% % 
% % **********************************************************************
% % 
% % Description 
% % 
% % [f_sig, Wf ]=Test_hand_arm(Fs, resample_filter);
% % 
% % Returns an array of signal frequencies f_sig (Hz) and Wf an array of 
% % hand-arm vibrations attenuation ratios given the sampling rate Fs (Hz).
% % Also the program saves plots which show the accuracy of the filters.  
% % The upper and lower boundaries of the standard tolerance are also 
% % plotted.  
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
% % ***********************************************************
% % 
% % Input Variables
% %
% % Fs=1000;            % (Hz) sampling rate in Hz.  
% %                     % default is 50000 Hz.
% % 
% % resample_filter=1;  % type of filter to use when resamling
% %                     % 1 resample function Kaiser window fir filter
% %                     % 2 Bessel filter 
% %                     % otherwise resample function Kaiser window fir
% %                     % filter
% %                     % default is resample_filter=1; (Kaiser window)
% %
% % **********************************************************************
% % 
% % Output Variables
% %
% % f_sig (Hz) is the center frequency bands of the filters.
% % 
% % Wf is an array of whole body vibrations attenuation ratios 
% % 
% % **********************************************************************
% 
%
% Example='1';
% 
% % Test the hand arm vibrations filter for six sampling rates.
% 
% Fsa=1000*[5 10 20 50 100 200];
% resample_filter=1;
% 
% for e1=1:length(Fsa);
%   close all;
%   Fs=Fsa(e1);
%   [f_sig, Wf ]=Test_hand_arm(Fs, resample_filter);
% end
% 
% 
% % **********************************************************************
% %
% % 
% % Subprograms
% %
% % This program requires the Matlab Signal Processing Toolbox
% %
% % 
% % List of Dependent Subprograms for 
% % Test_hand_arm
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
% %  8) get_p_q2		Edward L. Zechmann			
% %  9) hand_arm_fil		Edward L. Zechmann			
% % 10) hand_arm_time_fil		Edward L. Zechmann			
% % 11) LMSloc		Alexandros Leontitsis		801	
% % 12) match_height_and_slopes2		Edward L. Zechmann			
% % 13) nth_freq_band		Edward L. Zechmann			
% % 14) remove_filter_settling_data		Edward L. Zechmann			
% % 15) resample_interp3		Edward L. Zechmann			
% % 16) rms_val		Edward L. Zechmann			
% % 17) save_a_plot_reverb_time		Edward L. Zechmann			
% % 18) sd_round		Edward L. Zechmann			
% % 19) sub_mean2		Edward L. Zechmann						
% % 
% % 
% % **********************************************************************
% %
% % Test_hand_arm was written by Edward L. Zechmann
% %
% %  created 29 June        2007 
% % 
% % modified 18 December    2008    Updated Comments
% % 
% % modified 19 December    2008    Updated Comments
% % 
% % modified  5 January     2008    Added sub_mean to remove running
% %                                 average using a time constant at one- 
% %                                 half the lowest frequency band of 
% %                                 interest(1 Hz).
% % 
% % modified  9 July        2010    Added an option to resample using a
% %                                 Bessel Filter.  Updated comments.
% %
% % modified  4 August      2010    Updated Comments
% %
% %
% %                                 
% % 
% % **********************************************************************
% % 
% % Please feel free to modify this code.
% % 
% % See Also:  Test_whole_body, hand_arm_time_fil, hand_arm_freq
% % 


if (nargin < 1 || isempty(Fs)) || ~isnumeric(Fs)
    Fs=50000;
end

if (nargin < 2 || isempty(resample_filter)) || ~isnumeric(resample_filter)
    resample_filter=1;
end

% Standard Tolerance is 
% +-2 dB from 4.0  Hz to 6.3 Hz
% +-1 dB from 6.3  Hz to 1250 Hz
% +-2 dB from 1250 Hz to 2000 Hz
t_a=[2 2 ones(1, 24) 2 2];

% Calculate the fraction of the upper and lower limits of the tolerance 
% of the attenuation ratio.
tol_high=10.^(t_a./20);
tol_low=10.^(-t_a./20);


% Initialize the filter coefficients.
B=1;
A=1;

% Make an array of third octave band center cfrequencies from min_f to 
% max_f for the range of frequencies applicable to hand arm vibrations and
% the sampling rate.  

f_sig_max=2000;
N=3;
min_f=1.0;
max_f=min([f_sig_max, Fs/3]);

[f_sig] = nth_freq_band(N, min_f, max_f);

% f_a is the third octave bands from 4 Hz to 2000 Hz
[f_a] = nth_freq_band(3, 4, f_sig_max);

% a is 
a=[0.375 0.545 0.727 0.873 0.951 0.958 0.896 0.782 0.647 0.519 0.411 0.324 0.256 0.202 0.160 0.127 0.101 0.0799 0.0634 0.0503 0.0398 0.0314 0.0245 0.0186 0.0135 0.00894 0.00536 0.00295];


% Calculate the number of bands
num_bands=length(f_sig);

% Initialize the attenuation factors
Wf=zeros(num_bands,1);

% Set the settling time to 1 second.
settling_time=1;

% Calculate the attenuation ratio for each frequency band.
for e1=1:num_bands;
    
    t_SP=1/Fs*(1:Fs);
    
    y=sin(2*pi*t_SP*f_sig(e1));
    
    if logical(length(A) < 4) || logical(length(B) < 4)
        [yhw, B, A, errors]=hand_arm_time_fil(y, Fs, [], [], settling_time, resample_filter);
    else
        [yhw, B, A, errors]=hand_arm_time_fil(y, Fs, B, A, settling_time, resample_filter);
    end
        
    Wf(e1)=norm(yhw)/sqrt(length(yhw))/(norm(y)/sqrt(length(y)));
    
end


% Set the Line Width for the curves
LW=2;



% Plot the actual and theoretical attenuation curve and the tolerance 
% curves
figure(1);
delete(1);
figure(1);

loglog(f_sig, Wf, 'r', 'LineWidth', LW, 'marker', 'x', 'markersize', 7 );
hold on; 
loglog(f_a, a, 'b', 'LineWidth', LW);
loglog(f_a, a.*tol_high, '--g', 'LineWidth', LW);
loglog(f_a, a.*tol_low, '--g', 'LineWidth', LW);

legend({'Actual', 'Theoretical', 'Tolerance'});
xlabel('Frequency Hz', 'Fontsize', 28);
ylabel('Weighting Factor', 'Fontsize', 28);
title( {[num2str(Fs/1000) , ' KHz Sampling Rate']},  'Fontsize', 40 );
set(gca, 'Fontsize', 20);
set( gca, 'XTickMode', 'manual', 'XTick', [1 2 4 8 16 31.5 63 125 250 500 1000], 'XTickLabel', {'1', '2', '4', '8', '16', '31.5', '63', '125', '250', '500', '1000'}); 
set( gca, 'YTickMode', 'manual', 'YTick', [0.001 0.01 0.1 1], 'YTickLabel', {'0.001', '0.01', '0.1', '1'}); 
xlim([min(f_sig), f_sig_max]);
ylim([0.001 1]);
set(gca, 'xscale', 'log');
set(gca, 'yscale', 'log');




% Plot the percent error and the tolerance curves
figure(2);
delete(2);
figure(2);

% determine the intersection of the published design curve and the test
% signals
[buf IX]=intersect(f_sig, f_a);
[buf IX2]=intersect(f_a, f_sig);

semilogx(f_a(IX2), -100.*(1-Wf(IX)./a(IX2)'), 'r', 'LineWidth', LW);
hold on;
semilogx(f_a, 100.*(tol_high-1), '--g', 'LineWidth', LW);
semilogx(f_a, 100.*(tol_low-1), '--g', 'LineWidth', LW);

legend({'Actual', 'Tolerance'}, 'location', 'SouthWest');
xlabel('Frequency Hz', 'Fontsize', 28);
ylabel('Percent Relative Error', 'Fontsize', 28);
title( {[num2str(Fs/1000) , ' KHz Sampling Rate']},  'Fontsize', 40 );
set(gca, 'Fontsize', 20);
set( gca, 'XTickMode', 'manual', 'XTick', [1 2 4 8 16 31.5 63 125 250 500 1000], 'XTickLabel', {'1', '2', '4', '8', '16', '31.5', '63', '125', '250', '500', '1000'}); 
xlim([min(f_sig), f_sig_max]);
ylim(2*100*(max(tol_high)-1)*[-1 1]);


% Save the plots to Fig and Tiff File formats
figure(1); save_a_plot_reverb_time(2, ['hand_arm_curve_', num2str(Fs/1000), 'KHZ'], 1);
figure(1); save_a_plot_reverb_time(6, ['hand_arm_curve_', num2str(Fs/1000), 'KHZ'], 1);

figure(2); save_a_plot_reverb_time(2, ['hand_arm_error_', num2str(Fs/1000), 'KHZ'], 1);
figure(2); save_a_plot_reverb_time(6, ['hand_arm_error_', num2str(Fs/1000), 'KHZ'], 1);


