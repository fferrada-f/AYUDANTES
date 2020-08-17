clc
clear
Costo_fijo = [20;20;20];
Costo_variable = [25;20;10];
Req_Pescado = [4;3;2];
Precio_pallet = [80;60;40];
Demanda = [inf;4;4];
Precio_merma = 1; %Precio reventa por 0.1 tonelada
M1 = [0 1 2 3 4 5 6 7 8 9 10]; %Vector de estado en 0.1
M2 = [0 1 2 3 4]; %Vector desicion
a = 3; %Etapas
b = size(M1,2); %estados
q = size(M2,2); %desiciones
M3 = zeros(a,b);
M4 = zeros(a,b);

for i = a:-1:1
    fd = zeros(b,q+2);
    fprintf(['Etapa ',num2str(i),'\n'])
    for j=1:b
        for k=1:q
            if (M1(j)>= M2(k)*Req_Pescado(i)) && (Demanda(i)>=M2(k))
                if i<3
                    fd(j,k) = M2(k)*(Precio_pallet(i)-Costo_variable(i))-Costo_fijo(i)*min(1,M2(k)) + M3(i+1,(M1(j)-M2(k)*Req_Pescado(i))+1);
                else
                    fd(j,k) = M2(k)*(Precio_pallet(i)-Costo_variable(i))-Costo_fijo(i)*min(1,M2(k)) + (M1(j)-M2(k)*Req_Pescado(i))*Precio_merma;
                end
            end
            if fd(j,k)>fd(j,q+1)
                fd(j,q+1)=fd(j,k);
                fd(j,q+2)=M2(k);
            end
        end
    end
    fd
    M3(i,:)=fd(:,q+1);
    M4(i,:)=fd(:,q+2);
end
M3
M4


