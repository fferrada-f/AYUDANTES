clc
clear
DATOS =    [0 8 8 6 5
            0 9 8 7 7
            7 7 7 7 7]*0.01; %RENTABILIDAD DE CADA INSTRUMENTO DATOS(Instrumento,rentabilidad)

M1 = [0 100000 200000 300000 400000]; %Variables de Estado S1
M2 = [0 100000 200000 300000 400000]; %Variables de desición
a = size(DATOS,1);  %Marca el numero de etapas
b = size(M1,2);     %Marca el numero de estados
q = size(M2,2);     %Marca el numero de desiciones

M3 = zeros(a+1,b);  %Matriz de fd*(x)
M4 = zeros(a,q);    %Matriz de mejores decisiones

for i = a:-1:1
    fd = zeros(b,q+2);
    fprintf(['Etapa ',num2str(i),'\n'])
    for j = 1:b     %Loop de estados
        for k = 1:q %Loop de desiciones
            if (M1(1,j) >= M2(1,k)) %Condicional: no puedo decidir mas de lo que tengo
                fd(j,k) = M2(1,k)*(1+DATOS(i,k)) + M3(i+1,j-k+1);
            end
            if (fd(j,b+1) < fd(j,k)) %Condicional: Guardar siempre la mejor decision de cada estado
                fd(j,b+1) = fd(j,k);
                fd(j,b+2) = M2(k);
            end
        end
    end
    fd;
    M3(i,:) = fd(:,b+1);
    M4(i,:) = fd(:,b+2);
end
M3
M4


%{
<<OPCIONAL>> para operear, borrar %{ y %}
fprintf(['Retornos máximos posibles: $', num2str(max(M3(1,:))-400000), '\n'])
fprintf(['Se deben asignar los siguientes montos a los respectivos instrumentos financieros: \n'])
Instrumento = [ "Fondos mutuos: ";"Acciones: ";"Bonos: " ];
g=5;
for i = 1:a
    fprintf(Instrumento(i), ': ')
    fprintf(num2str(M4(i,g)))
    fprintf('\n')
    g = g - M4(i,g)/100000;
end
%}
        