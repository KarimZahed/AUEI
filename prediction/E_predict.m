function [ L_b, E] = E_predict(PathType,freq,dist,T_perc,h1,ha,heff,h2,R1,R2,environment,theta,theta_eff, AdjToSea, RecOnLand )
%Customized version ot predict_f to be used in the Monte Carlo Simulations.
%function [ E,MFS ,TCA_correction,Ets ] = predict_f(PathType,freq,dist,T_perc,h1,ha,heff,h2,R1,R2,environment,theta,theta_eff )
%Updated on the basis of Draft REvision of Recommendation ITU-R2 P.1546-4
%This code is applicable only to 50% location variability 
Flag_E=0;% flag indicator showing that we have already calculated the field strength
TCA_correction=0;
%% effective distance between the two antennas
%height_diff=(abs(h1-h2))/1000;
%eff_dist=sqrt(height_diff.^2+ dist.^2); % new effective distance

%% Saving the old value of dist as it will be set to 1 if 0.04<dist<1
dist_old=dist;
 if dist <1 && dist >0.04 
     dist=1;
  end     

%% Step 0
if dist>=1 %(Steps 1-16 should be done as instructed in Step 0 considering the distance conditions
    
%% Step 2 and 3 - Finding Time and Frequency Borders
[T_perc_max,T_perc_min, freq_max,freq_min ] = TFborders(freq, T_perc);
		
%% An approximation to the inverse complementary cumulative normal distribution function annex 5, Section 16    
[ Q,Q_max,Q_min ]=ICCND(T_perc, T_perc_min, T_perc_max);
  
%% Search of the correspondent matrix (ITU digitized curves)
M=CorrespondentMatrix(freq_min , freq_max, T_perc_min, T_perc_max, PathType, 1); % for the condition freq=freq_min -> cond=1

%% Step 4            
% Distance borders
dist_tab=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 110 120 130 140 150 160 170 180 190 200 225 250 275 300 325 350 375 400 425 450 475 500 525 550 575 600 625 650 675 700 725 750 775 800 825 850 875 900 925 950 975 1000];
	if dist<1
		dist_min=1;
		dist_max=1;
    end    
    for i=1:length(dist_tab)-1
            if dist>=dist_tab(i) && dist<dist_tab(i+1)
                dist_min=dist_tab(i);
                dist_max=dist_tab(i+1);
            end
            if dist==1000
                dist_min=1000;
            end
    end
%%	Step 1 Starts here with necessary calculation done above
if strcmpi(PathType,'land') % Antenna height cases for Land Path
	 %Annex 5 Section 3.1.1
	 if dist<=3
		 h1=ha;
	 elseif dist>3 &&dist<15
		 h1=ha+((heff-ha)*(dist -3)/12);
	 elseif dist>=15
		 h1=heff;
     end
     
