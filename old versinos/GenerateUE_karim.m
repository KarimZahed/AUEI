function [ UE ] = GenerateUE(r,Centers,Base)

UE=zeros(42,5); % 3rd would hold distance,4th would hold angle with station, 5th column would hold E value
 
for z=1:7 % for each of the 7 hexagons

x= -r+Centers(z,1)+(2*r).*rand(25,1);
y= -r+Centers(z,2)+2*r*sqrt(3)/2.*rand(25,1);

%Find indices of the points that fall outside the 6 sides
i1=find(y>r*sqrt(3)/2+Centers(z,2));
i2=find(y<-r*sqrt(3)/2+Centers(z,2));
i3=find(y>-sqrt(3)*(x-Centers(z,1))+sqrt(3)*r +Centers(z,2));
i4=find(y<sqrt(3)*(x-Centers(z,1)) -sqrt(3)*r +Centers(z,2));
i5=find(y<-sqrt(3)*(x-Centers(z,1))-sqrt(3)*r +Centers(z,2));
i6=find(y>sqrt(3)*(x-Centers(z,1)) +sqrt(3)*r +Centers(z,2));

 i=[i1;i2;i3;i4;i5;i6 ];
 x(i)=[];%Neglect the points outside the borders
 y(i)=[]; 
 
UE((6*(z-1)+1:6*(z-1)+6),1:2)=[x(1:6),y(1:6)]; %Take the first 6 points
end   
  
% Distance between UEs and respective Base Station
UE(1:18,3) =( ( UE(1:18,1)-Base(1,1) ).^2  +(UE(1:18,2)-Base(1,2) ).^2).^(1/2); % Set 1,2,3 follow Base1
UE(19:24,3)=( ( UE(19:24,1)-Base(2,1) ).^2 +(UE(19:24,2)-Base(2,2)).^2).^(1/2); % Set 4 follow Base 2
UE(25:36,3)=( ( UE(25:36,1)-Base(3,1) ).^2 +(UE(25:36,2)-Base(3,2)).^2).^(1/2); % Set 5,6 follow Base 3
UE(37:42,3)=( ( UE(37:42,1)-Base(4,1) ).^2 +(UE(37:42,2)-Base(4,2)).^2).^(1/2); % Set 7 follow Base 4

end