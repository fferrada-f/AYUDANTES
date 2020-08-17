%{
Un propietario de una cadena de tres supermercados compró cinco cargas de
fresas frescas. 
El propietario quiere saber como debe asignar las cinco
cargas a las tiendas para maximizar la ganancia.
DETERMINISTA
%}
Datos = [0 5 9 14 17 21
         0 6 11 15 19 22
         0 4 9 13 18 20];   %Datos(tienda,Asigación de cargas) = ganancia respectiva 
     
M1 =    [0 1 2 3 4 5];      % Vector de estado, con cuanto llego a la etapa (S(n))
M2 =    [0 1 2 3 4 5];      % Vector de desición, cuanto asigno a la etapa (X(n))
a  = size(Datos,1);         % Numero de etapas del problema
b  = size(M1,2);            % Cuantos estados puedo tener
q  = size(M2,2);            % Cuantas desiciones puedo tomar

M3 = zeros(a+1,b);          % Matriz que guardará los datos de los valores óptimos de cada etapa
M4 = zeros(a,q);            % Matriz que guardará las desiciones óptimas de cada etaba


for i = a:-1:1              % Loop de etapas
    fd = zeros(b,q+2);      % Matriz de iteraciones
    fprintf(['Etapa ', num2str(i), '\n'])
    for j = 1:b             % Loop de estados
        for k = 1:q         % Loop de decisiones
            if (M1(1,j) >= M2(1,k)) % condicion: no puedo asignar más de lo que el estado tiene
                fd(j,k) = Datos(i,k) + M3(i+1, j-k+1); %M3(etapa anterior, lo que tengo - lo que utilizo es lo que me queda)
            end
            %{
            El condicional a continuación, nos menciona que en la matriz
            fd(:,b+1) siempre tienen que estar los máximos de cada
            estado,tanto en decisión (b+2) como en valor (b+1)
            %}
            if (fd(j,b+1) < fd(j,k))
                fd(j,b+1) = fd(j,k);
                fd(j,b+2) = M2(1,k);
            end
        end
    end
    fd                      % Muestra la matriz terminada de la etapa
    M3(i,:) = fd(:,b+1);    % Guarda los máximos valores
    M4(i,:) = fd(:,b+2);    % Guarda las mejores desiciones
end
M3                          % Muestra M3
M4                          % Muestra M4

