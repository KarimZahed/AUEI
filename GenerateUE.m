function [ UE ] = GenerateUE(r,Centers,Base, UE_h,UE_Hexagon, Hexagons)

UE=zeros(UE_Hexagon*Hexagons,12); % 4,5,6.... distance to each BS 


for z=1:Hexagons % for each of the hexagons
 
 RNu=randi(UE_Hexagon-1,1,1)-1;% Generate a number between the number of UEs and 0
 RNd=randi(UE_Hexagon-3,1,1)-1; 
 if(RNd+RNu > UE_Hexagon) %if RN < number of UEs in a hexagon
 RNd=UE_Hexagon-RNu;
 end
 RNf=UE_Hexagon-RNu-RNd;
 
 Xu=zeros(RNu,1);Yu=zeros(RNu,1); 
 Xd=zeros(RNd,1);Yd=zeros(RNd,1);
 Xf=zeros(RNf,1);Yf=zeros(RNf,1);
 
for u=1:RNu
alfa1= rand(1,1);
alfa3= rand(1,1);
Xu(u)= Centers(z,1) +alfa1*r/2 - alfa3*r;
Yu(u)= Centers(z,2) + alfa1*sqrt(3)*r/2;
end 

for d=1:RNd
alfa2= rand(1,1);
alfa3= rand(1,1);
Xd(d)=Centers(z,1) + alfa2*r/2 -alfa3*r;
Yd(d)=Centers(z,2) - alfa2*sqrt(3)*r/2;
end

for f=1:RNf
alfa1= rand(1,1);
alfa2= rand(1,1);
Xf(f)=Centers(z,1) + (alfa1+alfa2)*r/2;
Yf(f)=Centers(z,2) + sqrt(3)*(alfa1-alfa2)*r/2;
end 
 
UE(( (UE_Hexagon*(z-1)+1) : ((UE_Hexagon)*(z-1)+UE_Hexagon) ),1:2)=[Xu,Yu;Xd,Yd;Xf,Yf]; %Take these points
end   

UE(:,3)=UE_h;

% Distance between UEs and respective Base Station
UE(:,4)=( ( UE(:,1)-Base(1,1) ).^2 +(UE(:,2)-Base(1,2)).^2 ).^(1/2); % distance to Base1
UE(:,5)=( ( UE(:,1)-Base(2,1) ).^2 +(UE(:,2)-Base(2,2)).^2 ).^(1/2); %  Base 2
UE(:,6)=( ( UE(:,1)-Base(3,1) ).^2 +(UE(:,2)-Base(3,2)).^2 ).^(1/2); %  Base 3
UE(:,7)=( ( UE(:,1)-Base(4,1) ).^2 +(UE(:,2)-Base(4,2)).^2 ).^(1/2); %  Base 4

UE(:,8)=( ( UE(:,1)-Base(5,1) ).^2 +(UE(:,2)-Base(5,2)).^2 ).^(1/2); %  Base 5
UE(:,9)=( ( UE(:,1)-Base(6,1) ).^2 +(UE(:,2)-Base(6,2)).^2 ).^(1/2); %  Base 6
UE(:,10)=( ( UE(:,1)-Base(7,1) ).^2 +(UE(:,2)-Base(7,2)).^2 ).^(1/2); %  Base 7
UE(:,11)=( ( UE(:,1)-Base(8,1) ).^2 +(UE(:,2)-Base(8,2)).^2 ).^(1/2); %  Base 8
UE(:,12)=( ( UE(:,1)-Base(9,1) ).^2 +(UE(:,2)-Base(9,2)).^2 ).^(1/2); %  Base 9

end