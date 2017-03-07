%inicjalizacja
K=0.443;
Tk=19.3575;
Kr=0.6*K;
Ti=0.5*Tk;
Td=0.12*Tk;
Tp=0.5;
a1=-1.6941; a0=0.7151; b1=0.0533; b0=0.0477;
r2=(Kr*Td)/Tp;
r1=Kr*(Tp/(2*Ti) -2*(Td/Tp) -1 );
r0=Kr*(1+Tp/(2*Ti) + Td/Tp);

kk=150;

%warunki pocz¹tkowe
u(1:12)=0; y(1:12)=0;
yzad(1:12)=0; yzad(12:kk)=1;
e(1:12)=0;
for k=13:kk; %glówna petla symulacyjna
    %symulacja obiektu
    y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
    %uchyb regulacji
    e(k)=yzad(k)-y(k);
    %sygnal steruj¹cy regulatora PID
    u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
end;

subplot(211)
stairs( y);
xlabel('k');
ylabel('y');
ylim([0 2]); hold on
subplot(212)
stairs(u);
xlabel('k');
ylabel('u');
ylim([0 2]);
hold on
