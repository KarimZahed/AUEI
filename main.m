tic 

Center= [0, 0];% Center of the Central Cell

r=5; %length of hexagon's side

%Base= GenerateBase(Center, r);
% Calculation of Base Location
Base(1,1)= Center(1)+r/2;  % Base1 Location
Base(1,2)= Center(2)+sqrt(3)*r;

Base(2,1)=Center(1)+2*r;
Base(2,2)=Center(2)-2*sqrt(3)*r;  % Base2 Location

Base(3,1)=Center(1)-r;
Base(3,2)=Center(2)-2*sqrt(3)*r;  % Base3 Location

Base(4,1)=Center(1)-5*r/2;
Base(4,2)=Center(2)+sqrt(3)*r;  % Base4 Location


% Generate the UE location, and calculates Distance to respective Base
UE= GenerateUE(r,Center,Base); % List of UEs 


% hold off
% plot(UE(:,1),UE(:,2),'o')
% hold on 
% plot(Center(1),Center(2),'rx', Base(1,1),Base(1,2),'k+',Base(2,1),Base(2,2),'k+',Base(3,1),Base(3,2),'k+',Base(4,1),Base(4,2),'k+')
% 
% axis([-15 15 -25 25])


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

