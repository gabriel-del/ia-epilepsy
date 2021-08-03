##fs = 500; ## amostragem, 1s=500pnts % Tirar o P3 que o T0 é so metade
url= '/opt/Epilepsy_database';
% url= 'C:/Users/gaabr/Desktop/IA/Projeto';
%P = {"2","3","4","5","6","7","9","10"};
P = {"2","3","6","9","10"};
for p = 1:length(P)
switch P{p}	case {"1" "3" "5" "6" "9" "10" "13" }	sexo = 'f';	case {"2" "4" "7" "8" "11" "12" "14"}	sexo = 'm'; end
open(strcat(url, "/P", P{p}, "_", sexo, "/T4_p", P{p}, ".mat")); T4 = X; 

% extrai parte do sinal durante SONO (15-25min) e ESTIMULO (40-50min) do paciente durante periodo de 10min no intervalo de: 
SonoT4 = T4(((3.0)*(10^5)):((6.0)*(10^5)),:);
F = {"energiaD","std","mean","range","kurtosis","skewness","var","potenciaD", "mode","median","iqr","meansq","quantile","quantile"};
for b = 1:300 ;fprintf('\nP: %s \tB: %d/300 \t',P{p},b);
janSonoT4 = SonoT4(1000*b - 500:1000*b,:);  %divisao com/sem estimulo  
janSonoT4 = reshape(janSonoT4,1,[]); %janelas em 1 linha
wavSonoT4 = TransformadaWaveletHaar(janSonoT4,3);  %wavlet com 3 niveis

%calculo atributos: cada nivel do wavlet é considerado um sinal diferente 
for c = 1:4 ; qua = ',0.25';
for f = 1:length(F) ;fprintf('.');
switch F{f}	case "quantile"	ext = qua; qua = ',0.75';	otherwise				ext = ''; end;
AtributosT4(b  + (p*300) -300	, c+ (4*f) - 4) 	= eval(strcat(F{f}, "(wavSonoT4(", num2str(c), ",:)", ext, ")"));
endfor
% Criando matriz com atributos para cada wavlet para todos os pacientes ao mesmo tempo e para o caso com e sem estimulo 
% Classes: 0 = sem estimulo; 1 = com estimulo
AtributosT4(b + (p*300) -300 + 0,   (length(F)*4) +1 ) = '?';
endfor;endfor;endfor;fprintf('\n');
