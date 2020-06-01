x=input('Ingrese el nombre de la se?al y su extension: ','s');
f=input('ingrese la frecuencia del flanger(tipicamente de 1 a 10 Hz: ');
g=input('ingrese el factor de retraso del flanger: ');

[signal,Fs]=wavread(x);
%Fs=44100;
t=0:1/Fs:(length(signal)/Fs)-(1/Fs);
%t=0:1/Fs:((220000)/Fs)-(1/Fs);
%signal=cos(2*pi*250*t);

d=fracdelayall(0);
y=zeros(1,length(signal));
n=g*(0.5*(1 + cos(2*pi*f*t)));

    for i=1:length(signal)
        d.setdelay(n(i))
        y(i)=d.process(signal(i));
    end
out=signal'+0.75*y;

sound(out,Fs)