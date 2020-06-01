clc,clear all,close all
[input,Fs] = wavread('violin.wav');
input=input(:,1);
Hop=200;
N=400;
alfa=2;
S=alfa*Hop;
L=N-S;
M=floor((length(input)-N)/Hop);
OutBuffer=input(1:N);
for i=1:M
    frame=input(i*Hop+1:i*Hop+N);
    Xcorr=xcorr(frame(1:L),OutBuffer(end-L+1:end));
    [xmax loc]=max(Xcorr);
    loc=loc-L;
    %loc=0;
    fadeout=1:(-1/(length(OutBuffer)-(i*S+loc+1))):0;
    fadein =0: (1/(length(OutBuffer)-(i*S+loc+1))):1;
    Tail=OutBuffer(length(OutBuffer)-length(fadeout)+1:length(OutBuffer)).*fadeout';
    %Begin=frame(loc+1:L).*fadein';
    Begin=frame(1:length(fadein)).*fadein';
    Add=Tail+Begin;
    OutBuffer=[OutBuffer(1:i*S+loc);Add;frame(length(fadein)+1:N)];
end