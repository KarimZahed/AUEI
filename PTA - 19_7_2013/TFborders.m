function [ T_perc_max,T_perc_min, freq_max,freq_min ] = TFborders(freq, T_perc)
%Outputs the border values of frequency and time 

%% Time percentage borders
	if T_perc >= 1 && T_perc<10
		T_perc_min=1;
		T_perc_max=10;
	elseif T_perc>=10 && T_perc<50
		T_perc_min=10;
		T_perc_max=50;
	else
		T_perc_min=50;
	    T_perc_max=50;		
	end

%% frequency borders
	if freq<100 %extrapolation limits
		freq_min=100;
		freq_max=600;
		
	elseif freq>=100 && freq <600
		freq_min=100;
		freq_max=600;

	elseif freq>=600 && freq<2000
			freq_min=600;
			freq_max=2000;
	elseif freq==2000 
				freq_min=2000;
				freq_max=2000;
	elseif freq>2000 %extrapolation limits
				freq_min=600;
				freq_max=2000;
	end

end