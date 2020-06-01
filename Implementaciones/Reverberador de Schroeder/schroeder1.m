%% START
clear; clear all; close all; clc;

%% INPUT/OUTPUT
[x fs]=wavread('MALEVOICE',[75520 152800]);
yA=zeros(1,length(x));
yD=zeros(1,length(x));
%% FILTERS
AP1=filters(347,0.7,'All Pass');
AP2=filters(113,0.7,'All Pass');
AP3=filters(37,0.7,'All Pass');
FB1=filters(1687,0.773,'Feedback');
FB2=filters(1601,0.802,'Feedback');
FB3=filters(2053,0.753,'Feedback');
FB4=filters(2251,0.733,'Feedback');
%% FILTERING
for i=1:length(x)
    yAP1=AP1.process(x(i));
    yAP2=AP2.process(yAP1);
    yAP3=AP3.process(yAP2);
    yFB1=FB1.process(yAP3);
    yFB2=FB2.process(yAP3);
    yFB3=FB3.process(yAP3);
    yFB4=FB4.process(yAP3);
    yA(i)=yFB1+yFB2+yFB3+yFB4;
    yD(i)=yFB1-yFB2+yFB3-yFB4;
end
yB=-yA;
yC=-yD;
%% GRAPHIC
% graphic_function(x,yA,fs,'ARTIFICIAL REVERBERATION')
% figure
% graphic_function(x,yD,fs,'ARTIFICIAL REVERBERATION')
%% PLAYBACK
yA=yA'/max(abs(yA));
yD=yD'/max(abs(yD));
% wavplay([yA yD],fs)