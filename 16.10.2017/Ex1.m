clear all;
clc;

age = input('Enter your age: ');

if age < 5
    disp('Dziecko');	
elseif age < 12 
	disp('Starsze dziecko');
elseif age < 18
	disp('Młodzież');
elseif age < 30
	disp('Trzydziestolateg');
elseif age < 50
	disp('Kryzys wieku średniego');
elseif age < 70
	disp('Staruszek');
else 
	disp('Ktoś inny');
end;