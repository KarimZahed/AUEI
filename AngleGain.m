function [ Gref ] = AngleGain( phi, theta)
% this function accepts vector inputs
% phi is the horizontal angle
% theta is the vertical angle

phi_3db=65; %degrees
theta_3db=15; %degrees

ksi_alfa=(phi_3db)*(theta_3db).*sqrt( ( (sin(theta)).^2 +(sin(phi).*cos(theta)).^2)/ ((phi_3db*sin(theta)).^2 +(theta_3db*(sin(phi).*cos(theta)).^2)));

ksi=acos(cos(phi).*cos(theta));

x=ksi./ksi_alfa;

k=0.7;
x_k=sqrt(1-0.36*k);
lambda_k=12-10*log10(1+8*k);

Gref=zeros(length(theta),1);

x1=find( 0<=x & x <x_k );
Gref(x1)=-12*x.^2;
x2=find( x_k<=x & x <4);
Gref(x2)=-12*x.^2+10*log10(x.^(-1.5) + k );
x3=find( x >=4);
Gref(x3)=-lambda_k-15*log10(x);

%Gain is in dBi which is the same as dB
end

