%erwtimaA
clear all;
close all;
%A.1
T=10^(-3);
over = 10;
A=4;
Ts=T/over;
rolloff = [0 0.5 1];
figure(1);
hold on;


%A1
%SRRC pulse plot
for i=[1 2 3] %Here we create and plot srrc pulse for all of our roll-off factors
 [ph(i,:),t] = srrc_pulse(T,over,A,rolloff(i));
 a(i) =plot(t,ph(i,:));
end
ylabel( 'PH(t)' );
xlabel( 'TIME(SECONDS)' );
title( 'OUR SRRC pulses for 3 diffrent roll-off factors(0,0.5,1)');
legend([a(1), a(2) ,a(3)], 'a = 0', 'a=0.5', 'a=1');
%A.2
Fs = 1/Ts;
Nf = 1024;
F=(-Fs/2:Fs/Nf:Fs/2-Fs/Nf);
figure(2);
hold on;


%A.2.a
%We need to do our Fourier Transform
for i=[1 2 3] %Here we create our Plot psd for all of our roll-off factors
 FFT(i,:) = fftshift(fft(ph(i,:),Nf)*Ts);
 a(i) = plot(F,abs(FFT(i,:)).^2);
end
ylabel('|PH(F)|^2');
xlabel('F');
title('Common Plot of Energy Spectrum');
legend([a(1), a(2) ,a(3)], 'a = 0', 'a=0.5', 'a=1');


%A.2.b
figure(3);
for i = [1 2 3] %Here we create out Semilogy psd for all of our roll-off factors
 a(i) = semilogy(F,abs(FFT(i,:)).^2);
 hold on;
end
ylabel('|PH(F)|^2');
xlabel('F');
title('Common Semilogy for Energy Spectum');
legend([a(1), a(2) ,a(3)], 'a = 0', 'a=0.5', 'a=1');


%A.3.
%defining the theoritical bandwidth [BW = (1+a)/2T]
BW1=1/(2*T);
BW2=1.5/(2*T);
BW3=1/T;
%Given Data
c1=(T/10^3)*ones(1,Nf);
c2=(T/10^5)*ones(1,Nf);
figure(4);
for i = [1 2 3] %Here we create out Semilogy psd for all of our roll-off factors
 a(i) = semilogy(F,abs(FFT(i,:)).^2);
 hold on;
end
%Common semilogy and a c1
semilogy(F,c1);
ylabel('Energy spectrum of SRRC pulses=|P(F)|^2');
xlabel('F');
title('Common Semilogy for Energy Spectum with c1');
legend([a(1), a(2) ,a(3)], 'a = 0', 'a=0.5', 'a=1');
figure(5);
for i = [1 2 3] %Here we create out Semilogy psd for all of our roll-off factors
 a(i) = semilogy(F,abs(FFT(i,:)).^2);
 hold on;
end
%Common semilogy and a c2
semilogy(F,c2);
ylabel('Energy spectrum of SRRC pulses=|P(F)|^2');
xlabel('F');
title('Common Semilogy for Energy Spectum with c2');
legend([a(1), a(2) ,a(3)], 'a = 0', 'a=0.5', 'a=1');