%% Step 8
     % h1<10 meters :
 % Step 8.2 Since h1 <10,  Sections 4.2 (land) && 4.3 (sea) 
	  if h1<0 % negative values of h1 
		  
		   % finding E10 and E20
			i=dist_tab==dist_min;
			E10=M(i,1);
			E20=M(i,2);
			C1020=E10-E20;%correction					
			
            [E,C_h1_0, C_h1real] = TAHfield(E10,h1,freq_max,C1020);

			%interpolation for distance
				if dist~=dist_min
					E_inf=E;
					i=dist_tab==dist_max;
					E10sup=M(i,1);
					E20sup=M(i,2);
					C1020sup=E10sup-E20sup;%correction
					%correction C_h1neg10
					E_zero=E10sup+0.5*(C1020sup+C_h1_0);
					% Correction C_h1real
					E_sup=E_zero+C_h1real;
					%application of interpolation method annexe 5 paragraphe 5
					E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
				end
				Efmin=E;
				
						
			%frequency interpolation
			if freq~=freq_min
				% search of the correspondant matrix in the case when freq ~= min -> cond=2
				M=CorrespondentMatrix(freq_min , freq_max, T_perc_min,T_perc_max, PathType, 2);
				
				% finding E10 and E20
				i=dist_tab==dist_min;
				E10=M(i,1);
				E20=M(i,2);
				C1020=E10-E20;%correction

                [E, C_h1_0, C_h1real] = TAHfield(E10,h1,freq_max,C1020);	              

				if dist~=dist_min
                    E_inf=E;
                    i=dist_tab==dist_max;
                    E10sup=M(i,1);
                    E20sup=M(i,2);
                     C1020sup=E10sup-E20sup;%correction
                    %correction C_h1neg10
                    E_zero=E10sup+0.5*(C1020sup+C_h1_0);
                    % Correction C_h1real
                    E_sup=E_zero+C_h1real;
                    %application of interpolation method annexe 5 paragraphe 5
                    E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
                end
                 Efmax=E;
                 %interpolation of frequency using method annexe 5 paragraphe 6:
                 E=Efmin+(Efmax-Efmin)*log10(freq/freq_min)/log10(freq_max/freq_min);
                 
                     % Limit to Maximum Field Strength
                        if E>106.9-20*log10(dist)
                             E=106.9-20*log10(dist);
                        end 
                end
		 Flag_E=1;   		 
    %% height between 0 and 10 meters
	  elseif h1<10 && h1>=0
			% finding E10 and E20
			i=dist_tab==dist_min;
			E10=M(i,1);
			E20=M(i,2);
			
					C1020=E10-E20;%correction
                    [E,C_h1neg10,C_h1real]=TAHfield(E10,h1,freq_max,C1020);

					%interpolation for distance
				if dist~=dist_min
					E_inf=E;
					i=dist_tab==dist_max;
					E10sup=M(i,1);
					E20sup=M(i,2);
					C1020sup=E10sup-E20sup;%correction
					%correction C_h1neg10
					E_zero=E10sup+0.5*(C1020sup+C_h1neg10);
					% Correction C_h1real
					E_sup=E_zero+0.1*h1*(E10sup-E_zero);
					%application of interpolation method annexe 5 paragraphe 5
					E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
                end			
			Efmin=E;
					
			if freq~=freq_min
			 %% search of the correspondant matrix in the case when freq ~= min -> cond=2
				M=CorrespondentMatrix(freq_min , freq_max, T_perc_min,T_perc_max, PathType, 2);
				
				% finding E10 and E20
				i=dist_tab==dist_min;
				E10=M(i,1);
				E20=M(i,2);
			  
                C1020=E10-E20;%correction
                [E, C_h1neg10 , C_h1real]=TAHfield(E10,h1,freq_max,C1020);
							
			%interpolation for distance							
				if dist~=dist_min
					E_inf=E;
					i=dist_tab==dist_max;
					E10sup=M(i,1);
					E20sup=M(i,2);
					C1020sup=E10sup-E20sup;%correction
					%correction C_h1neg10
					E_zero=E10sup+0.5*(C1020sup+C_h1neg10);
					% Correction C_h1real
					E_sup=E_zero+0.1*h1*(E10sup-E_zero);
					%application of interpolation method annexe 5 paragraphe 5
					E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
				end
						
				Efmax=E;
				%interpolation of frequency using method annexe 5 paragraphe 6:
				E=Efmin+(Efmax-Efmin)*log10(freq/freq_min)/log10(freq_max/freq_min);
				 % Limit to Maximum Field Strength
                        if E>106.9-20*log10(dist)
                             E=106.9-20*log10(dist);
                        end 
		  end
			Flag_E=1;
      end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %% Antenna height cases for Sea Path, Annex 5 Section 4.2
