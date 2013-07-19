function [ UE ] = GeneratePoints(r,Center)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 
std=r/3;

UE=zeros(42,4); % 3rd would hold distance, 4th column would hold E value
RAND=std.*randn(42,2);

% X coordinates
UE(1:6,1)=Center(1)+RAND(1:6,1); % Middle Hexagon (1)
UE(7:12,1)=Center(1)+RAND(7:12,1); %(2)
UE(13:18,1)=Center(1)+(3*r/2)+RAND(13:18,1); %(3)
UE(19:24,1)=Center(1)+(3*r/2)+RAND(19:24,1); %(4)
UE(25:30,1)=Center(1)+RAND(25:30,1);%(5)
UE(31:36,1)=Center(1)+(-3*r/2)+RAND(31:36,1);%(6)
UE(37:42,1)=Center(1)+(-3*r/2)+RAND(37:42,1);%(7)

% Y coordinates
UE(1:6,2)=Center(2)+RAND(1:6,2); % Middle Hexagon (1)
UE(7:12,2)=Center(2)+2*sqrt(3)*r+RAND(7:12,2); %(2)
UE(13:18,2)=Center(2)+sqrt(3)*r+RAND(13:18,2); %(3)
UE(19:24,2)=Center(2)+-sqrt(3)*r+RAND(19:24,2); %(4)
UE(25:30,2)=Center(2)+-2*sqrt(3)*r+RAND(25:30,2);  %(5)
UE(31:36,2)=Center(2)+-sqrt(3)*r+RAND(31:36,2);%(6)
UE(37:42,2)=Center(2)+sqrt(3)*r+RAND(37:42,2); %(7)

end

