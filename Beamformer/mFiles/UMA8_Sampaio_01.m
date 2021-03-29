%--------------------------------------------------------------------
% MiniDSP  UMA-8 v2
% USB Microphone Array with Embedded DSP
% Using UMA-8 with Matlab: 
% https://www.minidsp.com/applications/usb-mic-array/uma-8-16-matlab
%--------------------------------------------------------------------
clear; close all; clc;
% Defining recording interface using the device reader object
% Notice how the UMA-8/16 will be discovered as "miniDSP ASIO Driver". 
% Make sure that you use ASIO for your definition as standard WDM 
% recording object won't be working. 
fs = 48000;
audioFrameLength = 2*fs;
deviceReader = audioDeviceReader(...
 'Device', 'miniDSP ASIO Driver',...
 'Driver', 'ASIO', ...
 'SampleRate', fs, ...
 'NumChannels', 7 ,... 
 'OutputDataType','double',...
 'SamplesPerFrame', audioFrameLength);
%------------------------------------------------------------------
% That's all, you now have real time audio within your environment! 
% TESTAR ALGUMAS APLICAÇÕES!
% (0) Adquirir 3s de sinais dos 7 mics. 
% (1) Colocar para funcionar o estimador de DoA (adaptar de ULA
%     para arranjo circular) disponível em 
%     https://www.mathworks.com/help/audio/examples/live-direction-of-arrival-estimation-with-a-linear-microphone-array.html 
% (2) Real time recording in Matlab
%     https://www.mathworks.com/help/audio/gs/real-time-audio-in-matlab.html
% (3) beamforming_demo.m by Florent (miniDSP Forum Flo96)
%--------------------------------------------------------
% (0)
%--------------------------------------------------------
% Read a multichannel frame from the audio source
% The returned array is of size AudioFrameLenght x size(micPositions,2)
multichannelAudioFrame = step(deviceReader);
t=(0:(length(multichannelAudioFrame(:,1))-1))/fs;
subplot(7,1,1); plot(t,multichannelAudioFrame(:,1)); axis([0 2 -0.2 0.2])
subplot(7,1,2); plot(t,multichannelAudioFrame(:,2)); axis([0 2 -0.2 0.2])
subplot(7,1,3); plot(t,multichannelAudioFrame(:,3)); axis([0 2 -0.2 0.2])
subplot(7,1,4); plot(t,multichannelAudioFrame(:,4)); axis([0 2 -0.2 0.2])
subplot(7,1,5); plot(t,multichannelAudioFrame(:,5)); axis([0 2 -0.2 0.2])
subplot(7,1,6); plot(t,multichannelAudioFrame(:,6)); axis([0 2 -0.2 0.2])
subplot(7,1,7); plot(t,multichannelAudioFrame(:,7)); axis([0 2 -0.2 0.2])