else %% Otherwise it is a Sea Path 
    
    if h1<10 % Cannot be negative anyway
     
        Dh1=Fresnel(freq,h1,10);      % the 0.6 Fresnel clearance path length, Annex 5 Section 18     
        D20=Fresnel(freq,20,10);
  
        if dist <= Dh1
            E=106.9-20*log10(dist)+2.38*(1-exp(-dist/8.94))*log10(50/T_perc); % Annex 5 Section 2, E=Emax=Ese+Efs (1b)
            Flag_E=1;
        elseif (Dh1<dist) && (dist<D20)
            EDh1=106.9-20*log10(Dh1)+2.38*(1-exp(-Dh1/8.94))*log10(50/T_perc);
            i=dist_tab==D20;
            ED20=M(i,1)+(M(i,2)-M(i,1))*log10(h1/10)/log10(20/10);
            E=(ED20-EDh1)*log10(dist/Dh1)/log10(D20/Dh1);
            Flag_E=1;
        elseif dist>=D20
            i=dist_tab==dist_min;
            Eprime=M(i,1)+(M(i,2)-M(i,1))*log10(h1/10)/log10(20/10);
             E10=M(i,1);
             E20=M(i,2);
            
			C1020=E10-E20;
            % Field from Transmitter Antenna height 4.2,4.3
            [Eseconde,C_h1neg10,C_h1real]= TAHfield(E10,h1,freq_max,C1020);
                        
            Fs=(dist-D20)/dist;
            
            E=Eprime*(1-Fs)+Eseconde*Fs;    %(11c)
            
            
            if dist~=dist_min
               
                E_inf=E;
                i=dist_tab==dist_max;
                Eprime=M(i,1)+(M(i,2)-M(i,1))*log10(h1/10)/log10(20/10);
                E10sup=M(i,1);
                E20sup=M(i,2);
                C1020sup=E10sup-E20sup;%correction
             
                E_zero=E10sup+0.5*(C1020sup+C_h1neg10);
                Eseconde=E_zero+0.1*h1*(E10sup-E_zero);

                Fs=(dist-D20)/dist;

                E_sup=Eprime*(1-Fs)+Eseconde*Fs;
                %application of interpolation method annexe 5 Section 5
                E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
                
            end
            Efmin=E;
           
            if freq ~=freq_min
                i=dist_tab==dist_min;
                Eprime=M(i,1)+(M(i,2)-M(i,1))*log10(h1/10)/log10(20/10);
                E10=M(i,1);
                E20=M(i,2);
                C1020=E10-E20;
         
                E_zero=E10+0.5*(C1020+C_h1neg10);
                Eseconde=E_zero+0.1*h1*(E10-E_zero);

                Fs=(dist-D20)/dist;
                E=Eprime*(1-Fs)+Eseconde*Fs;
					
                if dist~=dist_min

                    E_inf=E;
                    i=dist_tab==dist_max;
                    Eprime=M(i,1)+(M(i,2)-M(i,1))*log10(h1/10)/log10(20/10);
                    E10sup=M(i,1);
                    E20sup=M(i,2);
                    C1020sup=E10sup-E20sup;%correction

                    E_zero=E10sup+0.5*(C1020sup+C_h1neg10);
                    Eseconde=E_zero+0.1*h1*(E10sup-E_zero);

                    Fs=(dist-D20)/dist;

                    E_sup=Eprime*(1-Fs)+Eseconde*Fs;
                    %application of interpolation method annexe 5 paragraphe 5
                    E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
                    
                end
                Efmax=E;
                %interpolation of frequency using method annexe 5 paragraphe 6:
            E=Efmin+(Efmax-Efmin)*log10(freq/freq_min)/log10(freq_max/freq_min);
            % Maximum field strength for Sea condition 
            if E>106.9-20*log10(dist)+2.38*(1-exp(-dist/8.94))*log10(50/T_perc)
         E=106.9-20*log10(dist)+2.38*(1-exp(-dist/8.94))*log10(50/T_perc);
             end
            Flag_E=1;
            end
            
        end
    end
end


%% % Step 9 Retrieving field strength
if Flag_E==0 
    
    %% Step 8.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
