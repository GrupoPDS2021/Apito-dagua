clc; clear; close all;

load("sugabalho/Gravacoes/papagaiomao1.mat");
audioIn = x;

detectedIntervals = speech_segmentation(audioIn, Fs);
resultSize = detectedIntervals(length(detectedIntervals),2);
result = zeros(resultSize);

filteredSegments = zeros(length(detectedIntervals));
for i=1:length(detectedIntervals)
     filteredSegments(i) = filtro_principal_fusion(detectedIntervals(i,1),detectedIntervals(i,2));
end

for i=1:length(detectedIntervals)
    thisStart = detectedIntervals(i,1);
    thisEnd = detectedIntervals(i,2);
    nextStart = detectedIntervals(i+1,1);
    
    result(1:thisEnd) = audioIn;
    
    if (detectedIntervals(i+1,1)<detectedIntervals(i,2))
        for j=thisEnd:nextStart
            result(j) = mean(filteredSegments(i,j),filteredSegments(i+1,j));
        end
    end
end