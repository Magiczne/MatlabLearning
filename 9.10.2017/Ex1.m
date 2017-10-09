clear all;
clc;

Mg = [ 1 -2 3;
       3  1 4;
       2  5 1 ];
  
Mx = [ -7 -2 3;
        5  1 4;
       18  5 1 ];
   
My = [ 1 -7 3;
       3  5 4;
       2 18 1 ];
   
Mz = [ 1 -2 -7;
       3  1 5;
       2  5 18 ];
   
Mw = [ -7; 5; 18 ];
   
x = det(Mx) / det(Mg);
y = det(My) / det(Mg);
z = det(Mz) / det(Mg);

xyz = inv(Mg) * Mw;