%Regulator DMC
T=100;
Tp=0.5;
Y = 0:Tp:T;
U = 0:Tp:T;
k=size(Y);
yzad=1;
N=47;
D=60;
Nu=8;
lambda=10;
Yk=zeros(N,1);
Yzad=zeros(N,1);
a1=-1.6941; a0=0.7151; b1=0.0533; b0=0.0477;

for i= 1:k(2)
    Y(i)=0;
    U(i)=0;
end
%Wyznaczanie odpowiedzi skokowej
U(1)=yzad;
for i = 1:k(2)
    for j=1:11
        U(13-j)=U(12-j);
    end
    if i>2
        Y(i)=b1*U(11)+b0*U(12)-a1*Y(i-1)-a0*Y(i-2); 
    end
end

S=Y;

for i= 1:T/Tp
    Y(i)=0;
    U(i)=0;
end
for i=1:N
    Yzad(i,1)=yzad;
end
for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)=S(i-j+1);
      end;
   end;
end;
Mp=zeros(N,D-1);
for i=1:D-1
    for j=1:N
        if i+j<=N
            Mp(j,i)=S(i+j)-S(i);
        else
            Mp(j,i)=S(N)-S(i);
        end
    end
end
dUp=zeros(D-1,1);
%Symulacja
for i = 1:T/Tp
    if i>12
         Y(i)=b1*U(i-11)+b0*U(i-12)-a1*Y(i-1)-a0*Y(i-2);
    else
        Y(i)=0;
    end
    
    Y0=Yk+Mp*dUp;
    K=(M'*M+lambda*eye(Nu))\M';
    delUk=K(1,:)*(Yzad-Y0);
    if i>1
        U(i)=U(i-1)+delUk;
    else
        U(1)=delUk;
    end
    for j=1:(D-2)
        dUp(D-j)=dUp(D-1-j);
    end
    
    for j=1:N
        Yk(j,1)=Y(i);
    end
    dUp(1)=delUk;
end

subplot(211)
stairs(0:Tp:T, Y);
xlabel('time(s)');
ylabel('y');
ylim([0 2]); hold on
subplot(212)
stairs(0:Tp:T, U);
xlabel('time(s)');
ylabel('u');
ylim([0 2]);
hold on