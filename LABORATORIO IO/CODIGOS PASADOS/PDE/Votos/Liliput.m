Malo = [500 1000 2000 4000
        600 4000 7000 9000
        400 2000 6000 10000];
Bueno = [100 3000 5000 8000
         200 8000 14000 12000
         300 3000 5000 8000];
p = [0.63 0.37];
M1 = [0 200 400 600];
M2 = [0 200 400 600];
a = size(Malo,1);
b = size(M1,2);
q = size(M2,2);
M3 = zeros(a+1,b);
M4 = zeros(a,b);

for i = a:-1:1
    fprintf(['Etapa ',num2str(i),'\n'])
    fd = zeros(b,q+2);
    Var = zeros(2,1);
    for j = 1:b
        for k = 1:q
            if M1(j) >= M2(k)
                Var(1,1) = Malo(i,k) + M3(i+1,max(1,j-k));
                Var(2,1) = Bueno(i,k) + M3(i+1,j-k+1);
                fd(j,k) = p*Var;
            end
            if(fd(j,k)>fd(j,q+1))
                fd(j,q+1) = fd(j,k);
                fd(j,q+2) = M2(k);
            end
        end
    end
    fd
    M3(i,:) = fd(:,q+1);
    M4(i,:) = fd(:,q+2);
end
M3
M4
                
             