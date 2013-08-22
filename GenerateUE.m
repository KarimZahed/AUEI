function [ UE ] = GenerateUE(r,Centers,Base, UE_h,UE_Hexagon, Hexagons)

UE=zeros(UE_Hexagon*Hexagons,3+size(Base,1)); % 4,5,6.... distance to each BS 

for z=1:Hexagons % for each of the hexagons
  
 
for zz=1:UE_Hexagon

    alfa1= rand(1,1);
    alfa2= rand(1,1);
    alfa3= rand(1,1);

    if (mod(zz,3)==0) 

    X= Centers(z,1) +alfa1*r/2 - alfa3*r;
    Y= Centers(z,2) + alfa1*sqrt(3)*r/2;

    elseif (mod(zz,3)==1) 

    X=Centers(z,1) + alfa2*r/2 -alfa3*r;
    Y=Centers(z,2) - alfa2*sqrt(3)*r/2;

    elseif (mod(zz,3)==2) 
    X=Centers(z,1) + (alfa1+alfa2)*r/2;
    Y=Centers(z,2) + sqrt(3)*(alfa1-alfa2)*r/2;

    end 
 
UE( ((z-1)*(UE_Hexagon)+zz) ,1:2)=[X,Y]; %Take these points

end   

UE(:,3)=UE_h; % Z coordinate


for m=1:size(Base,1) % Distance between UEs and respective Base Station
UE(:,m+3)=( ( UE(:,1)-Base(m,1) ).^2 +(UE(:,2)-Base(m,2)).^2 ).^(1/2); % distance to each Base Station
end 

end
