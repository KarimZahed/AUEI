tic 

R=1; r=R/2; %length of hexagon's side
tmin=1; tmax=3600000; %(ms)

freq=600; T_perc=50; 
BS_h=10; UE_h=1.5; DTT_h=10; DTT_UH_h_diff=DTT_h-UE_h; %(m)

E_median=125;
x=0.3; y=0.3;

PL_UE=zeros(1,42);
%% Plots Centers,Borders and BaseStations
[Centers,Borders,Base]=Initiate(r);
%% Sets up the DTT pixel location and calculates distance and Horizontal & Vertical angle
[ DTT_xy, dist_DTT_BS, DTT_BS_HA,DTT_BS_VA  ] = DTTSetup(Centers, Base,x,y,DTT_h,BS_h );

%Distribution of Field Strength
% [PL_DTT, E_median]=E_predict('land',freq,dist_DTT_BS,T_perc,BS_h,BS_h,BS_h,DTT_h,0,10,'suburban',0,0,0,1); 
DTT= E_median + 5.5*randn(10000,1); 
C = DTT - 77.2 + AngleGain(DTT_BS_HA,DTT_BS_VA) -20*log10(freq);


counter=zeros(10000,1);

%PL_DTT is in dB according to ITU-R.P.1546-4
PRco=21;  %(dB)
N=-98.17+30; %(dB=dBm+30)
% DTT_received= DTT + AngleGain(DTT_BS_HA,DTT_BS_VA); %Anglegain is negative
% ii=find(DTT_received<N);
% counter(ii)=tmax;

%% Generation of UE will be recurring
% Generate the UE location, and calculates Distance to respective Base
for k=1:10 % this would be from t=1:1:3600000

    UE= GenerateUE(r,Centers,Base,DTT_xy); % Generates the UEs 

    UE= CalculateAngle( UE, Base, Centers, DTT_UH_h_diff, DTT_xy ); % Angles between UE and DTT
 

    for l=1:42                                        %The UE are transmitting
        [PL_UE(l),E]=E_predict('land',freq,UE(l,3),T_perc,UE_h,UE_h,UE_h,BS_h,0,10,'suburban',0,0,0,1); % Path loss from each UE 

    end % E_predict is not made to accept vectors !


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INST PL_UE for 1Kw ?
% NEEDS confirmation !!!!
% %UE transmit power 

 P_UE_min= -43 +30;% (dB=dBm+30)
 P_UE_max=  20 +30;% (dB=dBm+30)
 Rmin=P_UE_min-P_UE_max;
 gamma=1;
 PLxile=122; %%(dB) setting 2

% Pt_UE(1:42)=P_UE_max.*min(1,max(Rmin,gamma*(PL_UE(1:42)-PLxile +30);
% % C(1:42)=10*(Pt_UE(1:42)+PL_UE(1:42));  (in dBs)% This C is for UE which would
% % affect the DTT ?
%  
% I_other(1:42)=10*log10(sum(10.^(Pt_UE(1:42))*10.^(PL_UE(1:42)))); %(dB)
% 
% %=C-I_other-Nt;
% interefered=find(DTT<I)
% counter(interefered)=counter(interefered) +1;
%%

end
%%
% hold off
% plot(UE(:,1),UE(:,2),'bo') % Plots the UE
% %%
% hold on % Plots centers and base stations
% plot(Centers(:,1),Centers(:,2),'rx', Base(:,1),Base(:,2),'k+')
% 
% hold on % Draws the Borders
% plot(Borders(:,1,1),Borders(:,2,1),'r',Borders(:,1,2),Borders(:,2,2),'r',Borders(:,1,3),Borders(:,2,3),'r',Borders(:,1,4),Borders(:,2,4),'r',Borders(:,1,5),Borders(:,2,5),'r',Borders(:,1,6),Borders(:,2,6),'r',Borders(:,1,7),Borders(:,2,7),'r')
% 
% % axis([-3*(r-0.5) ,3*(r-0.5) ,-3*(r-0.5) ,3*(r-0.5)])
% legend('UE','Centers','Base Stations','Borders')

toc