% Antenna height borders 
h1_tab=[10 20 37.5 75 150 300 600 1200];
        if h1>1200 && h1<3000 %extrapolation over 1200 meters
            h1_max=1200;
            h1_min=600;
        else
            for i=1:length(h1_tab)-1
                if h1>=h1_tab(i) && h1<h1_tab(i+1)
                    h1_min=h1_tab(i);
                    h1_max=h1_tab(i+1);
                end
            end
        end
		% finding the index of dist_min and h1_min
		i=dist_tab==dist_min;
		j=h1_tab==h1_min;

		% finding field strength E_inf
		E_inf=M(i,j);
		E=E_inf;
		 %check for need of interpolation for distance
		  if dist~= dist_min && h1==h1_min
			i=dist_tab==dist_max;
			E_sup=M(i,j);
			%application of interpolation method annexe 5 paragraphe 5
			E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
		  end

		%check for need of interpolation for height
		 if h1~=h1_min
			jj=h1_tab==h1_max;
			
			E_sup=M(i,jj);
			%application of interpolation method annexe 5 paragraphe 4.1
			E=E_inf+(E_sup-E_inf)*log10(h1/h1_min)/log10(h1_max/h1_min);
			E_height=E;
		 end  
		% double interpolation method
	   if dist~= dist_min && h1~=h1_min
		   ii=dist_tab==dist_max;
		   jj=h1_tab==h1_max;
		   E_h1_d=M(i,j)+(M(ii,j)-M(i,j))*log10(dist/dist_min)/log10(dist_max/dist_min);
		   E_h2_d=M(i,jj)+(M(ii,jj)-M(i,jj))*log10(dist/dist_min)/log10(dist_max/dist_min);
		   E_h_d=E_h1_d+(E_h2_d-E_h1_d)*log10(h1/h1_min)/log10(h1_max/h1_min);
		   E=E_h_d;
	   end 
		E_fmin_Tmin=E;
		E_f_Tmin=E;
					
	%%
    if freq ~=freq_min
        %% search of the correspondant matrix
        M=CorrespondentMatrix(freq_min , freq_max, T_perc_min,T_perc_max, PathType, 2);

        %% Retreiving field strength
        if Flag_E==0
            % finding the index of dist_min and h1_min
            i=dist_tab==dist_min;
            j=h1_tab==h1_min;

            % finding field strength E_inf
            E_inf=M(i,j);
            E=E_inf;
             %check for need of interpolation for distance
              if dist~= dist_min && h1==h1_min
                i=dist_tab==dist_max;
                E_sup=M(i,j);
                %application of interpolation method annexe 5 paragraphe 5
                E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
              end

            %check for need of interpolation for height
             if h1~=h1_min
                jj=h1_tab==h1_max;
                E_sup=M(i,jj);
                %application of interpolation method annexe 5 paragraphe 4.1
                E=E_inf+(E_sup-E_inf)*log10(h1/h1_min)/log10(h1_max/h1_min);
                E_height=E;

             end  
            % double interpolation method
            if dist~= dist_min && h1~=h1_min
               ii=dist_tab==dist_max;
               jj=h1_tab==h1_max;
               E_h1_d=M(i,j)+(M(ii,j)-M(i,j))*log10(dist/dist_min)/log10(dist_max/dist_min);
               E_h2_d=M(i,jj)+(M(ii,jj)-M(i,jj))*log10(dist/dist_min)/log10(dist_max/dist_min);
               E_h_d=E_h1_d+(E_h2_d-E_h1_d)*log10(h1/h1_min)/log10(h1_max/h1_min);
               E=E_h_d;

            end

            E_fmax_Tmin=E;
            %interpolation of frequency using method annexe 5 paragraphe 6:
            E=E_fmin_Tmin+(E_fmax_Tmin-E_fmin_Tmin)*log10(freq/freq_min)/log10(freq_max/freq_min);
            E_f_Tmin=E;
                
                if (strcmpi(PathType,'land'))  % Maximum Field Strength Limitation
                    if E>106.9-20*log10(dist)
                         E=106.9-20*log10(dist);
                    end 
                 else 
                    if E>106.9-20*log10(dist)+2.38*(1-exp(-dist/8.94))*log10(50/T_perc)
                         E=106.9-20*log10(dist)+2.38*(1-exp(-dist/8.94))*log10(50/T_perc);
                    end
                 end 
             
        end
    end

    if T_perc~=T_perc_min
       %% search of the correspondant matrix  for T_perc~=T_perc_min -> cond =3
       M=CorrespondentMatrix(freq_min , freq_max, T_perc_min,T_perc_max, PathType, 3);

             %% Retreiving field strength
              % finding the index of dist_min and h1_min
                i=dist_tab==dist_min;
                j=h1_tab==h1_min;

             % finding field strength E_inf
                E_inf=M(i,j);
                E=E_inf;
             %check for need of interpolation for distance
              if dist~= dist_min && h1==h1_min
                i=dist_tab==dist_max;
                E_sup=M(i,j);
                %application of interpolation method annexe 5 paragraphe 5
                E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
              end

            %check for need of interpolation for height
             if h1~=h1_min
                jj=h1_tab==h1_max;
                E_sup=M(i,jj);
                %application of interpolation method annexe 5 paragraphe 4.1
                E=E_inf+(E_sup-E_inf)*log10(h1/h1_min)/log10(h1_max/h1_min);

             end  
            % double interpolation method
            if dist~= dist_min && h1~=h1_min
               ii=dist_tab==dist_max;
               jj=h1_tab==h1_max;
               E_h1_d=M(i,j)+(M(ii,j)-M(i,j))*log10(dist/dist_min)/log10(dist_max/dist_min);
               E_h2_d=M(i,jj)+(M(ii,jj)-M(i,jj))*log10(dist/dist_min)/log10(dist_max/dist_min);
               E_h_d=E_h1_d+(E_h2_d-E_h1_d)*log10(h1/h1_min)/log10(h1_max/h1_min);
               E=E_h_d;

            end
                 E_f_Tmax=E;
                 E_fmin_Tmax=E;
                 %interpolation of time percentage method annex 5 paragraphe 7
                 E=E_f_Tmax*(Q_min-Q)/(Q_min-Q_max)+E_f_Tmin*(Q-Q_max)/(Q_min-Q_max);
 
        if freq~=freq_min
            %% search of the correspondant matrix 
            M=CorrespondentMatrix(freq_min , freq_max, T_perc_min,T_perc_max, PathType, 4);

            %% Retreiving field strength

            % finding the index of dist_min and h1_min
                i=dist_tab==dist_min;
                j=h1_tab==h1_min;

            % finding field strength E_inf
                E_inf=M(i,j);
                E=E_inf;
             %check for need of interpolation for distance
              if dist~= dist_min && h1==h1_min
                i=dist_tab==dist_max;
                E_sup=M(i,j);
                %application of interpolation method annexe 5 paragraphe 5
                E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
              end

            %check for need of interpolation for height
             if h1~=h1_min
                jj=h1_tab==h1_max;
                E_sup=M(i,jj);
                %application of interpolation method annexe 5 paragraphe 4.1
                E=E_inf+(E_sup-E_inf)*log10(h1/h1_min)/log10(h1_max/h1_min);

             end  
                % double interpolation method
               if dist~= dist_min && h1~=h1_min
                   ii=dist_tab==dist_max;
                   jj=h1_tab==h1_max;
                   E_h1_d=M(i,j)+(M(ii,j)-M(i,j))*log10(dist/dist_min)/log10(dist_max/dist_min);
                   E_h2_d=M(i,jj)+(M(ii,jj)-M(i,jj))*log10(dist/dist_min)/log10(dist_max/dist_min);
                   E_h_d=E_h1_d+(E_h2_d-E_h1_d)*log10(h1/h1_min)/log10(h1_max/h1_min);
                   E=E_h_d;
               end

                 E_fmax_Tmax=E;
                 E_f_Tmax=E_fmin_Tmax+(E_fmax_Tmax-E_fmin_Tmax)*log10(freq/freq_min)/log10(freq_max/freq_min);
                 %interpolation of time percentage method annex 5 paragraphe 7
                 E=E_f_Tmax*(Q_min-Q)/(Q_min-Q_max)+E_f_Tmin*(Q-Q_max)/(Q_min-Q_max);
                 
                 if (strcmpi(PathType,'land'))  % Maximum Field Strength Limitation
                    if E>106.9-20*log10(dist)
                         E=106.9-20*log10(dist);
                    end 
                 else 
                    if E>106.9-20*log10(dist)+2.38*(1-exp(-dist/8.94))*log10(50/T_perc)
                         E=106.9-20*log10(dist)+2.38*(1-exp(-dist/8.94))*log10(50/T_perc);
                    end
                 end 

        end
    end
    
