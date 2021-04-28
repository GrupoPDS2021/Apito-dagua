clc; clear; close all;

load("Gravações/papagaiomao2.mat");
audioIn = x;

y = speech_segmentation(audioIn, Fs);

z = segmentos(audioIn,y);

for i = 1 : size(z,2)    
    z(:,i) = preEmFilter(z(:,i));     
end

imp = zeros(881,1);
imp(1) = 1;
for i = 1 : size(z,2)    
     [a , b] = covpred(z(:,i),20);
     zf(:,i) = filter(1 , [1 a.'],imp);
     zf(:,i) = max(z(:,i))*zf(:,i)/max(zf(:,i));
     
end

t1 = 20*44,1;
var = 1;
for i = 1:length(y)
    k = y(i,1);
while (k < y(i,2))
    
    plot(k:k+t1,zf(:,var))
    hold on
    k = k + t1;
    var = var +1;
    
end

end

k = 1;
for i = 1:size(z,2)
    final(k:k + t1) = zf(:,i);
    k = k + t1;
end

k = 1;
for i = 1:size(z,2)
    inicial(k:k + t1) = z(:,i);
    k = k + t1;
end

audiowrite('1orig.wav',10*inicial,Fs)
sound(10*inicial,44100)