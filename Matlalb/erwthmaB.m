%erwtimaB
clear all;
close all;
T=10^(-3);
over=10;
Ts=T/over;
A=4;
rolloff = [0 0.5 1];
for k=[0 1 2 3] %For each k
 for i=[1 2 3] %For all of our roll-off numbers a.
 if(k<3)%We dont need the k=3 for our plots just to calculate our integral


 %B1
 figure; %Create our new figure for each of k and a
 subplot(2,1,1); %sublpot for φ(t) & φ(t-kT)
 [ph1,t] = srrc_pulse(T,over,A,rolloff(i));
 %Create our φ(t-kT);
 pha= [ph1, zeros(1,10*k)];
 phb=[zeros(1,10*k),ph1];
 %Here we need to create our new time after adding the zeros
 ts=[0:Ts:length(t)*Ts+T*k-Ts];
 %Plot for our φ(t)
 plot1 = plot(ts,pha);
 hold on;
 %Plot for our φ(t-kT)
 plot2 = plot(ts,phb);
 ylabel('Phi(t), Phi(t-kT) ');
 xlabel('TIME(sec)');
 title(['Phi(t), Phi(t-kT) Pulses a= ' ,num2str(rolloff(i)), ' k= ',num2str(k)]);
 legend([plot1, plot2],'Phi(t)' , 'Phi(t-kT)');

 
 %b2 create their product
 subplot(2,1,2); %sublpot for φ(t) & φ(t-kT)
 phP = pha.*phb;
 plot(ts, phP);
 ylabel('Phi(t) * Phi(t-kT) ');
 xlabel('TIME(sec)');
 title(['Phi(t) * Phi(t-kT) Pulse a= ' ,num2str(rolloff(i)), ' k= ',num2str(k)]);
 end


 %b3 calculate their integral
 if(k==3)%We need this for out integral ONLY in k=3
 [ph1,t] = srrc_pulse(T,over,A,rolloff(i));
 %Create our φ(t-kT);
 pha= [ph1, zeros(1,10*k)];
 phb=[zeros(1,10*k),ph1];
 phP=pha.*phb;
 end
 integral = sum(phP).*Ts; %Calculate it here
 fprintf('\nThe Integral of Phi(t)*Phi(t-kT) for a= %2f and k=%d is : %2f ',rolloff(i),k,integral);
 end
end