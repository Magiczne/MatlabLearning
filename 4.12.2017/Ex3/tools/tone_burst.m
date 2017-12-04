function [y, t]=tone_burst(Fs, fc, td, delay, num_waves, A1, A2)
% % sinusoidal_w_wave: N wave with known peak level, frequency and duration
% % 
% % Syntax:
% %
% % [y, t]=tone_burst(Fs, fc, td, delay, num_waves, A1, A2);
% %
% % *********************************************************************
% % 
% % Description
% % 
% % This program produces an impulsive test signal 
% % 
% % The signal is a sinusoidal N-wave.  
% % 
% % *********************************************************************
% % 
% % Input Variables
% % 
% % Fs=50000;           % Hz sampling rate of the impulsive noise
% %                     % default is Fs=50000;
% % 
% % fc=1000;            % Hz ringing frequency of sin wave
% %                     % default is fc=1000; 
% % 
% % td=1;               % seconds time duration of the test signal
% %                     % default is td=1; 
% % 
% % delay=1;            % seconds time delay between impulsive noise 
% %                     % and test signal recording.
% %                     % default is delay=1; 
% % 
% % num_waves=6;        % Number of full sin waves in tone burst
% %                     % default is num_waves=6; 
% % 
% % A1=1;               % Pa amplitude of the background gaussian noise
% %                     % default is A1=1;
% % 
% % A2=100;             % Pa initial ampitude of the of the sin wave
% %                     % default is A2=100;
% %   
% % 
% % *********************************************************************
% % 
% % Output variables
% % 
% % y the time record in Pa
% % 
% % t the time array in seconds
% % 
% % *********************************************************************
% 
% 
% Example='';
% 
% % Each of the inputs can be a constant or a one-dimensional array.
% 
% Fs=100000;    % Hz sampling rate of the impulsive noise
% 
% fc=1000;      % Hz ringing frequency of sin wave
% 
% td=1;         % seconds time duration of the test signal
% 
% delay=0.1;    % seconds time delay between impulsive noise 
%               % and test signal recording\
% 
% num_waves=6;  % Number of full sin waves in tone burst
%               % default is num_waves=6; 
% 
% A1=1;         % Pa amplitude of the background gaussian noise
% 
% A2=20;        % Pa initial ampitude of the of the sin wave
% 
% [y, t]=tone_burst(Fs, fc, td, delay, num_waves, A1, A2);
% 
%
% figure(1);
% subplot(3,1,1); 
% plot(t, y); 
% hold on; 
% subplot(3,1,2); 
% plot(t, gradient(y)); 
% subplot(3,1,3); 
% plot(t, gradient(gradient(y)));
% 
%
% figure(2);
% plot(t, Fs/(2*pi).*gradient(unwrap(angle(hilbert(y)))));
% title('instantaneous Frequency Hz');
% 
% % *********************************************************************
% % 
% % Program Written by Edward L. Zechmann
% %    
% %     Date  17 December    2007
% % 
% % modified  18 December    2007    Added Comments
% % 
% % modified  21 August      2008    Updated Comments
% % 
% % modified  15 September   2008    Updated Comments
% % 
% % modified   3 December   2008    Updated Comments
% % 
% % *********************************************************************
% % 
% % Please Feel Free to Modify This Program
% %    
% % See Also: analytic_impulse, freidlander, Impulsive_Noise_Meter   
% %    

if nargin < 1 || isempty(Fs) || ~isnumeric(Fs)
    Fs=50000;
end

if nargin < 2 || isempty(fc) || ~isnumeric(fc)
    fc=1000;
end

if nargin < 3 || isempty(td) || ~isnumeric(td)
    td=5; 
end

if nargin < 4 || isempty(delay) || ~isnumeric(delay)
    delay=1;
end

if nargin < 5 || isempty(num_waves) || ~isnumeric(num_waves)
    num_waves=6;
end

if nargin < 6 || isempty(A1) || ~isnumeric(A1)
    A1=1;
end

if nargin < 7 || isempty(A2) || ~isnumeric(A2)
    A2=100;
end



% All of the inputs are scalars.
Fs=Fs(1);
fc=fc(1);
td=td(1);
delay=delay(1);
num_waves=num_waves(1);
A1=A1(1);
A2=A2(1);


% The number of waves must be a counting number
num_waves=round(num_waves);
if num_waves < 1
    num_waves=1;
end


% Compute the number of data points for the delay
N0=ceil(Fs*delay);

% Compute the number of data points in the time record
num_points=ceil(Fs*td);


% Compute the number of points in half a wave
N=floor(Fs./fc/2);


% Compute all the points necessary to make teh waves adn bring them to
% smoothly to rest.
num_wave_points=(num_waves+1)*2*N;


% The nubmer of points in the time record must be greater than the sum of the delay
% and the waves.
num_points=max(num_points, N0+num_wave_points);

% Make the time variable for starting the wave and bringing the wave to 
% rest.
t0=1./Fs.*(0:(N-1));

% Make the time variable for the waves.
t1=1./Fs.*(0:(num_waves*2*N-1));

% Make the amplitude variable for starting the wave and bringing the wave  
% to rest.
b= A2.*0.5*(1+sin(-pi/2+2*pi*fc.*t0));

% Make the amplitude variable for the waves.
bb=A2.*sin(pi/2+2*pi*fc.*t1);

% generate the amplitude time record if necessary
if nargout > 0
    y=A1.*randn(1, num_points);
    y(1, N0+(1:((num_waves+1)*2*N)))=y(1, N0+(1:((num_waves+1)*2*N)))+[b bb fliplr(b)];
end

% generate the time variable if necessary
if nargout > 1
    t=1./Fs.*(0:(num_points-1));
end
