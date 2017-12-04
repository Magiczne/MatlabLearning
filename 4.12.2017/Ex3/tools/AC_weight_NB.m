function [Wa, Wc]=AC_weight_NB(f, output_units, one_or_two_sided)
% % AC_weight_NB: Calculates the A and C frequency weights at specified frequencies 
% % 
% % Syntax;  
% % 
% % [Wa, Wc]=AC_weight_NB(f, flag);
% % 
% % ***********************************************************
% % 
% % Description
% %
% % This program calculates the attentuation factors for the A-weighting
% % and C-weighting frequency filters given the frequencies of interest.  
% %
% % [Wa]=AC_weight_NB(f);
% % 
% % Returns Wa (dB) a numeric array of A-weighting frequency filter 
% % attenuation factors at each frequency in the input vector f (Hz). 
% % Wa is the vector of attenuation factor in dB and f is the input 
% % vector of frequencies in (Hz).  
% % 
% % [Wa, Wc]=AC_weight_NB(f);
% % Returns Wc (dB) a numeric array of C-weighting frequency filter 
% % attenuation factors.  
% % 
% % [Wa, Wc]=AC_weight_NB(f, output_units);
% % output_units=0; Returns Wa and Wc in (dB).
% % output_units=1; Returns Wa and Wc as attenuation ratios.  
% % 
% % [Wa, Wc]=AC_weight_NB(f, output_units, one_or_two_sided);  
% % one_or_two_sided=0; Returns Wa and Wc in the same frequencies as f.
% % one_or_two_sided=1; Returns Wa and Wc in a two sided frequency array 
% % f is symmetrically copied about the nyquist frequency assuming that 
% % the nyquist frequency is max(f)/2. 
% % 
% % if one_or_two_sided=1; then the input vector f becomes 
% % f = [f(1:floor(end/2)) fliplr(f(1:ceil(end/2)))];
% % 
% % 
% % ***********************************************************
% % 
% % Input Variables
% % 
% % f=200:     % (Hz) is a numeric array of frequencies to calculate the 
% %            % A and C attenuation factors of the frequency weighting 
% %            %         filter values.  
% %            % 
% %            % default is the third octave bands from 20 Hz to 20 KHz
% % 
% % output_units=0; % is a scalar boolean which specifies the units of the 
% %                 % attenuation factor of the frequency of the frequency weighting 
% %                 % filter values.  
% %                 % 0 is for dB and 1 is for ratio.  
% %                 % 
% %                 % default is output_units=0;
% % 
% % one_or_two_sided=0; % is a scalar boolean which specifies whether to
% %                     % use f or to modify f by making it symmetric about 
% %                     % the nyquist frequency. 
% %                     % 0 just uses f as it is input.
% %                     % 1 modifies f by the formula
% %                     % f = [f(1:floor(end/2)) fliplr(f(1:ceil(end/2)))];
% %                     % default is one_or_two_sided=0;
% % 
% % ***********************************************************
% % 
% % Output Variables
% % 
% % Wa is a numeric array of A-weighting attenuation factors of the  
% %            frequency filter values in specified units at the 
% %            specified frequencies.  
% % 
% % Wc is a numeric array of C-weighting attenuation factors of the  
% %            frequency filter values in specified units at the 
% %            specified frequencies.  
% % 
% % ***********************************************************
% 
%
% Example='1';
%
% % The audiometric frequency range is 20 Hz to 20000 Hz.
% % Make a plot of the A and C weighting attenuation factors.
%
% f=20:1:20000;
% [Wa, Wc]=AC_weight_NB(f);
% 
% figure(1);
% semilogx(f, Wa, 'r');
% hold on;
% semilogx(f, Wc, 'b');
% legend('A-Weighting', 'C-Weighting', 'Location', 'southeast');
% xlabel('Frequency (Hz)', 'Fontsize', 18);
% ylabel('Attenuation Factors (dB ref. 20\muPa)', 'Fontsize', 18);
% title('Frequency Weighting Filter Functions for Sound', 'Fontsize', 20);
% set(gca, 'Fontsize', 14);
% 
% 
% 
% Example='2';
%
% % The frequency range for impulsive noise can reach up to 1 MHz .
% % Make a plot of the A and C weighting attenuation factors.
% % Using 1/12 octave bands from 20 HZ to 1 MHz.
%  
% N=12;        % twelve equal divisions per octave
% min_f=20;    % minimum frequency
% max_f=10^6;  % maximum frequency
% 
% [f]=nth_freq_band(N, min_f, max_f);
% 
% [Wa, Wc]=AC_weight_NB(f);
% 
% figure(2);
% semilogx(f, Wa, 'r');
% hold on;
% semilogx(f, Wc, 'b');
% legend('A-Weighting', 'C-Weighting', 'Location', 'northeast');
% xlabel('Frequency (Hz)', 'Fontsize', 18);
% ylabel('Attenuation Factors (dB ref. 20\muPa)', 'Fontsize', 18);
% title('Frequency Weighting Filter Functions for Sound', 'Fontsize', 20);
% set(gca, 'Fontsize', 14);
% 
% 
% 
% Example='3';
%
% % The frequency range for a narrow band fft at a sampling rate of 50 KHz 
% % is 1 to 25000 Hz.  
% % 
% % Make a plot of the A and C weighting attenuation factors for 
% % simulated data.
%  
% f=1:1:25000;
% % Use the ratio method
% [Wa, Wc]=AC_weight_NB(f, 1);
% 
% Fs=50000;
% x=randn(100000, 1);
% bin_size=50000;
% num_averages=100;
% [SP]=pressure_spectra(x, Fs, bin_size, num_averages );
% 
% figure(3);
% Pref=20*10^(-6);
% semilogx(f, 20*log10(SP./Pref), 'k');
% hold on;
% semilogx(f, 20*log10(SP.*Wa./Pref), 'r');
% semilogx(f, 20*log10(SP.*Wc./Pref), 'b');
% legend('Linear-Weighting', 'A-Weighting', 'C-Weighting', 'Location', 'southeast');
% xlabel('Frequency (Hz)', 'Fontsize', 18);
% ylabel('Sound Pressure (dB ref. 20\muPa)', 'Fontsize', 18);
% title('Frequency Weighting Sound Spectra', 'Fontsize', 20);
% set(gca, 'Fontsize', 14);
% 
% 
% 
% Example='4';
%
% % The frequency range for a narrow band fft at a sampling rate of 50 KHz 
% % is 1 to 25000 Hz.  
% % 
% % Make a plot of the A and C weighting attenuation factors for 
% % simulated data.
% % Using 1/3 octave bands from 20 HZ to 20 KHz.
%  
% N=3;          % three equal divisions per octave
% min_f=20;     % minimum frequency
% max_f=20000;  % maximum frequency
% 
% [f]=nth_freq_band(N, min_f, max_f);
% % Use the dB method
% [Wa, Wc]=AC_weight_NB(f, 0);
% 
% Fs=50000;
% x=randn(100000, 1);
% num_x_filter=2;
% [fc_out, SP_levels, SP_peak_levels, SP_bands]=Nth_oct_time_filter2(x, Fs, num_x_filter, N, f);
% 
% 
% figure(4);
% semilogx(f', SP_levels, 'k');
% hold on;
% semilogx(f', SP_levels+Wa', 'r');
% semilogx(f', SP_levels+Wc', 'b');
% legend('Linear-Weighting', 'A-Weighting', 'C-Weighting', 'Location', 'southeast');
% xlabel('Frequency (Hz)', 'Fontsize', 18);
% ylabel('Sound Pressure (dB ref. 20\muPa)', 'Fontsize', 18);
% title('Frequency Weighting Sound Spectra', 'Fontsize', 20);
% set(gca, 'Fontsize', 14);
% 
% 
% 
% 
% Example='5';
%
% % The frequency range for a narrow band fft at a sampling rate of 50 KHz 
% % is 1 to 25000 Hz.  
% % 
% % Make a plot of the A and C weighting attenuation factors for 
% % simulated data.
% % Using 1/3 octave bands from 20 HZ to 20 KHz.
%  
% N=3;          % three equal divisions per octave
% min_f=20;     % minimum frequency
% max_f=20000;  % maximum frequency
% 
% [f]=nth_freq_band(N, min_f, max_f);
% % Use the dB method
% [Wa, Wc]=AC_weight_NB(f, 0);
% 
% Fs=50000;
% x = spatialPattern([100000,1], -1);
% num_x_filter=2;
% [fc_out, SP_levels, SP_peak_levels, SP_bands]=Nth_oct_time_filter2(x, Fs, num_x_filter, N, f);
% 
% 
% figure(5);
% 
% semilogx(f', SP_levels, 'k');
% hold on;
% semilogx(f', SP_levels+Wa', 'r');
% semilogx(f', SP_levels+Wc', 'b');
% legend('Linear-Weighting', 'A-Weighting', 'C-Weighting', 'Location', 'southeast');
% xlabel('Frequency (Hz)', 'Fontsize', 18);
% ylabel('Sound Pressure (dB ref. 20\muPa)', 'Fontsize', 18);
% title('Frequency Weighting Sound Spectra of Pink Noise', 'Fontsize', 20);
% set(gca, 'Fontsize', 14);
% 
% 
% 
% % ***********************************************************
% % 
% % References
% % 
% % Reference American National Standard for Speicification for Sound Level
% % Meters ANSI S1.4-1983.  
% %    Table IV. Random incidence relative response level as a function of
% %              frequency for various weightings
% %    Appendix C: relative Response of Frequency Weighting Characteristic
% % 
% % ***********************************************************
% % 
% % 
% % Subprograms
% %
% % 
% % List of Dependent Subprograms for 
% % AC_weight_NB
% % 
% % 
% % Program Name   Author   FEX ID#
% %  1) convert_double		
% %  2) estimatenoise		John D'Errico		16683	
% %  3) filter_settling_data		
% %  4) flat_top		
% %  5) moving		Aslak Grinsted		8251	
% %  6) nth_freq_band		
% %  7) Nth_oct_time_filter2		
% %  8) Nth_octdsgn		
% %  9) number_of_averages		
% % 10) pressure_spectra		
% % 11) sd_round		
% % 12) spatialPattern		Jon Yearsley		5091	
% % 13) spectra_estimate		
% % 14) sub_mean		
% % 15) window_correction_factor		
% % 16) wsmooth		Damien Garcia		NA	
% % 
% % 
% % ***********************************************************
% % 
% % Written by William J. Murphy, October 3, 2003
% % 
% % modified by Edward Zechmann 
% % 
% % modified 23 September   2008    Updated Comments
% % 
% % modified  7 January     2008    Updated Comments
% % 
% % ***********************************************************
% % 
% % Please feel free to modify this code.
% % 
% % See also: Leq_all_calc, ACdsgn, adsgn, cdsgn, Aweight_time_filter, Cweight_time_filter, resample
% % 


