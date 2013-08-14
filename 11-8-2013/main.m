tic 

R=1; r=R/2; %length of hexagon's side
tmin=1; tmax=36000; %(ms)

freq=600; T_perc=50; 
BS_h=10; UE_h=1.5; DTT_h=10; DTT_UH_h_diff=DTT_h-UE_h; %(m)
UE_BS_h=BS_h-UE_h;
E_median=125;
G=12+2.15-5; 

DTT_x=0.3; DTT_y=0.3; % DTT coordinates

%% Plots Centers,Borders and BaseStations
[Centers,Borders,Base]=Initiate(r);
%% Sets up the DTT pixel location and calculates distance and Horizontal & Vertical angle
[ DTT_xy, dist_DTT_BS ] = DTTSetup(Centers, Base,DTT_x,DTT_y);

% Distribution of Field Strength
% [PL_DTT, E_median]=E_predict('land',freq,dist_DTT_BS,T_perc,BS_h,BS_h,BS_h,DTT_h,0,10,'suburban',0,0,0,1); 
DTT= E_median + 5.5*randn(10000,1); 
C = DTT - 77.2 + G -20*log10(freq); %%%% Received DTT  (dB)

counter=zeros(10000,1);

%PL_DTT is in dB according to ITU-R.P.1546-4
PRco=21;  %(dB)
N=-98.17+30; %(dB=dBm+30)

% ii=find(DTT_received<N);
% counter(ii)=tmax;

%% Generate the UE location, and calculates Distance to respective Base
for t=1:10 % this would be from t=1:1:3600000

    UE= GenerateUE(r,Centers,Base,DTT_xy); % Generates the UEs 

    UE= CalculateAngle( UE, Base, Centers, DTT_UH_h_diff,UE_BS_h, DTT_xy ); % Angles between UE and DTT
 
    PL_UE = Propagation( freq, UE(:,3) , DTT_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS
    %need to check wich Base station to take from 
    
    PL_UE= PL_UE + AngleGain(UE(:,5),UE(:,6)); %Discrimination increases losses
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INST PL_UE for 1Kw ?
%% UE transmit power 

 P_UE_min= -43 +30;% (dB=dBm+30)
 P_UE_max=  20 +30;% (dB=dBm+30)
 Rmin=P_UE_min-P_UE_max;
 gamma=1;
 PLxile=122; %%(dB) setting 2

 Pt_UE(1:42)=P_UE_max.*min(1,max(Rmin,gamma*(PL_UE(1:42)-PLxile +30))); % path loss in dBk to dB 

 %% Interference
 I_UE= Pt_UE; %-PL_UE;
 
 I_t(1:42)=10*log10(sum(10.^(I_UE(:)/10))); %(dB) Addition of Power units
% 
% %=C-I_other-Nt;
% interfered=find(DTT<I)
% counter(interefered)=counter(interefered) +1;
%%

end
%%
hold off
plot(UE(:,1),UE(:,2),'bo') % Plots the UE
%% 
hold on % Plots centers and base stations
plot(Centers(:,1),Centers(:,2),'rx', Base(:,1),Base(:,2),'k+')

hold on % Draws the Borders
plot(Borders(:,1,1),Borders(:,2,1),'r',Borders(:,1,2),Borders(:,2,2),'r',Borders(:,1,3),Borders(:,2,3),'r',Borders(:,1,4),Borders(:,2,4),'r',Borders(:,1,5),Borders(:,2,5),'r',Borders(:,1,6),Borders(:,2,6),'r',Borders(:,1,7),Borders(:,2,7),'r')

% rp=3*(r)
 axis([(-3*r+0.5), 3*r+0.5 ,-3*r, 3*r  ])
legend('UE','Centers','Base Stations','Borders')

toc