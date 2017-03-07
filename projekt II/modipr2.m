K=4.8;
T0=5;
T1=2.22;
T2=4.54;
Tp=0.5;
m=[10.0788 6.76 1]; % mianownik
opoznienie= -T0/Tp;
[licznik , mianownik] = c2dm( K, m,Tp,'zoh');
licznik=[ 0    0.0533    0.0477];
mianownik=[1.0000   -1.6941    0.7151];

trans_ciagla=tf(K,m,'InputDelay',T0); % wyznaczam trans ci¹g³¹
trans_dyskr=c2d(trans_ciagla,Tp,'zoh'); % wyznaczam trans dyskretn¹

[y1 t]=step(trans_ciagla); % odp skokowa trans ci¹g³ej
[y2 t2]=step(trans_dyskr);  % odp skokowa trans dyskretnej

% 
 plot(t,y1);
hold on;
stairs(t2,y2);
title('Porownanie odpowiedzi ukladu ciaglego i dyskretnego');
xlabel('czas symulacji');
ylabel('wyjscie ukladu');
legend('odpowiedz analogowa','odpowiedz cyfrowa');

Kr=0.443;
trans_ciagla_ze_sprzerzeniem=feedback(Kr*trans_ciagla,1)% tworze sprzê¿enie zwrotne
[y3 t3]=step(trans_ciagla_ze_sprzerzeniem);
 plot(t3,y3);

%okres wyznaczach na podstawie najmniejszej odleglosci miedzy wartosciami
var counter;
for i=2:100
    if y3(i)<y3(i-1)
        counter=i;
        break
    end
end
var counter2;
for i=counter+5:100
    if(abs(y3(counter)-y3(i))<0.001||y3(counter)<y3(i))
        counter2=i;
        break
    end
end

Tk=t3(counter2)-t3(counter); % okres
Kk=0.6*Kr;
Ti=0.5*Tk;
Td=0.12*Tk;

PID = pid(Kk,Kk*1/Ti,Kk*Td);
reg_trans = feedback(PID*trans_ciagla,1);
[y4 t4] = step(reg_trans);
plot(t4,y4);

r2=(Kr*Td)/Tp;
r1=Kr*(Tp/(2*Ti) -2*(Td/Tp) -1 );
r0=Kr*(1+Tp/(2*Ti) + Td/Tp);



