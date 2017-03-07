s = tf('s');
Tp = 0.5;
i = 1;
K0 = ones(1, 11)*3;
for T = 5:0.5:10 %iteracja po kolejnych T0
    for m = 0:4 %iteracja po kolejnych cyfrach K
        for n = 1:9 %kolejne wartości aktualnej cyfry
            K = n*10^(-m)+K0(i);
            G = (K*exp(-T*s))/((2.22*s+1)*(4.54*s+1)); %transmitancja
           % w = gettfdata(G, Tp); %parametry do rownania roznicowego (moja funkcja)
            [y, t] = fpid(w, T); %symulacja dla danych parametrow i opoznienia (moja funkcja)
            %[y, t] = fdmc(w, T); %jw
            peaks = findpeaks(y); %znajduje wszystkie maksima lokalne y
            if peaks(end) - peaks(5) > 0.01 %jezeli kolejne maksima lokalne sa coraz wieksze
                K0(i) = K - 10^(-m); %zapisanie wartosci K0 dla aktualnego T
            break
            end
        end
    end
    i = i + 1;
end
        
%plot(t, y)