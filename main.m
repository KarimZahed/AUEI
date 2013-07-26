tic 

freq=600;
T_perc=50;
R_h=10;
T_h=1.5; %The UE are transmitting
height_diff=R_h-T_h;
R=1;
r=R/2; %length of hexagon's side
%%
[Centers,Borders,Base]=Initiate(r);
%% DTT=zeros(10000,0);
DTT_xy=Centers(1,1:2)+[r/3,r/3];  % allocating a center for the DTT pixel

%For distribution of Field Strength
% dist_DTT=((DTT_xy(1)-Base(1,1)).^2  +(DTT_xy(2)-Base(1,2)).^2).^(1/2);% calculated once between DTT pixel center and BS
% [PL_DTT, E_median]=E_predict('land',freq,dist_DTT,T_perc,h1,h1,h1,h2,0,10,'suburban',0,0,0,1); 
% DTT= E_median + 5.5*randn(1000,1);

%% Generation of UE will be recurring
% Generate the UE location, and calculates Distance to respective Base
UE= GenerateUE(r,Centers,Base,DTT_xy); % List of UEs 

UE= CalculateAngle( UE, Base, Centers, height_diff, DTT_xy ); % Angle between UE and Base Station
 
PL_UE=E_predict('land',freq,UE(:,3),T_perc,T_h,T_h,T_h,R_h,0,10,'suburban',0,0,0,1); % Path loss from each UE 
% I modified E_predict to account for distance as vector inputs 
%%
hold off
plot(UE(:,1),UE(:,2),'bo') % Plots the UE
%%
hold on % Plots centers and base stations
plot(Centers(:,1),Centers(:,2),'rx', Base(:,1),Base(:,2),'k+')

hold on % Draws the Borders
plot(Borders(:,1,1),Borders(:,2,1),'r',Borders(:,1,2),Borders(:,2,2),'r',Borders(:,1,3),Borders(:,2,3),'r',Borders(:,1,4),Borders(:,2,4),'r',Borders(:,1,5),Borders(:,2,5),'r',Borders(:,1,6),Borders(:,2,6),'r',Borders(:,1,7),Borders(:,2,7),'r')

% axis([-3*(r-0.5) ,3*(r-0.5) ,-3*(r-0.5) ,3*(r-0.5)])
legend('UE','Centers','Base Stations','Borders')

toc