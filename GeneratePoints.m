function [ UE ] = GeneratePoints(r)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 
std=r/2;


RAND=std.*randn(42,2);

% X coordinates
UE(1:6,1)=4*r+RAND(1:6,1); % Middle Hexagon (1)
UE(7:12,1)=4*r+RAND(7:12,1); %(2)
UE(13:18,1)=(11*r/2)+RAND(13:18,1); %(3)
UE(19:24,1)=(11*r/2)+RAND(19:24,1); %(4)
UE(25:30,1)=4*r+RAND(25:30,1);%(5)
UE(31:36,1)=(5*r/2)+RAND(31:36,1);%(6)
UE(37:42,1)=(5*r/2)+RAND(37:42,1);%(7)

% Y coordinates
UE(1:6,2)=3*sqrt(3)*r+RAND(1:6,2); % Middle Hexagon (1)
UE(7:12,2)=5*sqrt(3)*r+RAND(7:12,2); %(2)
UE(13:18,2)=4*sqrt(3)*r+RAND(13:18,2); %(3)
UE(19:24,2)=2*sqrt(3)*r+RAND(19:24,2); %(4)
UE(25:30,2)=sqrt(3)*r+RAND(25:30,2);  %(5)
UE(31:36,2)=2*sqrt(3)*r+RAND(31:36,2);%(6)
UE(37:42,2)=4*sqrt(3)*r+RAND(37:42,2); %(7)

end

