function y = speech_segmentation(audioIn, fs)

full_wave = audioIn;
audioIn = full_wave;


windowDuration = 0.074; % seconds
numWindowSamples = round(windowDuration*fs);
win = hamming(numWindowSamples,'periodic');

percentOverlap = 35;
overlap = round(numWindowSamples*percentOverlap/100);

mergeDuration = 0.44;
mergeDist = round(mergeDuration*fs);

detectSpeech(audioIn,fs,"Window",win,"OverlapLength",overlap,"MergeDistance",mergeDist);

y = detectSpeech(audioIn,fs,"Window",win,"OverlapLength",overlap,"MergeDistance",mergeDist);

end