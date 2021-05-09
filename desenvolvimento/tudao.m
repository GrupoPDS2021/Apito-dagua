clc; clear; close all;

load("Gravações/papagaiomaolongo1.mat");
audioIn = x;
plot(x)
title("sinal de entrada")

y = speech_segmentation(audioIn, Fs);
tjanela=20;
t1 = round(tjanela*44.1); %janela de 20ms
z = segmentos(audioIn,y,t1); %segmentando audio em janelas de 20ms
% z ---> matriz onde colunas são meus segmentos de audio
 plot(z)
for i = 1 : size(z,2)    
    zpre(:,i) = preEmFilter(z(:,i));     
end

%sinals de entrada
rui = wgn(t1+1,1,0.2); %ruído branco

imp = zeros(t1+1,1); % trem de impulso
imp(1) = 1;
temp = 1;

dc_level = mean(x);

for i = 1 : size(z,2)
    [a , b] = covpred(z(:,i),tjanela); %sem preenfase
    [a1 , b1] = covpred(zpre(:,i),tjanela); %com preenfase
     sound_type = vus_methods(z(:,i), Fs);
     if (strcmp(sound_type,'voiced'))
        zf(:,i) = filter(1 , [1 a.'],imp);
        zf(:,i) = max(z(:,i))*zf(:,i)/max(zf(:,i));
        zfpre(:,i) = filter(1 , [1 a1.'],imp); %resposta ao impulso
        zfpre(:,i) = max(z(:,i))*zfpre(:,i)/max(zfpre(:,i)); %normalizando amplitudes
     elseif (strcmp(sound_type,'unvoiced'))
        zf(:,i) = filter(1 , [1 a.'],rui);
        zf(:,i) = max(z(:,i))*zf(:,i)/max(zf(:,i));
        zfpre(:,i) = filter(1 , [1 a1.'],rui); %resposta ao impulso
        zfpre(:,i) = max(z(:,i))*zfpre(:,i)/max(zfpre(:,i)); %normalizando amplitude            
     else
         zf(:,i) = zeros(t1+1,1);
         zfpre(:,i) = zeros(t1+1,1);
     end
end

vari = 1;
liminf = y(3,1);
limsup = y(3,2);
figure(2)
for i = 1:length(y)
    k = y(i,1);
while (k < y(i,2))
    subplot(3,1,1)
    plot(k:k+t1,z(:,vari))
    xlim([liminf limsup])
    title("Original");
    hold on
    subplot(3,1,2)
    plot(k:k+t1,zf(:,vari))
    xlim([liminf limsup])
    title("Sem preenfase");
    hold on
    subplot(3,1,3)
    plot(k:k+t1,zfpre(:,vari))
    xlim([liminf limsup])
    title("Com preenfase");
    hold on
    
    sgtitle(" T_{janela} = 20 ms ")
    
    k = k + t1;
    vari = vari +1;
    
end 
end
k=1;

for i = 1:size(z,2)
     final(k:k + t1) = zf(:,i);
     inicial(k:k + t1) = z(:,i);
     finalpre(k:k+t1) = zfpre(:,i);
     k = k+t1;
end
