function save_a_plot_reverb_time(a, filename, flag2)
% % save_a_plot_reverb_time: Saves current figure to specified image type.
% %
% % Syntax: save_a_plot_reverb_time(a, filename, flag2);
% %
% % **********************************************************************
% %
% % Description
% %
% % save_a_plot_reverb_time(a, filename, flag2)(a, filename);
% %
% % Saves the current figure to a file named by teh string input filename
% % using the specified format given by the integer a. The default format
% % is pdf.  The default file name is 'default_file_name'.
% %
% % The options for the format are
% %
% % a=1; %  pdf
% % a=2; %  fig
% % a=3; %  jpeg 200 dpi
% % a=4; %  epsc 200 dpi
% % a=5; %  tiff 200 dpi
% % a=6; %  no compression tiff
% %
% % save_a_plot_reverb_time(a, filename, flag2)(a, filename, flag2);
% % orients the paper using the integer option flag2.
% % flag2=1, orients the paper in portrait.
% % For any other value of flag2 the paper is in landscape.
% % The default paper orientation is portrait.
% %
% %
% % **********************************************************************
%
%
% Example='1';
%
% figure(1);
% plot([-1 1],[-1 1]);      % make a figure to save
% a=1;                      % 1 pdf
%                           % 2 fig
%                           % 3 jpeg 200 dpi
%                           % 4 epsc 200 dpi
%                           % 5 tiff 200 dpi
%                           % 6 no compression tiff
%
% filename='straightline';  % The file name is a string
%
% flag2=0;                  % Orient the paper in landscape.
%                           % Values other than 1 result in landscape
%                           % orientation.
%
% save_a_plot_reverb_time(a, filename, flag2);
%
% %
% % **********************************************************************
% %
% % Program Written by Edward L. Zechmann
% %
% %     date    Unknown  2007
% %
% % modified 17 December 2008
% %
% % modified  3 October  2009   Updated Comments
% %
% % **********************************************************************
% %
% % Please feel free to modify this code.
% %
% % See Also: print, saveas, save_a_plot2_audiological
% %

hf=gcf;

if nargin < 1
    a=1;
end

if nargin < 2
    filename='default_file_name';
end

if nargin < 3
    flag2=1;
end

if flag2 == 1
    orientation='portrait';
else
    orientation='landscape';
end

rect=[0.05 0.05 0.9 0.9];

set(hf, 'PaperOrientation', orientation, 'PaperType', 'usletter', 'PaperUnits', 'normalized', 'PaperPosition', rect, 'PaperSize', 0.8*[1 1] );

[filename, ext]=file_extension(filename);

switch a
    
    case 1
        set(hf, 'PaperOrientation', orientation, 'PaperType', 'usletter', 'PaperUnits', 'normalized', 'PaperPosition', rect );
        print(hf, '-dpdf',  filename );
    case 2
        saveas(hf, filename, 'fig'  );
    case 3
        print(hf, '-djpeg', '-r200', filename  );
    case 4
        print(hf, '-depsc2', '-r200', filename  );
    case 5
        print(hf, '-dtiff', '-r200', filename  );
    case 6
        print(hf, '-dtiffn', filename  );
    case 7
        print(hf, '-dmeta', filename  );
    otherwise
        set(hf, 'PaperOrientation', orientation, 'PaperType', 'usletter', 'PaperUnits', 'normalized', 'PaperPosition', rect );
        print(hf, '-dpdf',  filename );

end

