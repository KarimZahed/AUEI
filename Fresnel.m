function [ D06 ] = Fresnel(freq,h1,h2)
%Equations from Annex 5, Section 18
%Path Length which just achieves a clearance of 0.6 of the first Fresnel zone over a smooth curved earth 
%D06 must be greater than 0.001 Km


Df=0.0000389*freq*h1*h2;

Dh=4.1*(sqrt(h1)+sqrt(h2));

D06=(Df*Dh)/(Df+Dh);

D06=max(0.001,D06);

end