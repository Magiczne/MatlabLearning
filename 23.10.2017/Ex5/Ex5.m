clear all;
clc;

repetitive = 0;
last = 'reszka';

for i = 1:10000
   rnd = rand();

    if rnd > 0.5
        if strcmp(last, 'reszka')
            last = 'orzel';
            repetitive = 0;
        end
        repetitive = repetitive + 1;

        orzel(repetitive)
    else
        if strcmp(last, 'orzel')
            last = 'reszka';
            repetitive = 0;
        end
        repetitive = repetitive + 1;

        reszka(repetitive)
    end 
end