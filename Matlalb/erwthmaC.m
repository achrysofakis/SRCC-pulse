%erwtimaC
clear all;
close all;
T=10^(-3);
over = 10;
a=0.5;
A=4;
N=100;
Ts=T/over;


%C1
figure(1);
b = (sign (randn(N,1)) + 1)/2;


%C2 a
x = bits_to_2PAM(b);


%C2 b
%simulate X(d(t))=sum(Xk*d(t-kT))
X_delta = 1/Ts*upsample(x,over);
%adds over-1 zeros between symbols respectivelly
t_d = 0:Ts:(N+N*(over-1)-1)*Ts;
plot(t_d, X_delta);
ylabel('TIME(sec)');
xlabel('Amplitude');
title('Xd(t)');


%C2 c
figure(2);
[ph,t]=srrc_pulse(T,over,A,a);
tX= (t_d(1)+t(1):Ts:t_d(end)+t(end));
X = conv(X_delta, ph).*Ts;
plot(tX,X);
ylabel('X');
xlabel('t');
title('Convolution of Xd(t) and Phi(t)');


%C2 d
%constructing second signal,Phi(-t), by inverting time Axis and Values
ph_Inv=ph(end:-1:1);
t_Inv= -t(end:-1:1);
Z = conv(X,ph_Inv).*Ts;
%new time for the second convolution
t_Z = ( tX(1) + t_Inv(1):Ts:tX(end)+t_Inv(end));
figure(3);
plot(t_Z,Z);
ylabel('Z(t)');
xlabel('t');
title('Convolution of X(t) and Phi(-t)');
figure(4);
plot(t_Z,Z);
hold on;
stem([0:N-1]*T,x);
ylabel('Z(kt)');
xlabel('t');
title('Comparison of the pulses Z(kT) and Xd');