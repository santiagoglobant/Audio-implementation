%% START
clear; clear all; close all; clc;

%% INPUT/OUTPUT
[x fs]=wavread('MALEVOICE',[75520 152800]);
y=zeros(1,length(x));
%% FILTER CONSTRUCTOR
AP1=filters(1051,0.7,'All Pass');
AP2=filters(337,0.7,'All Pass');
AP3=filters(113,0.7,'All Pass');
FB1=filters(4799,0.742,'Feedforward');
FB2=filters(4999,0.733,'Feedforward');
FB3=filters(5399,0.715,'Feedforward');
FB4=filters(5801,0.697,'Feedforward');
%% FILTERING SAMPLE BY SAMPLE [obj.process_code(sample)=obj.process_matlab(input)]
for i=1:length(x)
    yAP1=AP1.process(x(i));
    yAP2=AP2.process(yAP1);
    yAP3=AP3.process(yAP2);
    yFB1=FB1.process(yAP3);
    yFB2=FB2.process(yAP3);
    yFB3=FB3.process(yAP3);
    yFB4=FB4.process(yAP3);
    y(i)=yFB1+yFB2+yFB3+yFB4;
end
%% GRAPHIC
% graphic_function(x,yAP3,fs,'ARTIFICIAL REVERBERATION')
%% PLAYBACK
yAP3=yAP3'/max(abs(yAP3));
wavplay(yAP3,fs)