#!/usr/bin/octave -qfV

F = {"energiaD","std","mean","range","kurtosis","skewness","var","potenciaD", "mode","median","iqr","meansq","quantile","quantile"};
for f = 1:length(F) ;
switch F{f}
	case {"quantile" "var"}	sexo = 'M';
	case {"std" "mean"}	sexo = 'M';
	otherwise				sexo = 'F';
end
fprintf("%s = %s \n", F{f}, sexo);
end


