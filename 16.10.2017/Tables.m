clear all;
clc;
Lp=[1;2;3;4;5;6;7;8;9;10];
Nazwisko = {'Smith';'Johnson';'Williams';'Jones';'Brown';'Smith';'Johnson';'Williams';'Jones';'Brown'};
Imie={'Karol';'Maria';'Mateusz';'Anna';'Jan';'Maria';'Mateusz';'Anna';'Jan';'Piotr'};
Wiek = [38;43;38;40;49;43;38;40;49;38];
Waga = [71;69;64;67;64;69;64;67;64;55];
Wzrost = [176;163;131;133;119;163;131;133;119;201];
CisnienieKrwi = [124 93; 109 77; 125 83; 117 75; 122 80;124 93; 109 77; 125 83; 117 75; 122 80];
T = table(Lp,Imie,Nazwisko,Wiek,Wzrost,Waga,CisnienieKrwi);
% doÅ‚oÅ¼enie nowej kolumny 
T.BMI = (T.Waga*0.453592)./(T.Wzrost*0.0254).^2;
T(:,:)

% Najmlodsza i najwiekszy wzrost
x = find((T.Wiek == min(T.Wiek)) & (T.Wzrost == max(T.Wzrost)));
T(x, :);

%BMI poni¿ej dwóch i najwiêksza waga
y = find((T.BMI < 2) & (T.Waga == max(T.Waga)));
T(y, :);

% Najmniejszy wiek, najwieksze BMI
z = find((T.BMI == max(T.BMI)) & (T.Wiek == min(T.Wiek)));
T(z, :);

% Najmniejszy wiek
tic
aa = find(T.Wiek == min(T.Wiek));
toc
