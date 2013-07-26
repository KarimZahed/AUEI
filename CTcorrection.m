function [ CT_correction ] = CTcorrection(freq,ha,R1)
%Equations from Annex 5, Section 10
%Clutter Transmission Correction, applies when Transmitting terminal is over or adjacent to land on which there is clutter 

hdif1=ha-R1;
Knu=0.0108*sqrt(freq);
theta_clut1=atan(hdif1/27)*180/pi;

if(R1>=ha)
    v= Knu*sqrt(hdif1*theta_clut1);
else
    v= -Knu*sqrt(hdif1*theta_clut1);
end 

	 Jv=(6.9+20*log10(sqrt(((v-0.1)^2)+1)+v-0.1));% Annex 5, 4.3 (12a)
     CT_correction=-Jv;

end