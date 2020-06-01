%LABORATORIO DE LA TRANSFORMADA DISCRETA DE FOURIER (DFT)

%1. Usar la funcion fft para calcular la DFT de las siguientes
%   señales de longitud N=8 muestras.

% x1=[2 1 0 0 0 0 0 1];
% X1=fft(x1);
% N=length(x1);
% freq=(0:1/N:1-1/N)*2*pi;
% figure(4)
% subplot(221)
% stem(freq,real(X1));
% title('Parte Real de la DFT')
% xlim([0 2*pi])
% set(gca,'XTick',0:2*pi/N:2*pi)
% set(gca,'XTickLabel',{'0','1*2pi/N','2*2pi/N','3*2pi/N','pi','5*2pi/N','6*2pi/N','7*2pi/N','2pi'})
% subplot(222)
% stem(freq,imag(X1))
% title('Parte Imaginaria de la DFT')
% xlim([0 2*pi])
% set(gca,'XTick',0:2*pi/N:2*pi)
% set(gca,'XTickLabel',{'0','1*2pi/N','2*2pi/N','3*2pi/N','pi','5*2pi/N','6*2pi/N','7*2pi/N','2pi'})
% subplot(223)
% stem(freq,abs(X1))
% title('Magnitud de la DFT')
% xlim([0 2*pi])
% set(gca,'XTick',0:2*pi/N:2*pi)
% set(gca,'XTickLabel',{'0','1*2pi/N','2*2pi/N','3*2pi/N','pi','5*2pi/N','6*2pi/N','7*2pi/N','2pi'})
% subplot(224)
% stem(freq,phase(X1))
% title('Fase de la DFT')
% xlim([0 2*pi])
% set(gca,'XTick',0:2*pi/N:2*pi)
% set(gca,'XTickLabel',{'0','1*2pi/N','2*2pi/N','3*2pi/N','pi','5*2pi/N','6*2pi/N','7*2pi/N','2pi'})


%2. Usar la señal x=[1 2 3 4 5 6 7 8] y la funcion fft para verificar las
%   siguientes propiedades de la DFT

% x1=[1 2 3 4 5 6 7 8];
% %x2=[x1 zeros(1,8)];            %  zeropadding <-> interpolacion        
% %x2=[x1 x1 x1 x1];              %  repeat <-> stretch
% x2=[2 3 4 5 6 7 8 1];           %  time shift <-> linear phase term
% N1=length(x1);
% freq1=(0:1/N1:1-1/N1)*2*pi;
% N2=length(x2);
% freq2=(0:1/N2:1-1/N2)*2*pi;
% figure
% stem(freq1,abs(fft(x1))/N1)
% hold on
% plot(freq2,abs(fft(x2))/N2,'-*r')
% title('Magnitud de la DFT')
% legend('sin zeropadding','con zero padding')
% xlim([0 2*pi])
% set(gca,'XTick',0:2*pi/N:2*pi)
% set(gca,'XTickLabel',{'0','1*2pi/N','2*2pi/N','3*2pi/N','pi','5*2pi/N','6*2pi/N','7*2pi/N','2pi'})
% 
% %  grafica de la fase del espectro para ver el termino de fase lineal que se
% %  agrega a la fase.
% figure
% stem(freq1,phase(fft(x1)))
% hold on
% plot(freq2,phase(fft(x2)),'-*r')
% title('Fase de la DFT')
% legend('sin zeropadding','con zero padding')
% xlim([0 2*pi])
% set(gca,'XTick',0:2*pi/N:2*pi)
% set(gca,'XTickLabel',{'0','1*2pi/N','2*2pi/N','3*2pi/N','pi','5*2pi/N','6*2pi/N','7*2pi/N','2pi'})
% 
% %  Propiedad de la simetria: 
% %  Si x es real entonces abs(X) es par y angle(X)es impar
% x1=[1 2 3 4 5 6 7 8 9];                 
% N1=length(x1);
% figure
% freq1=(-0.5:1/N1:0.5-1/N1)*2*pi;
% subplot(211)
% stem(freq1,fftshift(abs(fft(x1))))
% subplot(212)
% stem(freq1,fftshift(angle(fft(x1))))
% 
% %   Teorema de Parseval
% x1=[1 2 3 4 5 6 7 8];
% N1=length(x1);
% X1=fft(x1);
% sum(x1.^2)
% sum(abs(X1).*abs(X1))/N1

