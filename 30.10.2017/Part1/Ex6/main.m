
y = rand(3, 10);
y1 = rand(5, 12);
y2 = rand(2, 20);
y3 = rand(1, 5);

% x = [ 1 4 10 25 63 180 400 100 2500 6300 16000 ];
% y = round(rand(1, 11) * 100);
% bar(x, y, 'r');
% xlabel('Hz');
% ylabel('dB');
% grid on;

% 
figure(5);
bar(1:1:45, xxx);
xlabel('Hz');
ylabel('dB');
grid on;

% figure(1);
% % subplot(3, 2, 1:2);
% bar(y, 'group');
% title('wykres s³upkowy typu group- dla y(m,n) m jest liczb¹ wierszy i n jest liczba kolumn w y ');
% colorbar;
% colormap('parula');

% figure(2);
% % subplot(3,2,[3 5]);
% bar(y1,'stack');
% title('wykres s³upkowy typu stack');
% colorbar; 
% colormap('hot');

% figure(13);
% % subplot(3,2,4);
% area(y2);
% title('wykres polowy');
% colorbar; 
% colormap('winter');

% figure(4);
% % subplot(3,2,6);
% pie(y3);
% title('wykres ko³owy');
% colorbar; 
% colormap('copper');