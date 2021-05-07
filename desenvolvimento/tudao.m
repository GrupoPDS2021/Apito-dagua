clc; clear; close all;

load("Gravações/papagaiomaolongo1.mat");
audioIn = x;
plot(x)
title("sinal de entrada")

y = speech_segmentation(audioIn, Fs);
t1 = 20*44,1; %janela de 20ms
z = segmentos(audioIn,y,t1); %segmentando audio em janelas de 20ms
% z ---> matriz onde colunas são meus segmentos de audio
 plot(z)
for i = 1 : size(z,2)    
    zpre(:,i) = preEmFilter(z(:,i));     
end

%sinals de entrada
rui = wgn_gen(100000); %ruído branco

imp = zeros(t1+1,1); % trem de impulso
imp(1) = 1;
temp = 1;


for i = 1 : size(z,2) 
     [a , b] = covpred(z(:,i),20); %sem pre enf
     zfimp(:,i) = filter(1 , [1 a.'],imp); %resposta ao impulso
     zfimp(:,i) = max(z(:,i))*zfimp(:,i)/max(zfimp(:,i)); %Normalizando amplitudes
     zftes(:,i) = filter(1 , [1 a.'],rui); %resposta ao ruido
     zfrui(1:t1+1,i) = max(z(:,i))*zftes(1:t1+1,i)/max(zftes(1:t1+1,i)); %normalizando amplitudes
     [a1 , b1] = covpred(zpre(:,i),20); %com pre enf
     zfpreimp(:,i) = filter(1 , [1 a1.'],imp); %resposta ao impulso
     zfpreimp(:,i) = max(z(:,i))*zfpreimp(:,i)/max(zfpreimp(:,i)); %normalizando amplitudes
     zfpretes(:,i) = filter(1 , [1 a1.'],rui); %resposta ao ruido
     zfprerui(:,i) = max(z(:,i))*zfpretes(1:t1+1,i)/max(zfpretes(1:t1+1,i)); %normalizando amplitudes
end

vari = 1;
liminf = y(3,1);
limsup = y(3,2);
figure(2)
for i = 1:length(y)
    k = y(i,1);
while (k < y(i,2))
    subplot(5,1,1)
    plot(k:k+t1,z(:,vari))
    xlim([liminf limsup])
    title("Original");
    hold on
    subplot(5,1,2)
    plot(k:k+t1,zfimp(:,vari))
    xlim([liminf limsup])
    title("Resposta ao impulso");
    hold on
    subplot(5,1,3)
    plot(k:k+t1,zfrui(:,vari))
    xlim([liminf limsup])
    title("Resposta ao Ruído Branco");
    hold on
    subplot(5,1,4)
    plot(k:k+t1,zfprerui(:,vari))
    xlim([liminf limsup])
    title("Resposta ao Ruído Branco(pre)");
    hold on
    subplot(5,1,5)
    plot(k:k+t1,zfpreimp(:,vari))
    xlim([liminf limsup])
    title("Resposta ao impulso(pre)");
    hold on
    
    sgtitle(" T_{janela} = 20 ms ")
    
    k = k + t1;
    vari = vari +1;
    
end

end

while j < length(x)
    
    finalimp(k:k + t1) = zfimp(:,i);
    inicial(k:k + t1) = z(:,i);
    finalruido(k:k+t1) = zfrui(:,i);
    finalimppre(k:k + t1) = zfpreimp(:,i);
    finalruidopre(k:k + t1) = zfprerui(:,i);
k = 1;
for i = 1:size(z,2)
    finalimp(k:k + t1) = zfimp(:,i);
    inicial(k:k + t1) = z(:,i);
    finalruido(k:k+t1) = zfrui(:,i);
    finalimppre(k:k + t1) = zfpreimp(:,i);
    finalruidopre(k:k + t1) = zfprerui(:,i);
    k = k + t1;
end

end
    
erroimp=mean((inicial'-finalimp').^2);
errorui=mean((inicial'-finalruido').^2);
erropreimp=mean((inicial'-finalimppre').^2);
erroprerui=mean((inicial'-finalruidopre').^2);
    
% [YFISK,w]=freqz(final,1,40000,'whole');
% [YFISK1,w]=freqz(inicial,1,40000,'whole');
% [YFISK2,w]=freqz(finalruido,1,40000,'whole');
% figure(1)
% 
% subplot(3,1,2)
% plot((Fs/2)*(w-pi)/pi,abs(fftshift(YFISK)));
% xlim([-1e4 1e4])
% title("Impulso");
% subplot(3,1,1)
% plot((Fs/2)*(w-pi)/pi,abs(fftshift(YFISK1)));
% xlim([-1e4 1e4])
% title("Original");
% subplot(3,1,3)
% plot((Fs/2)*(w-pi)/pi,abs(fftshift(YFISK2)));
% xlim([-1e4 1e4])
% title("White noise");
% sgtitle(" T_{janela} = 15 ms ")
% 
% 
% 
sound(50*inicial,44100)

sound(50*finalimp,44100)
sound(50*finalruido,44100)
sound(50*finalruidopre,44100)
sound(50*finalimppre,44100)
audiowrite('inicial.wav',50*inicial,Fs)
audiowrite('impulso.wav',50*finalimp,Fs)
audiowrite('ruido.wav',50*finalruido,Fs)
audiowrite('pre_ruidobranco.wav',50*finalruidopre,Fs)
audiowrite('pre_impulso.wav',50*finalimppre,Fs)
