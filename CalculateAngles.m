function [ Angles, normDTT ] = CalculateAngles( UE, Base, UE_BS_index, Centers, DTT_h, UE_h, BS_h, DTT_xy)

Angles=zeros(42,4);

%UE vector between each UE and the Base station chosen according to min
%path loss

UEv(1:42,1)=UE(1:42,1) -Base(UE_BS_index(1:42),1);
UEv(1:42,2)=UE(1:42,2) -Base(UE_BS_index(1:42),2) ; 

% Reference vector from Center to Base for central cell 
Ref1(1:6,1)=Centers(1,1)-Base(1,1);
Ref1(1:6,2)=Centers(1,2)-Base(1,2);
    
% Reference for those in the second cell
Ref1(7:12,1)=Centers(2,1)-Base(1,1);
Ref1(7:12,2)=Centers(2,2)-Base(1,2);

%for those in the 3rd cell
Ref1(13:18,1)=Centers(3,1)-Base(1,1);
Ref1(13:18,2)=Centers(3,2)-Base(1,2);
 
Ref1(19:24,1)=Centers(4,1)-Base(2,1);
Ref1(19:24,2)=Centers(4,2)-Base(2,2);

%Reference for cell 5
Ref1(25:30,1)=Centers(5,1)-Base(3,1); 
Ref1(25:30,2)=Centers(5,2)-Base(3,2);

%Reference for cell 6
Ref1(31:36,1)=Centers(6,1)-Base(3,1);
Ref1(31:36,2)=Centers(6,2)-Base(3,2);

Ref1(37:42,1)=Centers(7,1)-Base(4,1);
Ref1(37:42,2)=Centers(7,2)-Base(4,2);

%% Horizontal angle between UEs and their base stations
%Calculation of Vector Magnitudes and dot products
normU(1:42)=( ( UEv(1:42,1)).^2 +(UEv(1:42,2).^2)  ).^(1/2); 
norm1(1:42)=( ( Ref1(1:42,1)).^2 +(Ref1(1:42,2).^2) ).^(1/2);

%Dot product for each UE
dotp(1:42)=UEv(1:42,1).*Ref1(1:42,1)+UEv(1:42,2).*Ref1(1:42,2);

% Horizontal angle between UE and BS
Angles(:,1)= acos(dotp(1:42)./(normU.*norm1)) *180/pi;

%% Vertical angle between UE transmitter and BS receiver
Angles(:,2) = atan(abs(UE_h-BS_h)./UE(1:42,3))*180/pi; 

%% Horizontal angle between DTT and each UE
% Orientation of  DTT is towards the base 
DTT_Ref(1:42,1)=DTT_xy(1)+5 -DTT_xy(1); 
DTT_Ref(1:42,2)=DTT_xy(2)   -DTT_xy(2);

DTTv(1:42,1)=UE(:,1)-DTT_xy(1);
DTTv(1:42,2)=UE(:,2)-DTT_xy(2); 

normDTT(1:42)=( ( DTTv(1:42,1)).^2 +(DTTv(1:42,2).^2)).^(1/2); 
norm1(1:42)=( ( DTT_Ref(1:42,1)).^2 +(DTT_Ref(1:42,2).^2)).^(1/2);
dotp(1:42)=DTTv(1:42,1).*DTT_Ref(1:42,1)+DTTv(1:42,2).*DTT_Ref(1:42,2);

%horizontal angle between DTT and UE
Angles(:,3)= acos(dotp(1:42)./(normDTT.*norm1)) *180/pi;

%% Vertical Angle between DTT and each UE     
dist_DTT_UE=((DTT_xy(1)-UE(:,1)).^2  +(DTT_xy(2)-UE(:,2)).^2).^(1/2);
Angles(:,4)= atan(abs(DTT_h - UE_h)./dist_DTT_UE(1:42))*180/pi; 
  
end