% This code is added to help find the dependent functions to run the
% examples
void_call=0;
if void_call
    pressure_spectra(0);
    spatialPattern(0);
    nth_freq_band(0);
    Nth_oct_time_filter2(0);
end


if (nargin < 1 || isempty(f)) || ~isnumeric(f)
     f=[20 25 31 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
end

if (nargin < 2 || isempty(output_units)) || ~isnumeric(output_units) 
    output_units=0;
end

if ~isequal(output_units, 1)
    output_units=0;
end
    
if (nargin < 3 || isempty(one_or_two_sided)) || ~isnumeric(one_or_two_sided) 
    one_or_two_sided=0;
end

if ~isequal(one_or_two_sided, 1)
    one_or_two_sided=0;
end


% Define the filter constants

K1 =     2.242881e16;
K2 =     1.025119;
K3 =     1.562339;
f1 =    20.598997;
f2 =   107.65265;
f3 =   737.86223;
f4 = 12194.22;
f5 =   158.48932;

% Extend the frequency vector to double sided if necessary
if isequal(one_or_two_sided, 1)
    [m1, n1]=size(f);
    
    if m1 > n1
        f=f';
    end
    
    f = [f(1:floor(end/2)) fliplr(f(1:ceil(end/2)))];
end


switch output_units
    
    case 0
        
        Wc = 10.*log10((K1.*f.^4)./((f.^2 + f1.^2).^2 .*(f.^2 +f4.^2).^2));
        Wa = 10.*log10((K3.*f.^4)./((f.^2 + f2.^2).*(f.^2 + f3.^2))) + Wc;
        
    case 1
        
        Wc = (K1.*f.^4)./((f.^2 + f1.^2).^2 .*(f.^2 +f4.^2).^2);
        Wa = (K3.*f.^4)./((f.^2 + f2.^2).*(f.^2 + f3.^2)).*Wc;
        
    otherwise
        
        Wc = 10.*log10((K1.*f.^4)./((f.^2 + f1.^2).^2 .*(f.^2 +f4.^2).^2));
        Wa = 10.*log10((K3.*f.^4)./((f.^2 + f2.^2).*(f.^2 + f3.^2))) + Wc; 
        
end

