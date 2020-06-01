%% START
clear; clear all; close all; clc;

%% INPUT/OUTPUT
[x fs]=wavread('MALEVOICE',[75520 152800]);
yAP3=zeros(1,length(x));
%% FILTERS
AP1=filters(125,0.7,'All Pass');
AP2=filters(42,0.7,'All Pass');
AP3=filters(12,0.7,'All Pass');
FB1=filters(901,0.805,'Feedback');
FB2=filters(778,0.827,'Feedback');
FB3=filters(1011,0.783,'Feedback');
FB4=filters(1123,0.764,'Feedback');
%% FILTERING SAMPLE BY SAMPLE [obj.process_code(sample)=obj.process_matlab(input)]
for i=1:length(x)
    yFB1=FB1.process(x);
    yFB2=FB2.process(x);
    yFB3=FB3.process(x);
    yFB4=FB4.process(x);
    y=yFB1+yFB2+yFB3+yFB4;
    yAP1=AP1.process(y);
    yAP2=AP2.process(yAP1);
    yAP3(i)=AP3.process(yAP2);
end
%% GRAPHIC
% graphic_function(x,yAP3,fs,'ARTIFICIAL REVERBERATION')
%% PLAYBACK
yAP3=yAP3'/max(abs(yAP3));
wavplay(yAP3,fs)