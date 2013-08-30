function [ Gain, normDTT ] = DTTGain(UE,DTT_xyz,DTT_station  )
%Base on RECOMMENDATION  ITU-R  BT.419-3*

SIZE=size(UE,1);
% Orientation of  DTT is towards its own BASE assumed to be situated to its right
DTT_Ref(1:SIZE,1)=DTT_station(1) -DTT_xyz(1); 
DTT_Ref(1:SIZE,2)=DTT_station(2) -DTT_xyz(2);

DTTv(1:SIZE,1)=UE(:,1)-DTT_xyz(1);
DTTv(1:SIZE,2)=UE(:,2)-DTT_xyz(2); 

normDTT(1:SIZE)=( ( DTTv(1:SIZE,1)).^2 +(DTTv(1:SIZE,2).^2)).^(1/2); 
norm1(1:SIZE)=( ( DTT_Ref(1:SIZE,1)).^2 +(DTT_Ref(1:SIZE,2).^2)).^(1/2);
dotp(1:SIZE)=DTTv(1:SIZE,1).*DTT_Ref(1:SIZE,1)+DTTv(1:SIZE,2).*DTT_Ref(1:SIZE,2);

%horizontal angle between DTT and UE
Horizontal= acos(dotp(1:SIZE)./(normDTT.*norm1)) *180/pi;

%% Vertical Angle between DTT and each UE     
dist_DTT_UE=((DTT_xyz(1)-UE(:,1)).^2  +(DTT_xyz(2)-UE(:,2)).^2).^(1/2);
Vertical=atan(abs(DTT_xyz(3) - UE(:,3))./(dist_DTT_UE*1000))*180/pi;

%% Discrimination due to Angle between DTT and each UE
h1=find(Horizontal<=20);
h2=find(Horizontal>20 & Horizontal<=60 );
h3=find(Horizontal>60);

Gain_h=zeros(size(UE,1),1);
Gain_h(h1)=0;
Gain_h(h2)=-0.4*Horizontal(h2)+8;
Gain_h(h3)=-16;

v1=find(Vertical<=20);
v2=find(Vertical>20 & Vertical<=60 );
v3=find(Vertical>60);

Gain_V=zeros(size(UE,1),1);
Gain_V(v1)=0;
Gain_V(v2)=-0.4*Vertical(v2)+8;
Gain_V(v3)=-16;

Gain=min(Gain_V,Gain_h);

end

