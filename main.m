tic 
R=1;
r=R/2; %length of hexagon's side
tmax=3600000; %(ms)
tmin=1; %(ms)

freq=600; T_perc=50; 
BS_h=10; UE_h=1.5; DTT_h=10; DTT_UH_h_diff=DTT_h-UE_h;

PL_UE=zeros(1,42);
%% Plots Centers,Borders and BaseStations
[Centers,Borders,Base]=Initiate(r);
%%
DTT_xy=Centers(1,1:2)+[r/3,r/3];  % allocating a center for the DTT pixel
% Reference and DTT_BS Vectors
Ref(1,1:2)=Centers(1,1:2)-Base(1,1:2); %Reference vector from BS to center
DTT_BS(1,1:2)=DTT_xy(1,1:2)-Base(1,1:2);
%Distance between DTT and Base Station
dist_DTT_BS=((DTT_BS(1,1)).^2  +(DTT_BS(1,2)).^2).^(1/2);% calculated once between DTT pixel center and BS
%Distance between Center and Base Station
dist_Center_BS=(Ref(1,1).^2+Ref(1,2).^2).^(1/2);
dotp=Ref(1,1).*DTT_BS(1,1)+Ref(1,2).*DTT_BS(1,2);
%Horizontal angle between DTT and BS
DTT_BS_HA= acos(dotp./(dist_DTT_BS.*dist_Center_BS)) *180/pi; 
%Vertical angle between DTT and BS
DTT_BS_VA= atan((DTT_h-BS_h)/dist_DTT_BS)*180/pi; 

%Distribution of Field Strength
[PL_DTT, E_median]=E_predict('land',freq,dist_DTT_BS,T_perc,BS_h,BS_h,BS_h,DTT_h,0,10,'suburban',0,0,0,1); 
DTT= E_median + 5.5*randn(10000,1); 
counter=zeros(10000,1);

PRco=21; %(dB)
N=-98.17;% (dBm)
% DTT_received= DTT-PL_DTT- GainfromANGLE
%ii=find(DTT<N)
%counter(ii)=tmax;
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

% P_UE_min=-43;% (dBm)
% P_UE_max=20;% (dBm)
% Rmin=P_UE_min-P_UE_max;
% gamma=1;
% % % % % % P(dbm)= P(dB) - 30
% PLxile=122; %%(dB) setting 2 , PL_UE for 1kw or w ?
% % Pt_UE(1:42)=P_UE_max.*min(1,max(Rmin,gamma*(PL_UE(1:42)-PLxile +30);
% % C(1:42)=10*(Pt_UE(1:42)+PL_UE(1:42));  (in dBs)% This C is for UE which would
% % affect the DTT ?
%  
%  I_other(1:42)=10*log10(sum(0.001*10.^(Pt_UE(1:42))*0.001*10.^(PL_UE(1:42))) /0.001); %(dBm)
% % I_inter ??
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