end 

%% STEP 12 as ordered Annex 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% --
% Terrain clearance angle correction as described in Annex 5, Section 11
	%Theta_TCA is considered as the same variable Theta
	if  RecOnLand==1 %% Represents when the receiver antenna is on land for mixed path or there is only a single path and it is land
    TCA_correction=TCAcorrection(freq,theta);
	E=E+TCA_correction;
    end 
%% STEP 13 as ordered in Annex 6%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% --
% Correction based on tropospheric scattering described in Annex 5, Section 13
% Maximum between Ets and E should be taken. 
	 Ets=TSlimit(theta_eff, theta, h1,freq, T_perc, dist);
     if Ets>E % Take the maximum of the two
          E=Ets; %% was causing problems
     end   
%% Step 14  as ordered in Annex 6%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% --       
% Correction for receiving/mobile antenna height, Annex 5 Section 9   
R2_prime=max(1,(1000*dist*R2 -15*h1)/(1000*dist-15));
if h1< (6.5*dist + R2)       
    R2_prime=R2;
end 
   RAH_correction=RAHcorrection(freq, R2_prime,h1,h2,environment,PathType, AdjToSea ); % Annex, Section 9
   E=E+RAH_correction;
   
%% Step 15   - Clutter Transmission Correction
    if  R1~=0 % If there is a clutter around the transmitter
    CT_correction=CTcorrection(freq,ha,R1);
    E= E+CT_correction;
    end
