function plot_test_Nth_oct_filters(SP_levels_a, SP_peak_levels_a, SP_theo_peak_on, SP_theo_level_on, Fs, Fc, F_sig, file_str, N, method)
% % plot_test_Nth_oct_filters: plots the third octave filter test data
% %
% % Syntax:
% %
% % plot_test_Nth_oct_filters(SP_levels_a, SP_peak_levels_a, SP_theo_peak_on, SP_theo_level_on, Fs, Fc, F_sig, file_str, N, method);
% %
% % **********************************************************************
% %
% % Description
% %
% % This program plots the Nth octave filter test data from the
% % Test_Nth_oct_filters program.
% % 
% % Creates Folders with the names Sinusoid and Tone_Burst.
% % 
% % Data files *.mat and image files *.fig and *.tiff are saved to  
% % subfolders named Sinusoid and Tone_Burst.  
% % The file names are descriptive and indicate whether the test 
% % signals are testing the RMS level or Peak level.  The file names
% % indicate the number of bands per octave of the filter.  
% % Also the file name indicates the sampling rate (KHz).  
% % 
% % The input and output variables are described in more detail in the
% % sections below respectively.  
% % 
% % **********************************************************************
% %
% % Input Variables
% %
% % SP_levels_a         % (dB)Measured sound pressure levels for each
% %                     % frequency band
% %
% % SP_peak_levels_a    % (dB)Measured peak sound pressure levels for each
% %                     % frequency band
% %
% % SP_theo_peak_on      % (dB)Theoretical peak sound pressure levels for each
% %                     % frequency band
% %
% % SP_theo_level_on     % (dB)Theoretical sound pressure levels for each each
% %                     % frequency band
% %
% % Fs                  % (Hz) array of sampling rates
% %
% % Fc                  % (Hz) array of center frequencies
% %
% % F_sig               % (Hz) array of signal frequencies
% %
% % file_str            % String describing the filter and test signal.
% %
% % N                   % Number of bands per octave.
% %
% % **********************************************************************
% %
% %
% % List of Dependent Subprograms for
% % plot_test_Nth_oct_filters
% %
% %
% % Program Name   Author   FEX ID#
% % 1) file_extension
% % 2) save_a_plot_reverb_time
% %
% %
% % **********************************************************************
% %
% % Program was written by Edward L. Zechmann
% %
% %     date 21 August      2008
% %
% % modified  2 September   2008    Added Comments
% %
% % modified 19 December    2008    Modified code to test the
% %                                 Nth_oct_time_filter2 program
% %
% % modified 21 December    2008    Updated Comments.
% %                                 Began generalizing program to test
% %                                 the Nth_oct_filter progam.
% %
% % modified 22 December    2008    Finished generalizing program to test
% %                                 the Nth_oct_filter progam.
% %
% % modified  3 January     2008    Modified Program to run tone_burst.m.
% % 
% % modified  4 December    2008    Modified Program to plot relative 
% %                                 error values.
% %
% % modified  7 January     2008    Updated Comments.
% %
% %
% % **********************************************************************
% %
% % Please feel free to modify this code.
% %
% % See Also: Nth_oct_time_filter2, octave, resample, filter, filtfilt
% %



if (nargin < 1 || isempty(SP_levels_a)) || ~isnumeric(SP_levels_a)
    SP_levels_a=1;
end

if (nargin < 2 || isempty(SP_peak_levels_a)) || ~isnumeric(SP_peak_levels_a)
    SP_peak_levels_a=3;
end

if (nargin < 3 || isempty(SP_theo_peak_on)) || ~isnumeric(SP_theo_peak_on)
    SP_theo_peak_on=2;
end

if (nargin < 4 || isempty(SP_theo_level_on)) || ~isnumeric(SP_theo_level_on)
    SP_theo_level_on=1;
end

if (nargin < 5 || isempty(Fc)) || ~isnumeric(Fc)
    Fc=3;
end

if (nargin < 6 || isempty(F_sig)) || ~isnumeric(F_sig)
    F_sig=3;
end

if (nargin < 7 || isempty(Fs)) || ~isnumeric(Fs)
    Fs=3;
end

if (nargin < 8 || isempty(file_str))
    file_str={'RMS', 'Peak'};
end

if (nargin < 9 || isempty(N)) || ~isnumeric(N)
    N=3;
end

if (nargin < 10 || isempty(method)) || ~isnumeric(method)
    method=1;
end

close all;
min_f=min(F_sig);
max_f=max(F_sig);

% Calculate the powers of 10 for plotting the frequency in the xtick
[f_plot, buf2, buf3, f_str] = nth_freq_band(3/10, min_f, max_f);


% relative bandwidth error tolerance for type 0 1 and 2 filters
tol_type_012=[0.010, 0.025, 0.041];

% composite sloping bandwidth error 
% tolerance for type 0 1 and 2 filters
tol_type_AA_A_B_C_D=[0.013, 0.025, 0.050, 0.100, 0.100];


