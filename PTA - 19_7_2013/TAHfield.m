function [ E,C_h1neg10, C_h1real ] = TAHfield(E10,h1,freq_max,C1020)
%Equations from Annex 5, Section 4.2,4.3
 
if freq_max==100
    Kv=1.35;
elseif freq_max==600
    Kv=3.31;
elseif freq_max==2000
    Kv=6.00; 
end

%C_h1neg10 and C_h1_0 are the same thing 

if(h1>=0 && h1<10)
    h1=-10;
theta_eff2=atan(-h1/9000)*180/pi;
v=Kv*theta_eff2; %Value of Kv is provided at the top 
Jv=(6.9+20*log10(sqrt(((v-0.1)^2)+1)+v-0.1));
C_h1neg10=6.03-Jv;

E_zero=E10+0.5*(C1020+C_h1neg10);
E= E_zero+0.1*h1*(E10-E_zero);

C_h1real=0; %will not be used outside
else   
    theta_eff2=atan(-h1/9000)*180/pi; % instead of 10 ,-h1
    v=Kv*theta_eff2; %Value of Kv is provided at the top 
    Jv=(6.9+20*log10(sqrt(((v-0.1)^2)+1)+v-0.1));
    C_h1_0=6.03-Jv;
    
    C_h1neg10=C_h1_0; % This is the correction needd outside 
    
    E_zero=E10+0.5*(C1020+C_h1_0); %E for h1=0 (Section 4.2)
     
    %Calculate the correction from 4.3
    theta_eff2=atan(-h1/9000)*180/pi;
    v=Kv*theta_eff2; %Value of Kv is provided at the top 
    Jv=(6.9+20*log10(sqrt(((v-0.1)^2)+1)+v-0.1));
    
    C_h1real=6.03-Jv; % for the real value of h1
     
    E=E_zero+C_h1real;
end 

end