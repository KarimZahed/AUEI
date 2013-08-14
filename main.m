tic 

%% Given (Input)
R=1; r=R/2; %length of hexagon's side
tmax=36000; %(ms)

freq=600; T_perc=50; 
BS_h=10; UE_h=1.5; DTT_h=10; 

E_median=125;
G=12+2.15-5; %(dB)

DTT_x=0.3; DTT_y=0.3; % DTT coordinates
counter=zeros(10000,1);

%PL_DTT is in dB according to ITU-R.P.1546-4
PRco=21;  %(dB)

N=-98.17+30; %(dB=dBm+30)

%% Plots Centers,Borders and BaseStations
[Centers,Borders,Base]=Initiate(r);

%% Sets up the DTT pixel location 
DTT_xy=[DTT_x,DTT_y];  % allocating a center for the DTT pixel
DTT_Station=[DTT_x+5,DTT_y];

% Distribution of Field Strength
DTT = E_median - 77.2 + G - 20*log10(freq); %%%% Received DTT  (dB)
C= DTT + 5.5*randn(10000,1);  % 5.5 dB is the sigma, E or C ?

PL_UE_matrix= zeros(42,4);
PL_UE= zeros(42,1); % 1 is the index of the basestation, 2 is the value of the path loss
UE_BS_index= zeros(42,1);

% ii=find(DTT_received<N); % counter(ii)=tmax;

tow=3; %degrees
%% Generate the UE location, and calculates Distance to respective Base
for t=1:30 % this would be from t=1:1:3600000

    UE= GenerateUE(r,Centers,Base,UE_h); % Generates the UEs and calculates distance to each BS
    %%
    %account for distance in z also ??
%   UE_h, BS_h are in amtrix
    PL_UE_matrix(:,1) = Propagation( freq, UE(:,4) , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS1
    PL_UE_matrix(:,2) = Propagation( freq, UE(:,5) , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS2
    PL_UE_matrix(:,3) = Propagation( freq, UE(:,6) , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS3
    PL_UE_matrix(:,4) = Propagation( freq, UE(:,7) , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS4
    
    for z=1:42
    [PL_UE(z),UE_BS_index] = min(PL_UE_matrix(z,:)); %finds the minimum power loss and the respective BS index
    end
     
    %% ADD TILT 
    UE=Tilt(UE, Base, BS_h , UE_BS_index,tow); % Transforms UEs to the tilted coordinate system
    
    %USE NEW UE_h    
    [Angles, normDTT]= CalculateAngles( UE, Base,UE_BS_index, Centers, DTT_h, UE_h ,BS_h, DTT_xy ); % Angles between UE,  BSand DTT
 
    PL_UE= PL_UE + AngleGain(Angles(:,1),Angles(:,2)); %Discrimination increases losses
    % AngleGain is small  Should I add a G0 ?
    
%% UE transmit power 

 P_UE_min= -43 +30;% (dB=dBm+30)
 P_UE_max=  20 +30;% (dB=dBm+30)
 Rmin=P_UE_min-P_UE_max;
 gamma=1;
 PLxile=122; %%(dB) setting 2
 
 Pt_UE(1:42)=P_UE_max.*min(1,max(Rmin,gamma*(PL_UE(1:42)-PLxile +30))); % path loss in dBk to dB 
 
 %% Interference
 PL_UE_DTT(1:42) = Propagation( freq, (normDTT(1:42))' , DTT_h, UE_h, 'Suburbuan',1 );
 I_UE= Pt_UE' - PL_UE_DTT' - AngleGain(Angles(:,3),Angles(:,4)); % Correct?? 
 
 I_t=10*log10(sum(10.^(I_UE(:)/10))); %(dB) Addition of Power units
% 
 PRadj=-20; % dB
 
 interfered=find((C-10*log10(10.^(I_t+PRadj) + 10.^(N+PRco)))>0);
%  counter(interefered)=counter(interfered) +1;

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
% axis([(-3*r+0.5), 3*r+0.5 ,-3*r, 3*r  ])
% legend('UE','Centers','Base Stations','Borders')

toc