% 3. ****************  spectral leakage  *********************
% t=0:1/44100:0.1-1/44100;
% f=10*44100/1024;
% x=cos(2*pi*f*t);
% N=1024;
% figure
% subplot(321)
% plot(t(1:N),x(1:N))
% X=fft(x(1:N));
% frec=(0:1/N:1-1/N)*2*pi;
% subplot(322)
% stem(frec(1:N/2),abs(X(1:N/2)))
% str = sprintf('La frecuencia obtenida en el espectro es %d Hz ', frec(11)*44100/(2*pi));
% disp(str);
% str = sprintf('La frecuencia real es %d Hz ', f);
% disp(str);
% 
% f2=10.25*44100/1024;
% x2=cos(2*pi*f2*t);
% subplot(323)
% plot(t(1:N),x2(1:N))
% X2=fft(x2(1:N));
% frec=(0:1/N:1-1/N)*2*pi;
% subplot(324)
% stem(frec(1:N/2),abs(X2(1:N/2)))
% str = sprintf('La frecuencia obtenida en el espectro es %d Hz ', frec(11)*44100/(2*pi));
% disp(str);
% str = sprintf('La frecuencia real es %d Hz ', f2);
% disp(str);
% 
% f3=10.5*44100/1024;
% x3=cos(2*pi*f3*t);
% subplot(325)
% plot(t(1:N),x3(1:N))
% X3=fft(x3(1:N));
% frec=(0:1/N:1-1/N)*2*pi;
% subplot(326)
% stem(frec(1:N/2),abs(X3(1:N/2)))
% str = sprintf('La frecuencia obtenida en el espectro es %d Hz ', frec(12)*44100/(2*pi));
% disp(str);
% str = sprintf('La frecuencia real es %d Hz ', f3);
% disp(str);

% 4. ****************  zero-phase windowing  *********************
t=0:1/44100:0.1-1/44100;
f=10*44100/1024;
x=cos(2*pi*f*t);
x1=x(1:801);
xlength=length(x1);
N=1024;
fftbuffer=zeros(1,N);
fftbuffer(1:(xlength+1)/2)=x1((end+1)/2:end);
fftbuffer(end-(xlength-1)/2+1:end)=x1(1:(end-1)/2);
X=fft(fftbuffer);
X1=fft(x1,1024);
figure
subplot(211)
stem(abs(X(1:25)))
hold on
stem(abs(X1(1:25)),'*')
subplot(212)
plot(unwrap(angle(X(1:512))))
hold on
plot(unwrap(angle(X1(1:512))),'r')

% x2=x(1+6:801+6);
% fftbuffer=zeros(1,N);
% fftbuffer(1:(xlength+1)/2)=x2((end+1)/2:end);
% fftbuffer(end-(xlength-1)/2+1:end)=x2(1:(end-1)/2);
% X=fft(fftbuffer);
% hold on
% subplot(211)
% stem(abs(X(1:25)),'r')
% subplot(212)
% stem(unwrap(angle(X(1:25))),'r')
% 
% x3=x(1+50:801+50);
% fftbuffer=zeros(1,N);
% fftbuffer(1:(xlength+1)/2)=x3((end+1)/2:end);
% fftbuffer(end-(xlength-1)/2+1:end)=x3(1:(end-1)/2);
% X=fft(fftbuffer);
% hold on
% subplot(211)
% stem(abs(X(1:25)),'g')
% subplot(212)
% stem(unwrap(angle(X(1:25))),'g')