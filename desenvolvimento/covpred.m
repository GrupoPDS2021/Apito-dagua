function [a,error] = covpred(x1,p)
% x --> sinal de entrada
% p --> grau do meu LP
% a --> coef do meu lp
%cria meu vetor autocorr

% %TESTE
% %clc; clear all;
% t = 0:0.1:1000;
% x1 = sin(t/pi)';
% plot(x1);
% p = 80;

lag = 0:1:p;
x2 = delayseq(x1,lag); %sinal com lag
v = var(x1); % variancia do sinal
error = 0;
for i = 1:length(lag)
rx1x2(:,i)=conv(x1,x2(length(x2):-1:1,i)); %convolução com x1 e a seq invertida
                                    %o valor da autocorr é o central da função conv
cc(i)=rx1x2(length(x1),i)/((length(x1)-lag(i))); 
end


R = toeplitz(cc(1:length(cc)-1)'); %cria matriz de autocorr
r = cc(2:length(cc))';

a = -R \ r; %encontra meus valores do filtro (pode ser otimizado)

%%%%%%%%% erro quadrático %%%%%%%%
error = error + cc(1);
kk = a.'*r;
error = error + kk;


end