%% Step 16  -  Slope Path Correction ( Antenna Height Diff) -- Should use old distance ?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d_slope=sqrt(dist.^2+(10.^(-6))*(ha-h2).^2); 
AHD_correction= 20*log10(dist/d_slope);	% Annex 5, Section 14 
E=E+AHD_correction;

end    %End of distance >=1km condition  

%% Step 17 
  if dist<=0.04    
      d_slope=sqrt(dist.^2+(10.^(-6))*(ha-h2).^2); 
    E=106.9-20*log10(d_slope); %d_slope is calculated at the top
    
 elseif  dist_old<1 && dist_old>0.04
    dist=dist_old ;
    d_slope=sqrt(dist.^2+(10.^(-6))*(ha-h2).^2); % Recalculating the slope for the old value of distance so as not to have similar 
    
    d_inf=sqrt((0.04).^2+(10.^(-6))*(ha-h2).^2); %d_inf = d_slope(0.04) where dist=0.04
    d_sup=sqrt((1).^2+(10.^(-6))*(ha-h2).^2);

    E_inf=106.9-20*log10(d_inf);
    E_sup=E; % E is for dist=1 in steps 1 to 14 (as wriitten in section 15)
    E=E_inf+(E_sup-E_inf)*log10(d_slope/d_inf)/log10(d_sup/d_inf);
  end



%% Step 18
%Location variability in land area-coverage prediction  Annex 5, Section 12
% if dist_old>1 &&  (strcmpi(PathType,'land')) % values below are from the table in section 12
% Q=[2.327 2.054 1.881 1.751 1.645 1.555 1.476 1.405 1.341 1.282 1.227 1.175 1.126 1.080 1.036 0.994 0.954 0.915 0.878 0.841 0.806 0.772 0.739 0.706 0.674 0.643 0.612 0.582 0.553 0.524 0.495 0.467 0.439 0.412 0.385 0.358 0.331 0.305 0.279 0.253 0.227 0.202 0.176 0.151 0.125 0.100 0.075 0.050 0.025 0.000 -0.025 -0.050 -0.075 -0.100 -0.125 -0.151 -0.176 -0.202 -0.227 -0.253 -0.279 -0.305 -0.331 -0.358 -0.385 -0.412 -0.439 -0.467 -0.495 -0.524 -0.553 -0.582 -0.612 -0.643 -0.674 -0.706 -0.739 -0.772 -0.806 -0.841 -0.878 -0.915 -0.954 -0.994 -1.036 -1.080 -1.126 -1.175 -1.227 -1.282 -1.341 -1.405 -1.476 -1.555 -1.645 -1.751 -1.881 -2.054 -2.327];     
% sigma=5.5;% As found in the old code, but should be updated accoring to a K value
% %for 50% Location variability Q(50)=zero;
% LV=50;% Location variability = 50% in our case
% E=E+Q(LV)*sigma; % By default 50percent
% end  

%% Step 19 Maximum Field Strength 
%[E,Em]=MFS(PathType, dist, T_perc)  %% 8.1.6 , 9 , 19

 if (strcmpi(PathType,'land')) 
    if E>106.9-20*log10(dist)
         E=106.9-20*log10(dist);
    end 
%     MFS=106.9-20*log10(dist);
 else 
    if E>106.9-20*log10(dist)+2.38*(1-exp(-dist/8.94))*log10(50/T_perc)
         E=106.9-20*log10(dist)+2.38*(1-exp(-dist/8.94))*log10(50/T_perc);
    end
%     MFS=106.9-20*log10(dist)+2.38*(1-exp(-dist/8.94))*log10(50/T_perc);
 end 

%% Calculate Losses at Step 20
%Annex 5, Section 17
L_b=139.3-E+20*log10(freq);
end% End of Function