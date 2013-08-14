function [ UE ] = GenerateUE(r,Centers,Base,DTT_xy)

UE=zeros(42,8); % 3,4 distance to DTT and BS. 5,6 angles to BS, 7,8  DTT angle wrt to UE 

for z=1:7 % for each of the 7 hexagons

alfa1= rand(2,1);
alfa2= rand(2,1);
alfa3= rand(2,1);

Xu=Centers(z,1) +alfa1*r/2 - alfa3*r;
Yu=Centers(z,2) + alfa1*sqrt(3)*r/2;

Xd=Centers(z,1) + alfa2*r/2 -alfa3*r;
Yd=Centers(z,2) - alfa2*sqrt(3)*r/2;

Xf=Centers(z,1) + (alfa1+alfa2)*r/2;
Yf=Centers(z,2) + sqrt(3)*(alfa1-alfa2)*r/2;

 
UE((6*(z-1)+1:6*(z-1)+6),1:2)=[Xu,Yu;Xd,Yd;Xf,Yf]; %Take the first 6 points
end   
  
% Distance between UEs and respective Base Station
UE(1:18,3) =( ( UE(1:18,1)-Base(1,1) ).^2  +(UE(1:18,2)-Base(1,2) ).^2).^(1/2); % Set 1,2,3 follow Base1
UE(19:24,3)=( ( UE(19:24,1)-Base(2,1) ).^2 +(UE(19:24,2)-Base(2,2)).^2).^(1/2); % Set 4 follow Base 2
UE(25:36,3)=( ( UE(25:36,1)-Base(3,1) ).^2 +(UE(25:36,2)-Base(3,2)).^2).^(1/2); % Set 5,6 follow Base 3
UE(37:42,3)=( ( UE(37:42,1)-Base(4,1) ).^2 +(UE(37:42,2)-Base(4,2)).^2).^(1/2); % Set 7 follow Base 4

% Distance between UE and Dtts
UE(:,4)=( ( UE(:,1)-DTT_xy(1) ).^2  +(UE(:,2)-DTT_xy(2)).^2).^(1/2);
end