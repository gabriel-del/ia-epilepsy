fs = 500; ## amostragem, 1s=500pnts

x = EA300418;  ## chamando o arquivo
y = F090418;
z = JF110518;
w = MI140518;

Nx = length(x);  ## recebende tamanho de x
Ny = length(y);
Nz = length(z);
Nw = length(w);        

tx = 0:(Nx-1);    ## o tempo varia etre 0 e o tamanho do arquivo
ty = 0:(Ny-1);
tz = 0:(Nz-1);
tw = 0:(Nw-1);




## função para extrair parte do sinal no periodo de sono do paciente   
## é extraido um periodo de 10 minutos
## no intervalo de 15 min a 25 min 
Sonox = x(((4.5)*(10^5)):((7.5)*(10^5)),:);
Sonoy = y(((4.5)*(10^5)):((7.5)*(10^5)),:);
Sonoz = z(((4.5)*(10^5)):((7.5)*(10^5)),:);
Sonow = w(((4.5)*(10^5)):((7.5)*(10^5)),:);
## funçao para extrair parte do sinal no periodo de estimulação sonora do paciente
## no intervalo de 40 min a 50 min
Somx = x(((1.2)*(10^6)):((1.5)*(10^6)),:);
Somy = y(((1.2)*(10^6)):((1.5)*(10^6)),:);
Somz = z(((1.2)*(10^6)):((1.5)*(10^6)),:);
Somw = w(((1.2)*(10^6)):((1.5)*(10^6)),:);



for b = 1:200
  ##Criando janelas com e sem estimulo
  janSonox = Sonox(1500*b - 500:1500*b,:);
  janSomx = Somx(1500*b - 500:1500*b,:);
  
  janSonoy = Sonoy(1500*b - 500:1500*b,:);
  janSomy = Somy(1500*b - 500:1500*b,:);
  
  janSonoz = Sonoz(1500*b - 500:1500*b,:);
  janSomz = Somz(1500*b - 500:1500*b,:);
  
  janSonow = Sonow(1500*b - 500:1500*b,:);
  janSomw = Somw(1500*b - 500:1500*b,:);
  ##organizando as janelas em 1 linha
  janSonox = reshape(janSonox,1,[]);
  janSomx = reshape(janSomx,1,[]);
  
  janSonoy = reshape(janSonoy,1,[]);
  janSomy = reshape(janSomy,1,[]);
  
  janSonoz = reshape(janSonoz,1,[]);
  janSomz = reshape(janSomz,1,[]);
  
  janSonow = reshape(janSonow,1,[]);
  janSomw = reshape(janSomw,1,[]);
  ##calculando wavlet com 3 niveis para as janelas.
  wavSonox = TransformadaWaveletHaar(janSonox,3);
  wavSomx = TransformadaWaveletHaar(janSomx,3);
  
  wavSonoy = TransformadaWaveletHaar(janSonoy,3);
  wavSomy = TransformadaWaveletHaar(janSomy,3);
  
  wavSonoz = TransformadaWaveletHaar(janSonoz,3);
  wavSomz = TransformadaWaveletHaar(janSomz,3);
  
  wavSonow = TransformadaWaveletHaar(janSonow,3);
  wavSomw = TransformadaWaveletHaar(janSomw,3);
  
  ##calculo atributos
  ##cada nivel do wavlet é considerado um sinal diferente 
  for i = 1:4
  ## Criando matriz com atributos para cada wavlet
  ## para todos os pacientes ao mesmo tempo e para o
  ## caso com e sem estimulo