% Plot the rms levels 
if any(isequal(method, 1))

    num_sampl_rates=length(Fs);
    for e1=1:num_sampl_rates;

        figure(e1);
        bb=squeeze(SP_levels_a(e1, :, :));
        v = diag(bb);
        semilogx(F_sig, v, 'g', 'Linewidth', 2);
        hold on;
        semilogx([min(F_sig), max(F_sig)], SP_theo_level_on*[1 1], 'k', 'Linewidth', 3);
        xlim([min(F_sig), 0.35*Fs(e1)]);
        ylim([87, 95]);
        title( {[ file_str{1}, ' Third Oct Filter Bank'], ['Sampling Rate ', num2str(round(Fs(e1)/1000)), ' KHZ']}, 'Interpreter', 'none', 'Fontsize', 40);
        set(gca, 'Fontsize', 28);
        set( gca, 'XTickMode', 'manual', 'XTick', f_plot, 'XTickLabel', f_str);
        ylabel('Sound Level dB', 'Fontsize', 28);
        xlabel('Third Octave Band Hz', 'Fontsize', 28);
        legend('Actual', 'Theoretical', 'Location', 'SouthEast' );


        % Save the plots to Fig and Tiff File formats
        save_a_plot_reverb_time(2, [file_str{1}, '_', num2str(N), 'th_oct_levels_', num2str(round(Fs(e1)/1000)), '_KHZ'], 1);
        save_a_plot_reverb_time(6, [file_str{1}, '_', num2str(N), 'th_oct_levels_', num2str(round(Fs(e1)/1000)), '_KHZ'], 1);

        delete(e1);
        figure(e1);
        bb=squeeze(SP_levels_a(e1, :, :));
        v = diag(bb);
        semilogx(F_sig, -SP_theo_level_on+v, 'g', 'Linewidth', 2);
        hold on;
        semilogx([min(F_sig), max(F_sig)], 0*[1 1], 'k', 'Linewidth', 3);
        xlim([min(F_sig), 0.35*Fs(e1)]);
        ylim([-4, 4]);
        title( {[ file_str{1}, ' Error Third Oct Filter Bank'], ['Sampling Rate ', num2str(round(Fs(e1)/1000)), ' KHZ']}, 'Interpreter', 'none', 'Fontsize', 40);
        set(gca, 'Fontsize', 28);
        set( gca, 'XTickMode', 'manual', 'XTick', f_plot, 'XTickLabel', f_str);
        ylabel('Sound Level Error dB', 'Fontsize', 28);
        xlabel('Third Octave Band Hz', 'Fontsize', 28);
        legend('Actual', 'Theoretical', 'Location', 'SouthEast' );
        
        % Save the plots to Fig and Tiff File formats
        save_a_plot_reverb_time(2, ['Error_', file_str{1}, '_', num2str(N), 'th_oct_levels_', num2str(round(Fs(e1)/1000)), '_KHZ'], 1);
        save_a_plot_reverb_time(6, ['Error_', file_str{1}, '_', num2str(N), 'th_oct_levels_', num2str(round(Fs(e1)/1000)), '_KHZ'], 1);
        
    end

end


% Plot the peak levels 
if any(isequal(method, 2))

    num_sampl_rates=length(Fs);
    for e1=1:num_sampl_rates;

        % Plot the Absolute Values of the Sound Pressure Level
        figure(num_sampl_rates+e1);
        bb=squeeze(SP_peak_levels_a(e1, :, :));
        v = diag(bb);
        semilogx(F_sig, v, 'g', 'Linewidth', 2);
        hold on;
        semilogx([min(F_sig), max(F_sig)], SP_theo_peak_on*[1 1], 'k', 'Linewidth', 3);
        xlim([min(F_sig), 0.35*Fs(e1)]);
        ylim([90, 98]);
        title( {[  file_str{2},  ' Third Oct Filter Bank'], ['Sampling Rate ', num2str(round(Fs(e1)/1000)), ' KHZ']}, 'Interpreter', 'none', 'Fontsize', 40);
        set(gca, 'Fontsize', 28);
        set( gca, 'XTickMode', 'manual', 'XTick', f_plot, 'XTickLabel', f_str);
        ylabel('Sound Peak Level dB', 'Fontsize', 28);
        xlabel('Third Octave Band Hz', 'Fontsize', 28);
        legend('Actual', 'Theoretical', 'Location', 'SouthWest' );

        % Save the plots to Fig and Tiff File formats
        save_a_plot_reverb_time(2, [file_str{2}, '_', num2str(N), 'th_oct_levels_', num2str(round(Fs(e1)/1000)), '_KHZ'], 1);
        save_a_plot_reverb_time(6, [file_str{2}, '_', num2str(N), 'th_oct_levels_', num2str(round(Fs(e1)/1000)), '_KHZ'], 1);

        % Plot the Relative Values of the Sound Pressure Level
        delete(num_sampl_rates+e1);
        figure(num_sampl_rates+e1);
        bb=squeeze(SP_peak_levels_a(e1, :, :));
        v = diag(bb);
        semilogx(F_sig, -SP_theo_peak_on+v, 'g', 'Linewidth', 2);
        hold on;
        semilogx([min(F_sig), max(F_sig)], 0*[1 1], 'k', 'Linewidth', 3);
        xlim([min(F_sig), 0.35*Fs(e1)]);
        ylim([-4, 4]);
        title( {[  file_str{2},  ' Error Third Oct Filter Bank'], ['Sampling Rate ', num2str(round(Fs(e1)/1000)), ' KHZ']}, 'Interpreter', 'none', 'Fontsize', 40);
        set(gca, 'Fontsize', 28);
        set( gca, 'XTickMode', 'manual', 'XTick', f_plot, 'XTickLabel', f_str);
        ylabel('Sound Peak Error Level dB', 'Fontsize', 28);
        xlabel('Third Octave Band Hz', 'Fontsize', 28);
        legend('Actual', 'Theoretical', 'Location', 'SouthWest' );

        % Save the plots to Fig and Tiff File formats
        save_a_plot_reverb_time(2, ['Error_', file_str{2}, '_', num2str(N), 'th_oct_levels_', num2str(round(Fs(e1)/1000)), '_KHZ'], 1);
        save_a_plot_reverb_time(6, ['Error_', file_str{2}, '_', num2str(N), 'th_oct_levels_', num2str(round(Fs(e1)/1000)), '_KHZ'], 1);
        
    end

end

