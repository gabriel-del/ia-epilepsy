
function y = energiaD(x)
  y = 0;
  for i = 1:length(x)
  y = y + (x(i)*x(i));
  end
endfunction