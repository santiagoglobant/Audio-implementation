clc,clear all,close all
[input,Fs] = wavread('violin.wav');
input=input(:,1);

alfa=2;                 %factor de compresion/expansion   0.25 < alfa < 3
P=800;
L=1200;
Hop=round((L-P)/abs(alfa-1));
S=Hop*alfa;
N=L+S;
min_overlap=L-P;

% N=2000;                 %numero de samples por frame
% alfa=2;                 %
% Hop=400;                %offset para el analisis
% S=Hop*alfa;             %offset para la sintesis
% L=N-S;                  %Lmax
% min_overlap=L-800;      %numero de muestras minimo para overlap

M=floor((length(input)-N)/Hop);     %numero de frames a analizae
OutBuffer=input(1:N);               %inicializacion de la salida con 1er frame
for i=1:M
    frame=input(i*Hop:i*Hop+N-1);       %ventanas para el analisis (N samples) cada Hop
    seg1=OutBuffer(i*S:i*S+L-1);        %segmento para overlap-add (L samples) cada S 
    Xcorr=xcorr(frame(1:L),seg1);       
    Xcorr(length(Xcorr)-L-1:length(Xcorr)) = -inf;    %
    Xcorr(1: min_overlap) = -inf;       %asegurar un minimo de muestra de overlap
    [xmax loc]=max(Xcorr);              %punto de maxima correlacion entre segmentos

    fadeout=1:-1/(loc-1):0;             %el overlap sera de "loc" muestras, con xfades lineales 
    fadein =0: 1/(loc-1):1;
    Tail=seg1(end-loc+1:end).*fadeout'; %las ultimas "loc" muestras del seg1 se sobreponen y suman
    Begin=frame(1:loc).*fadein';        %a las primeras "loc" del frame actual de analisis
    Add=Tail+Begin;
    seg1=[seg1(1:end-loc);Add;frame(loc+1:N)];      %el segmento1 se actualiza con las primeras muestras del seg1 donde no hay overlap 
    seg1=seg1(1:N+1);                               %el xfade y el resto del frame actual de analisis
    OutBuffer=[OutBuffer(1:i*S-1);seg1];            %la salida se actualiza con solo N+1 muestras del segmento1
end