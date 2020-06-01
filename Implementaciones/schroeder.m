%% START
clear; clear all; %close all; clc;

%% INPUT/OUTPUT
% [x fs]=wavread('voz anecoica corta.wav');
% x=x(:,1);
x=zeros(44100*3,1);
x(1,1)=1;
fs=44100;
yA=zeros(1,length(x));
yD=zeros(1,length(x));
%% FILTERS
% AP1=allpass(456,0.7);
% AP2=allpass(575,0.7);
% AP3=allpass(696,0.7);
% FB1=feedback(4562,0.7880);
% FB2=feedback(5752,0.7406);
% FB3=feedback(6963,0.6952);
% FB4=feedback(7782,0.6661);

% AP1=allpass(347,0.7);
% AP2=allpass(113,0.7);
% AP3=allpass(37,0.7);
% FB1=feedback(1687,0.773);
% FB2=feedback(1601,0.802);
% FB3=feedback(2053,0.753);
% FB4=feedback(2251,0.733);

AP1=allpass(322,0.7);
AP2=allpass(275,0.7);
AP3=allpass(696,0.7);
AP4=allpass(96,0.7);
FB1=feedback(3226,0.844);
FB2=feedback(3575,0.829);
FB3=feedback(4267,0.800);
FB4=feedback(4562,0.788);
FB5=feedback(5752,0.740);
FB6=feedback(6963,0.695);

%% FILTERING
for i=1:length(x)
    yAP1=AP1.process(x(i));
    yAP2=AP2.process(yAP1);
    yAP3=AP3.process(yAP2);
    yAP4=AP4.process(yAP3);
    yFB1=FB1.process(yAP4);
    yFB2=FB2.process(yAP4);
    yFB3=FB3.process(yAP4);
    yFB4=FB4.process(yAP4);
    yFB5=FB3.process(yAP4);
    yFB6=FB4.process(yAP4);
    yA(i)=yFB1+yFB2+yFB3+yFB4+yFB5+yFB6;
    yD(i)=yFB1-yFB2+yFB3-yFB4+yFB5-yFB6;
end
yB=-yA;
yC=-yD;
%% GRAPHIC
figure
graphic_function(x,yA,fs,'ARTIFICIAL REVERBERATION')
figure
graphic_function(x,yD,fs,'ARTIFICIAL REVERBERATION')
%% PLAYBACK
yA=yA'/max(abs(yA));
yD=yD'/max(abs(yD));
% wavplay([yA yD],fs)