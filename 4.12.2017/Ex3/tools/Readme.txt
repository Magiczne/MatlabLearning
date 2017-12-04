File Last Modified 5 August 2010


The Nth Octave and AC Filter ToolBox is based on the octave toolbox by   
Christophe Couvreur which is on the Matlab File Exchange ID number 69.
Original Author: Christophe Couvreur, Faculte Polytechnique de Mons 
(Belgium) couvreur@thor.fpms.ac.be.  


This set of progams makes the filters more stable and adds filter settling data to improve accuracy esepcially at startup.  
To accomodate the A and C weighting filters, for high sampling rates > 300 kHz the 
time records are downsampled.  

Iterative resampling is used in the Nth octave band time filter to 
improve the attenuation of the resample program.  

For the A, C, hand arm vibrations, and Nth octave band filters
there are two options for the downsampling filters to optimize
performance for continuous signals or for impulsive signals. 
For continuous noise the time domain does not have significant 
impulses; however, for impulsive time records there are often very
large impulses with distinctive peaks.  

There are two antialiasing filters and interpolation schemes available.
The first program is the built-in Matlab "resample" progam which
uses a Kaiser window fir filter for antialising and uses an unknown 
interpolation method.  The second program available for downsampling 
is bessel_down_sample which uses a Bessel filter for antialiasing 
and uses interp with the cubic spline option for interpolation.  

The resample function has good antialising up to the Nyquist frequency;
however, it has significant ringing effect when there are impulses.  
The bessel_down_sample function has good antialising; however, there is
excessive attenuation near the Nyquist frequency.  
The bessel_down_sample function experiences no ringing due to impulses
so it is very useful for peak estimation.  


Simple testing programs for the A, C, hand arm vibrations, and Nth octave filter 
programs are included.  



* **************************************************************************
*
* List of Most Useful Programs
* 
* **************************************************************************

The following programs were recreated or written by Edward L. Zechmann
Each of the programs has an example to help understand its use.



Leq_all_calc  Calculates the A-weighted, C-weighted and Linear weighted
              sound levels and other metrics given a time record in Pa. 

ACweight_time_filter Applies an A or C weighting filter to a time record 
             and returns the A or C weighted time record.

ACdsgn        Designs A and C weighting filters for use with the program filter.  
              The filters may be more stable than in the octave tool box.   


hand_arm_time_fil     Useful in characterizing hand arm vibrations of powered hand tools. 
                      Applies the hand-arm filters to a time record according to ISO 5349-1.

Nth_oct_time_filter applies a digital filter to a time record and returns the 
              center frequencies, sound levels, peak levels, and time records 
              in each band.  The user specifies the time record, sampling rate, 
              number of bands per octave, minimum frequency, maximum frequency, 
              type of sensor, settling_time, and the filter_program.
             
Nth_oct_time_filter2 very similar to Nth_oct_time_filter but inputs an array 
              fc of center frequencies instaed of min_f and max_f.  


nth_freq_band calculates the one-nth frequency band center frquencies and upper 
              and lower limits.  TEh user sepcifies the number of bands per 
              octave, minimum frequency, maximum frequency.  

Nth_octdsgn designs a digital filter given the sampling rate, cecnter frequency, 
              number of bands per octave, and the order of the butterworth filter.

* **************************************************************************
*
* Filter Testing Programs
* 
* **************************************************************************

Test_ACweight Tests the A and C weighting filters using sinusoids.  
              The examples indicate the accuracy of estimating LeqA, LeqC and Peak levels.  
              The examples output data arrays and plots of the filter tolerances.  

Test_hand_arm Tests the hand-arm vibrations filters using sinusoids.  
              The output data and plots indicate how accurately RMS acceleration of 
              sinusoids can be estimated.  

Test_Nth_oct_filters1 Tests the Nth octave band filters using sinusoids.  
              The program outputs data files and plots which indicate the accuracy 
              of estimating Leq and Peak levels with the 1/3 octave and 1/12 octave 
              band filters.  The examples may take 2 to 12 hours to run.  

Test_Nth_oct_filters1b This is a sub program for Test_Nth_oct_filters1; however 
              it can be run separately for additional testing.


Test_Nth_octave_Band2 Tests the Nth octave band filters Using known spectral distributions.  
              The program creates white, pink, and brown noise and returns the Nth 
              octave band spectra and time records and a plot of the spectra.  
              spatialpattern by Jon Yearsley Fex ID 5091 is called to create the 
              white, pink, and brown noise.  




If you find any bugs or have and questions please post a comment or 
send me an email at ezechma1@hotmail.com 
