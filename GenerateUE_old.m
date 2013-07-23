function [ UE ] = GenerateUE(r,Centers,Base)
%

std=r*sqrt(3)/(2*3);

UE=zeros(42,5); % 3rd would hold distance,4th would hold angle with station, 5th column would hold E value
RAND=std.*randn(42,2);

% % X coordinates
% UE(1:6,1)=Centers(1,1)+RAND(1:6,1); % Middle Hexagon (1)
% UE(7:12,1)=Centers(1,1)+RAND(7:12,1); %(2)
% UE(13:18,1)=Centers(1,1)+(3*r/2)+RAND(13:18,1); %(3)
% UE(19:24,1)=Centers(1,1)+(3*r/2)+RAND(19:24,1); %(4)
% UE(25:30,1)=Centers(1,1)+RAND(25:30,1);%(5)
% UE(31:36,1)=Centers(1,1)+(-3*r/2)+RAND(31:36,1);%(6)
% UE(37:42,1)=Centers(1,1)+(-3*r/2)+RAND(37:42,1);%(7)
% 
% % Y coordinates
% UE(1:6,2)=Centers(1,2)+RAND(1:6,2); % Middle Hexagon (1)
% UE(7:12,2)=Centers(1,2)+2*sqrt(3)*r/2+RAND(7:12,2); %(2)
% UE(13:18,2)=Centers(1,2)+sqrt(3)*r/2+RAND(13:18,2); %(3)
% UE(19:24,2)=Centers(1,2)+-sqrt(3)*r/2+RAND(19:24,2); %(4)
% UE(25:30,2)=Centers(1,2)+-2*sqrt(3)*r/2+RAND(25:30,2);  %(5)
% UE(31:36,2)=Centers(1,2)+-sqrt(3)*r/2+RAND(31:36,2);%(6)
% UE(37:42,2)=Centers(1,2)+sqrt(3)*r/2+RAND(37:42,2); %(7)


% Distance between UEs and respective Base Station
UE(1:18,3)=( ( UE(1:18,1)-Base(1,1) ).^2 +(UE(1:18,2)-Base(1,2) ).^2).^(1/2); % Set 1,2,3 follow Base1
UE(19:24,3)=( ( UE(19:24,1)-Base(2,1) ).^2 +(UE(19:24,2)-Base(2,2) ).^2).^(1/2); % Set 4 follow Base 2
UE(25:36,3)=( ( UE(25:36,1)-Base(3,1) ).^2 +(UE(25:36,2)-Base(3,2) ).^2).^(1/2); % Set 5,6 follow Base 3
UE(37:42,3)=( ( UE(37:42,1)-Base(4,1) ).^2 +(UE(37:42,2)-Base(4,2) ).^2).^(1/2); % Set 5,6 follow Base 3




end

