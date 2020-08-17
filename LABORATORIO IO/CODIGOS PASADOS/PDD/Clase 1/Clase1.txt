clear
clc
Datos = [0 45 70 90 105 120
         0 20 45 75 110 150
         0 50 70 80 100 130]; %Datos a considerar
M1 =    [0 1 2 3 4 5];      %variables de estado
M2 =    [0 1 2 3 4 5];      %variable de desición

[a,b] = size(Datos);
q = size(M2,2);

M3 = zeros(a+1,b);
M4 = zeros(a,b);

for i=a:-1:1
    fd= zeros(b,b+2);
    fprintf(['etapa numero=',num2str(i),'\n'])
    for j = 1:b         % Cantidad de estados existentes
        for k = 1:q     % Cantidad de desiciones existentes
            if (M1(j)>= M2(k))
            fd(j,k)= Datos(i,k)+ M3(i+1,M1(j)- M2(k)+1);
            end
        if (fd(j,b+1) < fd(j,k))
            fd(j,b+1) = fd(j,k);
            fd(j,b+2) = M2(k);
        end
        end
    end
    fd;
    M3(i,:) = fd(:,b+1);
    M4(i,:) = fd(:,b+2);
end
fprintf(['Vidas Maximas salvadas: ', num2str(max(M3(1,:))),'\n'])
fprintf('Doctores a asignar por pais: \n')
g=6;
for i=1:a
        fprintf(['Pais ', num2str(i),': ', num2str(M4(i,g)), '\n'])
        g=g-M4(i,g);
end
    
    


