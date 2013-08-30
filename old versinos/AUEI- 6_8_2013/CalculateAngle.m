function [ UE ] = CalculateAngle( UE, Base, Centers, DTT_UH_h_diff , UE_BS_h, DTT_xy)

%Find vector for the first 3 cells that share Base1
UEv(1:18,1)=UE(1:18,1) -Base(1,1);
UEv(1:18,2)=UE(1:18,2)-Base(1,2) ; 

% Reference vector from Center to Base for central cell 
Ref1(1:6,1)=Centers(1,1)-Base(1,1);
Ref1(1:6,2)=Centers(1,2)-Base(1,2);
    
% Reference for those in the second cell
Ref1(7:12,1)=Centers(2,1)-Base(1,1);
Ref1(7:12,2)=Centers(2,2)-Base(1,2);

%for those in the 3rd cell
Ref1(13:18,1)=Centers(3,1)-Base(1,1);
Ref1(13:18,2)=Centers(3,2)-Base(1,2);

%% For Cell 4 - Takes from Base 2
UEv(19:24,1)=UE(19:24,1)- Base(2,1);
UEv(19:24,2)=UE(19:24,2)- Base(2,2) ; 

Ref1(19:24,1)=Centers(4,1)-Base(2,1);
Ref1(19:24,2)=Centers(4,2)-Base(2,2);

%% For Cells 5 and 6 - From Base 3
UEv(25:36,1)=UE(25:36,1) -Base(3,1);
UEv(25:36,2)=UE(25:36,2) -Base(3,2) ; 

%Reference for cell 5
Ref1(25:30,1)=Centers(5,1)-Base(3,1); 
Ref1(25:30,2)=Centers(5,2)-Base(3,2);

%Reference for cell 6
Ref1(31:36,1)=Centers(6,1)-Base(3,1);
Ref1(31:36,2)=Centers(6,2)-Base(3,2);

%% For Cell 7 - From Base 4
UEv(37:42,1)=UE(37:42,1)- Base(4,1);
UEv(37:42,2)=UE(37:42,2)- Base(4,2); 

Ref1(37:42,1)=Centers(7,1)-Base(4,1);
Ref1(37:42,2)=Centers(7,2)-Base(4,2);

%% Horizontal angle between UEs and their base stations
%Calculation of Vector Magnitudes and dot products
normU(1:42)=( ( UEv(1:42,1)).^2 +(UEv(1:42,2).^2)).^(1/2); 
norm1(1:42)=( ( Ref1(1:42,1)).^2 +(Ref1(1:42,2).^2)).^(1/2);

%Dot product for each UE
dotp(1:42)=UEv(1:42,1).*Ref1(1:42,1)+UEv(1:42,2).*Ref1(1:42,2);

% Angle=acos(A.B/|A|.|B|),
UE(1:42,5)= acos(dotp(1:42)./(normU.*norm1)) *180/pi;

%% vertical angle between UE transmitter and BS receiver
UE(1:42,6) = atan(UE_BS_h./UE(1:42,3))*180/pi; 

%% Horizontal angle between DTT and each UE
% Orientation of  DTT is towards the base 
DTT_Ref(1:42,1)=DTT_xy(1)+5 -DTT_xy(1); 
DTT_Ref(1:42,2)=DTT_xy(2)   -DTT_xy(2);

DTTv(1:42,1)=UE(:,1)-DTT_xy(1);
DTTv(1:42,2)=UE(:,2)-DTT_xy(2); 

normU(1:42)=( ( DTTv(1:42,1)).^2 +(DTTv(1:42,2).^2)).^(1/2); 
norm1(1:42)=( ( DTT_Ref(1:42,1)).^2 +(DTT_Ref(1:42,2).^2)).^(1/2);
dotp(1:42)=DTTv(1:42,1).*DTT_Ref(1:42,1)+DTTv(1:42,2).*DTT_Ref(1:42,2);

UE(1:42,7)= acos(dotp(1:42)./(normU.*norm1)) *180/pi;

%% Vertical Angle between DTT and each UE     
dist_DTT_UE=((DTT_xy(1)-UE(:,1)).^2  +(DTT_xy(2)-UE(:,2)).^2).^(1/2);
UE(1:42,8)= atan((DTT_UH_h_diff)./dist_DTT_UE(1:42))*180/pi; 
  
end

