function sound = generate_sound(f, tr, fs)
    % f     - Czêstotliwoœæ
    % tr    - Czas trwania
    % fs    - Czêstotliwoœæ próbkowania
    
    t = 0 : 1/fs : tr;
    
    % Obwiednia sygna³u
    x = t / tr;
    envelope = x .* (1-x) .* (exp(-8*x) + 0.5 * x .* (1-x));
    b = 0.02;
    
    % Harmoniczne
    harm1 = sin(2*pi*f*t*(1-b)) + sin(2*pi*f*t*(1+b));
%     harm2 = sin(2*pi*2*f*t*(1-b)) + sin(2*pi*2*f*t*(1+b));
%     harm3 = sin(2*pi*3*f*t*(1-b)) + sin(2*pi*3*f*t*(1+b));
    
    % Po³¹czenie obwiedni i sk³adowych harmonicznych
%     sound = envelope .* (harm1 + 0.2 * harm2 + 0.05 * harm3);
    sound = envelope .* harm1;
    
    % Normalizacja amplitudy
    sound = sound / max(sound);
    