function [ DTT_xy, dist_DTT_BS ] = DTTSetup(Centers, Base,x,y)

DTT_xy=[x,y];  % allocating a center for the DTT pixel

DTT_Station=[x+5,y];

% Reference and DTT_BS Vectors
Ref(1,1:2)=Centers(1,1:2)-Base(1,1:2); %Reference vector from BS to center
DTT_BS(1,1:2)=DTT_xy(1,1:2)-Base(1,1:2);

%Distance between DTT and Base Station
dist_DTT_BS=((DTT_BS(1,1)).^2  +(DTT_BS(1,2)).^2).^(1/2);% calculated once between DTT pixel center and BS

%Distance between Center and Base Station
dist_Center_BS=(Ref(1,1).^2+Ref(1,2).^2).^(1/2);
dotp=Ref(1,1).*DTT_BS(1,1)+Ref(1,2).*DTT_BS(1,2);

%Horizontal angle between DTT and BS
% DTT_BS_HA= acos(dotp./(dist_DTT_BS.*dist_Center_BS)) *180/pi; 

%Vertical angle between DTT and BS
% DTT_BS_VA= atan((DTT_h-BS_h)/dist_DTT_BS)*180/pi; 


end

