function [a,error] = covpred(x1,p)
% x --> sinal de entrada
% p --> grau do meu LP
% a --> coef do meu lp
%cria meu vetor autocorr
[rx1x2,lag]= xcorr(x1);

%autocorrelação do meu sinal de 0 até o grau p do polinomio
cc = rx1x2(ceil(length(rx1x2)/2):(ceil(length(rx1x2)/2)+p));

R = toeplitz(cc(1:length(cc)-1)'); %cria matriz de autocorr
r = cc(2:length(cc));


a = LUsistLin(-R,r); %encontra meus valores do filtro / otimizado com LU

%%%%calculo erro quadrático médio%%%%%%

ccnorm = cc./cc(1);
error = cc(1);
for i = 2:length(cc);
    error = error + a(i-1,1)*cc(i);  
end

end
