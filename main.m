tic 

Center= [0, 0];% Center of the Central Cell

r=5; %length of hexagon's side
UE= GeneratePoints(r,Center); % List of UEs 


Base1=[Center(1)+r/2,Center(2)+sqrt(3)*r];  % Base1 Location
% Base2=[Center(1)+r/2,Center(2)+sqrt(3)*r];  % Base1 Location
% Base3=[Center(1)+r/2,Center(2)+sqrt(3)*r];  % Base1 Location
% Base4=[Center(1)+r/2,Center(2)+sqrt(3)*r];  % Base1 Location


UE(1:18,3)=( ( UE(1:18,1)-Base1(1) ).^2 +(UE(1:18,2)-Base1(2) ).^2).^(1/2); % Set 1,2,3 follow Base1




hold off
plot(UE(:,1),UE(:,2),'o')
hold on 
plot(Center(1),Center(2),'rx', Base1(1),Base1(2),'k+')

axis([-20 20 -25 25])


%For distribution of Field Strength
% E_sigma=5.5; 
% E_med=125;
% X=E_med+(-4:0.1:4);
% Gauss=1/(sqrt(2*pi)*E_sigma)*exp(-0.5*(X-E_med).^2/(E_sigma^2));% Creates the Gaussian function



% Make sure of the variables
% Calculate E for the 42 UEs in consideration
% 
% E=E_predict('land',600,z,50,600,600,600,10,0,10,'suburban',0,0,0,1); %
% distance here is according to distance between pixel center (DTT) and BS
% E is calculated for each 

toc

