clear all
close all
%--------------------------------------
%EJERCICIO 1
%--------------------------------------

%Se lee el archivo con los datos y se los carga a un vector 
detecciones = (readmatrix('geiger.csv')');
    
%Se crea un vector con el tiempo entre cada deteccion   
tiempoEntrePulsos = zeros(size(detecciones)-1);
for i = 1:(length(detecciones)-1)
    tiempoEntrePulsos(i) = detecciones(i+1) - detecciones(i);
end

%Se calcula la media y la varianza del tiempo entre detecciones
mediaTiempoEntrePulsos = mean(tiempoEntrePulsos)
varianzaTiempoEntrePulsos = var(tiempoEntrePulsos)

%Se grafica el histograma normalizado del tiempo entre pulsos
histogram(tiempoEntrePulsos, 'Normalization','pdf')

%Al histograma anterior se le superpone la curva teórica para poder
%compararlos
hold on
x = linspace(0, max(tiempoEntrePulsos));
plot(x, exppdf(x, mediaTiempoEntrePulsos),'LineWidth',2);

legend("Histograma", "PDF")
xlabel("tiempo [microsegundos]")
title("Tiempo entre pulsos")

%--------------------------------------
%EJERCICIO 2
%--------------------------------------


T = 2*10^6; %2 segundos en microsegundos

%Se definen los bordes de los intervalos de dos segundos 

edges = 0:T:max(detecciones)+T;

%Se cuentan la cantidad de detecciones caenen cada intervalo

cantParticulas = histcounts(detecciones, edges);


%Se calcula la media y la varianza de la cantidad de detecciones en el
%intervalo
mediaCantParticulas = mean(cantParticulas)
varianzaCantParticulas = var(cantParticulas)

% Graficar el histograma de la cantidad de detecciones en el intervalo
figure;
histogram(cantParticulas, 'Normalization', 'probability', 'BinEdges', -0.5:1:8.5);  % Incluir el 0 en los bordes de los bins

% Al histograma anterior se le superponen los puntos de la FMP teórica
hold on
x = 0:8;  % Empezar desde 0 para incluir el valor cero
stem(x, poisspdf(x, mediaCantParticulas), 'LineWidth', 2);  % Usar stem para puntos discretos de la FMP
legend("Histograma", "FMP teórica")
xlabel("Cantidad de detecciones")
title("Cantidad de detecciones contadas en intervalos de 2 segundos")

