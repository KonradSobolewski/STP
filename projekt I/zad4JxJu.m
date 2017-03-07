%JEDNAKOWE BIEGUNY
X = [5, -1, 3]';
i = 1;
for z = 0:0.025:0.4
    kkonc = 0;
    sumx = 0;
    sumu = 0;
   
    Ktemp = acker(A2,B2,[z z z]);

    for k = 1:50
        U(k) = -Ktemp*X(:,k);
        X(:,k+1) = [A2(1,1)*X(1,k)+X(2,k)+B2(1)*U(k) A2(2,1)*X(1,k)+X(3,k)+B2(2)*U(k) A2(3,1)*X(1,k)+B2(3)*U(k)];
    end
    for k = 1:50
        if X(1,k) > 0.0001 || X(2,k) > 0.0001 || X(3,k) > 0.0001
            kkonc = kkonc+1;
        end
    end
    for j = 1:kkonc
        sumx = sumx + X(1,j)^2 + X(2,j)^2 + X(3,j)^2;
        sumu = sumu + U(j)^2;
    end

    Jx(i) = sumx/kkonc;
    Ju(i) = sumu/kkonc;
    i = i+1;
end

z = 0:0.025:0.4;
figure;
plot(z,Jx,'r',z,Ju,'b')
xlabel('z, jednakowe bieguny');
ylabel('Jx - red , Ju - black');


