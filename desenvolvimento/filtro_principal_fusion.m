function y = filtro_principal_fusion(audioIn)
y=zeros(8001,1);
y(1:72:end)=1;

plot(audioIn)
hold on
[a,b] = covpred(audioIn,20);
x1 = filter(1 , [1 a.'],y);
plot(x1)

soundsc(audioIn)
soundsc(x1)

preEmphasisAudioIn=preEmFilter(leta);
figure(2)
plot(filter_leta)
hold on
[c,d] = covpred(preEmphasisAudioIn,20);
x2 = filter(1 , [1 c.'],y);
plot (x2)
hold on

soundsc(preEmphasisAudioIn)
soundsc(x2)

end