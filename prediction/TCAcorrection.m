function [ TCA_correction ] = TCAcorrection(freq, theta)
%Equations from Annex 5, Section 11
%Terrain Clearance Angle Correction, 
% Theta tca should be limited between 0.55 deg and 40 deg


 if theta<=0.55
		 TCA_correction=0;
		 
 elseif theta>=40
		 
 	 theta_tca=40; % set theta_tca to 40 degrees
		 
     vprime=0.036*sqrt(freq); %(32b)

	 v=0.065*theta_tca*sqrt(freq); %(32c)
	 
	 Jvprime=(6.9+20*log10(sqrt(((vprime-0.1)^2)+1)+vprime-0.1)); % Annex 5, 4.3 (12a)
	 
	 Jv=(6.9+20*log10(sqrt(((v-0.1)^2)+1)+v-0.1));% Annex 5, 4.3 (12a)

	 TCA_correction=Jvprime-Jv; %(32a)

 else % maintain same value of theta
	 
	 theta_tca=theta;
	 
	 vprime=0.036*sqrt(freq); %(32b)

	 v=0.065*theta_tca*sqrt(freq); %(32c)
	 
	 Jvprime=(6.9+20*log10(sqrt(((vprime-0.1)^2)+1)+vprime-0.1)); % Annex 5, 4.3 (12a)
	 
	 Jv=(6.9+20*log10(sqrt(((v-0.1)^2)+1)+v-0.1));% Annex 5, 4.3 (12a)

	 TCA_correction=Jvprime-Jv; %(32a)	 
	 
end



end