function [ E ] = InterpolateD(E,M,i,C_h1_0,C_h1real,dist,dist_min,dist_max,h1 ,PathType,Fs)
%INTERPOLATED Summary of this function goes here
%   Detailed explanation goes here
E_inf=E;
E10sup=M(i,1);
E20sup=M(i,2);
C1020sup=E10sup-E20sup;%correction  

C_h1neg10=C_h1_0;

if (strcmpi(PathType,'land'))
if h1<0
                    
                    E_zero=E10sup+0.5*(C1020sup+C_h1_0);
                    % Correction C_h1real
                    E_sup=E_zero+C_h1real;
                    %application of interpolation method annexe 5 paragraphe 5
                    E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
                    
elseif  h1<10 && h1>=0
                    
					E_zero=E10sup+0.5*(C1020sup+C_h1neg10);
					% Correction C_h1real
					E_sup=E_zero+0.1*h1*(E10sup-E_zero);
					%application of interpolation method annexe 5 paragraphe 5
					E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
        
end 

elseif  (strcmpi(PathType,'sea'))
                
                Eprime=M(i,1)+(M(i,2)-M(i,1))*log10(h1/10)/log10(20/10);
             
                E_zero=E10sup+0.5*(C1020sup+C_h1neg10);
                Eseconde=E_zero+0.1*h1*(E10sup-E_zero);

                E_sup=Eprime*(1-Fs)+Eseconde*Fs;
                %application of interpolation method annexe 5 Section 5
                E=E_inf+(E_sup -E_inf)*log10(dist/dist_min)/log10(dist_max/dist_min);
    
    
end 

end

