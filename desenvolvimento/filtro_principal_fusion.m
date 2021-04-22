clc; clear; close all;
y=zeros(8001,1);
y(1:72:end)=1;

load('audios.mat');
leta = sonzim(500:8000);
plot(leta)
hold on
[a,b] = covpred(leta,20);
x1 = filter(1 , [1 a.'],y);
plot(x1)

soundsc(leta)
soundsc(x1)

filter_leta=preEmFilter(leta);
figure(2)
plot(filter_leta)
hold on
[c,d] = covpred(filter_leta,20);
x2 = filter(1 , [1 c.'],y);
plot (x2)
hold on

soundsc(filter_leta)
soundsc(x2)