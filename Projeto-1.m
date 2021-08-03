fs = 500; ## amostragem, 1s=500pnts

open("C:/Users/gaabr/Desktop/IA/Projeto/T0p2.mat");
T0 = X;  ## chamando o arquivo
open("C:/Users/gaabr/Desktop/IA/Projeto/T1p2.mat");
T1 = X;
## função para etrair parte do sinal no periodo de sono do paciente   
## é etraido um periodo de 10 minutos
## no intervalo de 15 min a 25 min 
SonoT0 = T0(((4.5)*(10^5)):((7.5)*(10^5)),:);

## funçao para etrair parte do sinal no periodo de estimulação sonora do paciente
## no intervalo de 40 min a 50 min
SonoT1 = T1(((3)*(10^5)):((6)*(10^5)),:);

for b = 1:200
  ##Criando janelas com e sem estimulo
  janSonoT0 = SonoT0(1500*b - 500:1500*b,:);
  janSonoT1 = SonoT1(1500*b - 500:1500*b,:);

  ##organizando as janelas em 1 linha
  janSonoT0 = reshape(janSonoT0,1,[]);
  janSonoT1 = reshape(janSonoT1,1,[]);

  ##calculando wavlet com 3 niveis para as janelas.
  wavSonoT0 = TransformadaWaveletHaar(janSonoT0,3);
  wavSonoT1 = TransformadaWaveletHaar(janSonoT1,3);

  ##calculo atributos
  ##cada nivel do wavlet é considerado um sinal diferente 
  for i = 1:4
  ## Criando matriz com atributos para cada wavlet
  ## para todos os pacientes ao mesmo tempo e para o
  ## caso com e sem estimulo
  
  %calculo energia ( Coluna 1)
  Atributos(b + 0,   i) = energiaD(wavSonoT0(i,:));
  Atributos(b  + 200, i) = energiaD(wavSonoT1(i,:));
  %calculo desvio padrão (coluna 2)
  Atributos(b + 0,   i+4) = std(wavSonoT0(i,:));
  Atributos(b + 200, i+4) = std(wavSonoT1(i,:));
  %calculo media (coluna 3)
  Atributos(b + 0,   i+8) = mean(wavSonoT0(i,:));
  Atributos(b + 200, i+8) = mean(wavSonoT1(i,:));
  %calculo range(coluna 4)
  Atributos(b + 0,   i+12) = range(wavSonoT0(i,:));
  Atributos(b + 200, i+12) = range(wavSonoT1(i,:));
  %calclo kurtosis (coluna 5)
  Atributos(b + 0,   i+16) = kurtosis(wavSonoT0(i,:));
  Atributos(b + 200, i+16) = kurtosis(wavSonoT1(i,:));
  %calculo skewness (coluna 6) 
  Atributos(b + 0,   i+20) = skewness(wavSonoT0(i,:));
  Atributos(b + 200, i+20) = skewness(wavSonoT1(i,:));
  #calculo variancia(Coluna 7)
  Atributos(b + 0,   i+24) = var(wavSonoT0(i,:));
  Atributos(b + 200, i+24) = var(wavSonoT1(i,:));
  #calculo FeatureZeroCrossing(coluna 8)
  %%Atributos(b + 0,   i+28) = FeatureZeroCrossing(wavSonoT0(i,:));
  %%Atributos(b + 200, i+28) = FeatureZeroCrossing(wavSonoT1(i,:));

  %Calculo Moda(Coluna 9)
  Atributos(b + 0,   i+32) = mode(wavSonoT0(i,:));
  Atributos(b + 200, i+32) = mode(wavSonoT1(i,:));

  #calculo mediana(Coluna 10)
  Atributos(b + 0,   i+36) = median(wavSonoT0(i,:));
  Atributos(b + 200, i+36) = median(wavSonoT1(i,:));

  #Calculo iqr(Coluna 11)
  Atributos(b + 0,   i+40) = iqr(wavSonoT0(i,:));
  Atributos(b + 200, i+40) = iqr(wavSonoT1(i,:));

  #Calculo mad mediana(Coluna 12)
  Atributos(b + 0,   i+44) = mad(wavSonoT0(i,:),1);
  Atributos(b + 200, i+44) = mad(wavSonoT1(i,:),1);

  #Calculo mad media(Coluna 13)
  Atributos(b + 0,   i+28) = mad(wavSonoT0(i,:),0);
  Atributos(b + 200, i+28) = mad(wavSonoT1(i,:),0);

  
 % Classes: 0 = sem estimulo; 1 = com estimulo
  Atributos(b + 0,   49) = 0;
  Atributos(b + 200, 49) = 1;
  endfor
endfor