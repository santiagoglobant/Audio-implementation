%% INICIO
clear; clear all; close all; clc;

%% ENTRADA/SALIDA/MODULADOR
d=3;                            %Duración entrada [s]
fs=44100;                       %Frecuencia de muestreo [Hz]
t=0:1/fs:d-(1/fs);              %Eje de tiempo
%---------------------------------------------------------------
x=sin(2*pi*1000*t);             %Entrada

y=zeros(1,length(x));           %Salida

ratio=100;                      %Ganancia de modulación [veces]
fm=1;                           %Frecuencia de modulación [Hz]
m=ratio+ratio*sin(2*pi*fm*t);   %Modulador

%% FRACTIONAL DELAYS
F=fracDelay(0,'Linear');
F1=fracDelay(0,'AllPass');
z=zeros(1,length(x));           %Salida
for i=1:length(x)
    F.setDelay(m(i));
    F1.setDelay(m(i));
    y(i)=F.process(x(i));
    z(i)=F1.process(x(i));
end

%% GRAPHICS
plot(x)
hold on
plot(y,'r')