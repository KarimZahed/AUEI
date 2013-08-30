function [ DTT_x, DTT_y ] = GenerateDTT( Center, r, index )
%GENERATEDTT Summary of this function goes here
%   Detailed explanation goes here



if (mod(index,3)==0)
    
alfa1= rand(1,1);
alfa3= rand(1,1);
DTT_x= Center(1) +alfa1*r/2 - alfa3*r;
DTT_y= Center(2) + alfa1*sqrt(3)*r/2;
    
elseif  (mod(index,3)==1)
 
alfa2= rand(1,1);
alfa3= rand(1,1);
DTT_x=Center(1) + alfa2*r/2 -alfa3*r;
DTT_y=Center(2) - alfa2*sqrt(3)*r/2;

elseif (mod(index,3)==2)
    
alfa1= rand(1,1);
alfa2= rand(1,1);
DTT_x=Center(1) + (alfa1+alfa2)*r/2;
DTT_y=Center(2) + sqrt(3)*(alfa1-alfa2)*r/2;
    
end

