function [ UE ] = GenerateUE(r,Centers,Base, UE_h)

UE=zeros(42,7); % 4,5,6,7 distance to each BS 

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

UE(:,3)=UE_h;

% Distance between UEs and respective Base Station
UE(1:42,4)=( ( UE(1:42,1)-Base(1,1) ).^2 +(UE(1:42,2)-Base(1,2)).^2 ).^(1/2); % distance to Base1
UE(1:42,5)=( ( UE(1:42,1)-Base(2,1) ).^2 +(UE(1:42,2)-Base(2,2)).^2 ).^(1/2); %  Base 2
UE(1:42,6)=( ( UE(1:42,1)-Base(3,1) ).^2 +(UE(1:42,2)-Base(3,2)).^2 ).^(1/2); %  Base 3
UE(1:42,7)=( ( UE(1:42,1)-Base(4,1) ).^2 +(UE(1:42,2)-Base(4,2)).^2 ).^(1/2); %  Base 4

end