function y = potenciaD(x)
  y = 0;
  for i = 1:length(x)
  y = y + (x(i)*x(i));
  y = y/(length(x));
  end
endfunction