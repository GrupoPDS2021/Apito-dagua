clc; clear; close all;

load("sugabalho/Gravacoes/papagaiomao1.mat");
audioIn = x;

speech_segmentation(audioIn, Fs);