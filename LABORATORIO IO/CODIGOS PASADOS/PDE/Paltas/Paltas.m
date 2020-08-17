Demanda_verdes = [50 100]; %Posibles valores que puede tomar la demanda de verdes 
Demanda_maduras = [50 100];%Posibles valores que puede tomar la demanda de maduras
P_demanda_verdes = [0.4 0.6]; %p. demanda 50,p. demanda 100 en verdes
P_demanda_maduras = [0.5 0.5];%p. demanda 50, p. demanda 100 en maduras
P = P_demanda_verdes' * P_demanda_maduras; %Se crea una matriz de combinaciones [bajobajo,bajoalto;altobajo,altoalto]
Costo_paltas_verdes = [0 100 170 225 300];
a =3;
Venta_verdes = 3;
Venta_maduras = 4;
M1 = [0 50 100 150]; %Disponibilidad paltas maduras
M2 = [0 50 100 150 200]; %Paltas verdes a comprar
b = size(M1,2);
q = size(M2,2);
M3 = zeros(a+1,b);
M4 = zeros(a,b);

for i = a:-1:1
    fd = zeros(b,q+2);
    fprintf(['Etapa ',num2str(i),'\n'])
    for j = 1:b
        for k = 1:q
            var = zeros(size(P));
            for v = 1:size(P,2)
                for m = 1:size(P,1)
                    var(v,m) = P(v,m)*(Venta_verdes*min(Demanda_verdes(v),M2(k))+Venta_maduras*min(Demanda_maduras(m),M1(j))- Costo_paltas_verdes(k)+2*min(0,M1(j)-Demanda_maduras(m))+M3(i+1,max(1,(M2(k)-Demanda_verdes(v))/50+1)));
                    fd(j,k) = fd (j,k) + var(v,m);
                end
            end
            if (fd(j,q+1)<fd(j,k))
                fd(j,q+1) = fd(j,k);
                fd(j,q+2) = M2(k);
            end
        end
    end
    fd
    M3(i,:)=fd(:,q+1);
    M4(i,:)=fd(:,q+2);
end
M3
M4

            