k = [EnergiaD std mean] 
#energia desvio-padrao
for j = 0:12
#calculo energia ( Coluna 1)
  Atributos(b + 0,   i+4*j) = k(j)(wavSonox(i,:));
  Atributos(b + 200, i+4*j) = k(j)(wavSomx(i,:));
  Atributos(b + 400, i+4*j) = k(j)(wavSonoy(i,:));
  Atributos(b + 600, i+4*j) = k(j)(wavSomy(i,:));
  Atributos(b + 800, i+4*j) = k(j)(wavSonoz(i,:));
  Atributos(b + 1000,i+4*j) = k(j)(wavSomz(i,:));
  Atributos(b + 1200,i+4*j) = k(j)(wavSonow(i,:));
  Atributos(b + 1400,i+4*j) = k(j)(wavSomw(i,:));

  endfor
  
  #calculo energia ( Coluna 1)
  Atributos(b + 0,   i) = EnergiaD(wavSonox(i,:));
  Atributos(b  + 200, i) = EnergiaD(wavSomx(i,:));
  Atributos(b + 400, i) = EnergiaD(wavSonoy(i,:));
  Atributos(b + 600, i) = EnergiaD(wavSomy(i,:));
  Atributos(b + 800, i) = EnergiaD(wavSonoz(i,:));
  Atributos(b + 1000,i) = EnergiaD(wavSomz(i,:));
  Atributos(b + 1200,i) = EnergiaD(wavSonow(i,:));
  Atributos(b + 1400,i) = EnergiaD(wavSomw(i,:));
  #calculo desvio padrão (coluna 2)
  Atributos(b + 0,   i+4) = std(wavSonox(i,:));
  Atributos(b + 200, i+4) = std(wavSomx(i,:));
  Atributos(b + 400, i+4) = std(wavSonoy(i,:));
  Atributos(b + 600, i+4) = std(wavSomy(i,:));
  Atributos(b + 800, i+4) = std(wavSonoz(i,:));
  Atributos(b + 1000,i+4) = std(wavSomz(i,:));
  Atributos(b + 1200,i+4) = std(wavSonow(i,:));
  Atributos(b + 1400,i+4) = std(wavSomw(i,:));
  #calculo media (coluna 3)
  Atributos(b + 0,   i+8) = mean(wavSonox(i,:));
  Atributos(b + 200, i+8) = mean(wavSomx(i,:));
  Atributos(b + 400, i+8) = mean(wavSonoy(i,:));
  Atributos(b + 600, i+8) = mean(wavSomy(i,:));
  Atributos(b + 800, i+8) = mean(wavSonoz(i,:));
  Atributos(b + 1000,i+8) = mean(wavSomz(i,:));
  Atributos(b + 1200,i+8) = mean(wavSonow(i,:));
  Atributos(b + 1400,i+8) = mean(wavSomw(i,:));
  #calculo range(coluna 4)
  Atributos(b + 0,   i+12) = range(wavSonox(i,:));
  Atributos(b + 200, i+12) = range(wavSomx(i,:));
  Atributos(b + 400, i+12) = range(wavSonoy(i,:));
  Atributos(b + 600, i+12) = range(wavSomy(i,:));
  Atributos(b + 800, i+12) = range(wavSonoz(i,:));
  Atributos(b + 1000,i+12) = range(wavSomz(i,:));
  Atributos(b + 1200,i+12) = range(wavSonow(i,:));
  Atributos(b + 1400,i+12) = range(wavSomw(i,:));
  #calclo kurtosis (coluna 5)
  Atributos(b + 0,   i+16) = kurtosis(wavSonox(i,:));
  Atributos(b + 200, i+16) = kurtosis(wavSomx(i,:));
  Atributos(b + 400, i+16) = kurtosis(wavSonoy(i,:));
  Atributos(b + 600, i+16) = kurtosis(wavSomy(i,:));
  Atributos(b + 800, i+16) = kurtosis(wavSonoz(i,:));
  Atributos(b + 1000,i+16) = kurtosis(wavSomz(i,:));
  Atributos(b + 1200,i+16) = kurtosis(wavSonow(i,:));
  Atributos(b + 1400,i+16) = kurtosis(wavSomw(i,:));
  #calculo skewness (coluna 6) 
  Atributos(b + 0,   i+20) = skewness(wavSonox(i,:));
  Atributos(b + 200, i+20) = skewness(wavSomx(i,:));
  Atributos(b + 400, i+20) = skewness(wavSonoy(i,:));
  Atributos(b + 600, i+20) = skewness(wavSomy(i,:));
  Atributos(b + 800, i+20) = skewness(wavSonoz(i,:));
  Atributos(b + 1000,i+20) = skewness(wavSomz(i,:));
  Atributos(b + 1200,i+20) = skewness(wavSonow(i,:));
  Atributos(b + 1400,i+20) = skewness(wavSomw(i,:));
  #calculo variancia(Coluna 7)
  Atributos(b + 0,   i+24) = var(wavSonox(i,:));
  Atributos(b + 200, i+24) = var(wavSomx(i,:));
  Atributos(b + 400, i+24) = var(wavSonoy(i,:));
  Atributos(b + 600, i+24) = var(wavSomy(i,:));
  Atributos(b + 800, i+24) = var(wavSonoz(i,:));
  Atributos(b + 1000,i+24) = var(wavSomz(i,:));
  Atributos(b + 1200,i+24) = var(wavSonow(i,:));
  Atributos(b + 1400,i+24) = var(wavSomw(i,:));
  #calculo FeatureZeroCrossing(coluna 8)
  Atributos(b + 0,   i+28) = FeatureZeroCrossing(wavSonox(i,:));
  Atributos(b + 200, i+28) = FeatureZeroCrossing(wavSomx(i,:));
  Atributos(b + 400, i+28) = FeatureZeroCrossing(wavSonoy(i,:));
  Atributos(b + 600, i+28) = FeatureZeroCrossing(wavSomy(i,:));
  Atributos(b + 800, i+28) = FeatureZeroCrossing(wavSonoz(i,:));
  Atributos(b + 1000,i+28) = FeatureZeroCrossing(wavSomz(i,:));
  Atributos(b + 1200,i+28) = FeatureZeroCrossing(wavSonow(i,:));
  Atributos(b + 1400,i+28) = FeatureZeroCrossing(wavSomw(i,:));
  #Calculo Moda(Coluna 9)
  Atributos(b + 0,   i+32) = mode(wavSonox(i,:));
  Atributos(b + 200, i+32) = mode(wavSomx(i,:));
  Atributos(b + 400, i+32) = mode(wavSonoy(i,:));
  Atributos(b + 600, i+32) = mode(wavSomy(i,:));
  Atributos(b + 800, i+32) = mode(wavSonoz(i,:));
  Atributos(b + 1000,i+32) = mode(wavSomz(i,:));
  Atributos(b + 1200,i+32) = mode(wavSonow(i,:));
  Atributos(b + 1400,i+32) = mode(wavSomw(i,:));
  #calculo mediana(Coluna 10)
  Atributos(b + 0,   i+36) = median(wavSonox(i,:));
  Atributos(b + 200, i+36) = median(wavSomx(i,:));
  Atributos(b + 400, i+36) = median(wavSonoy(i,:));
  Atributos(b + 600, i+36) = median(wavSomy(i,:));
  Atributos(b + 800, i+36) = median(wavSonoz(i,:));
  Atributos(b + 1000,i+36) = median(wavSomz(i,:));
  Atributos(b + 1200,i+36) = median(wavSonow(i,:));
  Atributos(b + 1400,i+36) = median(wavSomw(i,:));
  #Calculo iqr(Coluna 11)
  Atributos(b + 0,   i+40) = iqr(wavSonox(i,:));
  Atributos(b + 200, i+40) = iqr(wavSomx(i,:));
  Atributos(b + 400, i+40) = iqr(wavSonoy(i,:));
  Atributos(b + 600, i+40) = iqr(wavSomy(i,:));
  Atributos(b + 800, i+40) = iqr(wavSonoz(i,:));
  Atributos(b + 1000,i+40) = iqr(wavSomz(i,:));
  Atributos(b + 1200,i+40) = iqr(wavSonow(i,:));
  Atributos(b + 1400,i+40) = iqr(wavSomw(i,:));
  #Calculo mad mediana(Coluna 12)
  Atributos(b + 0,   i+44) = mad(wavSonox(i,:),1);
  Atributos(b + 200, i+44) = mad(wavSomx(i,:),1);
  Atributos(b + 400, i+44) = mad(wavSonoy(i,:),1);
  Atributos(b + 600, i+44) = mad(wavSomy(i,:),1);
  Atributos(b + 800, i+44) = mad(wavSonoz(i,:),1);
  Atributos(b + 1000,i+44) = mad(wavSomz(i,:),1);
  Atributos(b + 1200,i+44) = mad(wavSonow(i,:),1);
  Atributos(b + 1400,i+44) = mad(wavSomw(i,:),1);
  #Calculo mad media(Coluna 13)
  Atributos(b + 0,   i+48) = mad(wavSonox(i,:),0);
  Atributos(b + 200, i+48) = mad(wavSomx(i,:),0);
  Atributos(b + 400, i+48) = mad(wavSonoy(i,:),0);
  Atributos(b + 600, i+48) = mad(wavSomy(i,:),0);
  Atributos(b + 800, i+48) = mad(wavSonoz(i,:),0);
  Atributos(b + 1000,i+48) = mad(wavSomz(i,:),0);
  Atributos(b + 1200,i+48) = mad(wavSonow(i,:),0);
  Atributos(b + 1400,i+48) = mad(wavSomw(i,:),0);
  
  #Classes: 0 = sem estimulo; 1 = com estimulo
  Atributos(b + 0,   53) = 0;
  Atributos(b + 200, 53) = 1;
  Atributos(b + 400, 53) = 0;
  Atributos(b + 600, 53) = 1;
  Atributos(b + 800, 53) = 0;
  Atributos(b + 1000,53) = 1;
  Atributos(b + 1200,53) = 0;
  Atributos(b + 1400,53) = 1;
  endfor
endfor
