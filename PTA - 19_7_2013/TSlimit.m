function [ Ets ] = TSlimit(theta_eff, theta, h1,freq, T_perc, dist)
%Equations from Annex 5, Section 13
%Limiting field due to Tropospheric Scattering, used as a floor to overall prediction

k=4/3;%effective Earth radius factor for median refractivity conditions
a=6370;%radius of the Earth

	if theta_eff==0
			 theta_eff=atan(-h1/9000)*180/pi;
	end

	theta_scattering=180*dist/pi/k/a + theta + theta_eff;

	if theta_scattering<0
		 theta_scattering=0;   
	end
	 
	 Lf=(5*log10(freq)-2.5*(log10(freq)-3.3)^2);%frequency-dependent loss
	 N0=325;%median surface refractivity
	 Gt=10.1*(-log10(0.02*T_perc))^0.7 ;%time-dependent enhancement
	 Ets=24.4-20*log10(dist)-10*theta_scattering-Lf+0.15*N0+Gt;%the field strength predicted for tropospheric scattering
	 
	

end