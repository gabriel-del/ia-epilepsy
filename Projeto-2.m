##fs = 500; ## amostragem, 1s=500pnts

open("/opt/UFPE2019-1/IA/proj-final/P10_f/T0_p10.mat");
T0 = X;  ## chamando o arquivo
open("/opt/UFPE2019-1/IA/proj-final/P10_f/T2_p10.mat");
T1 = X;
%open("C:/Users/gaabr/Desktop/IA/Projeto/P9_f/T4_p9.mat");

%função para extrair parte do sinal no periodo de sono do paciente é etraido um periodo de 10 minutos no intervalo de 15 min a 25 min 
SonoT0 = T0(((4.5)*(10^5)):((7.5)*(10^5)),:);
%funçao para extrair parte do sinal no periodo de estimulação sonora do paciente no intervalo de 40 min a 50 min
SonoT1 = T1(((3)*(10^5)):((6)*(10^5)),:);

k = {"energiaD","std","mean","range","kurtosis","skewness","var","potenciaD", "mode","median","iqr","meansq","quantile","quantile"};

for b = 1:1
fprintf('\nB: %d/300 \t',b);

%Criando janelas com e sem estimulo
  janSonoT0 = SonoT0(1000*b - 500:1000*b,:);
  janSonoT1 = SonoT1(1000*b - 500:1000*b,:);
  
%organizando as janelas em 1 linha
  janSonoT0 = reshape(janSonoT0,1,[]);
  janSonoT1 = reshape(janSonoT1,1,[]);

%calculando wavlet com 3 niveis para as janelas.
  wavSonoT0 = TransformadaWaveletHaar(janSonoT0,3);
  wavSonoT1 = TransformadaWaveletHaar(janSonoT1,3);

%calculo atributos: cada nivel do wavlet é considerado um sinal diferente 
for i = 1:4
mad = 1; qua = 25;
for j = 1:length(k)
fprintf('.');
switch k{j}
	case "mad"			ext = strcat(",", num2str(mad)); mad = 0;
	case "quantile"	ext = strcat(",0.", num2str(qua)); qua = 75;
	otherwise				ext = '';
end

Atributos(b  			, i+ (4*j) - 4) 	= eval(strcat(k{j}, "(wavSonoT0(", num2str(i), ",:)", ext, ")"));
Atributos(b  + 300, i+ (4*j) - 4) = eval(strcat(k{j}, "(wavSonoT1(", num2str(i), ",:)", ext, ")"));
endfor
%  Atributos(b + 0,   i+ 52) = mad(wavSonoT0(i,:),0);
% Criando matriz com atributos para cada wavlet para todos os pacientes ao mesmo tempo e para o caso com e sem estimulo 
% Classes: 0 = sem estimulo; 1 = com estimulo
Atributos(b + 0,   (length(k)*4) +1 ) = 0;
Atributos(b + 300, (length(k)*4) +1 ) = 1;

endfor
endfor
