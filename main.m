tic 

R=1;
r=R/2; %length of hexagon's side
%%
[Centers,Borders,Base]=Initiate(r);
%% DTT=zeros(10000,0);
% distance here is calculated once between DTT pixel center and BS, then E is calculated once
%gaussian distribution is then applied 
%For distribution of Field Strength
% E_sigma=5.5; 
% E_med=125;
% X=E_med+(-4:0.1:4);
% Gauss=1/(sqrt(2*pi)*E_sigma)*exp(-0.5*(X-E_med).^2/(E_sigma^2));% Creates
 % the Gaussian function for DTT distribution or just use randn

%% Generation of UE will be recurring
% Generate the UE location, and calculates Distance to respective Base
UE= GenerateUE(r,Centers,Base); % List of UEs 
% Make sure of the variables
% Calculate E for each of the 42 UEs in consideration
% E=E_predict('land',600,z,50,600,600,600,10,0,10,'suburban',0,0,0,1); 

% angle
 UE= CalculateAngle( UE, Base, Centers );
%%
hold off
plot(UE(:,1),UE(:,2),'bo') % Plots the UE
%%
hold on % Plots centers and base stations
plot(Centers(:,1),Centers(:,2),'rx', Base(:,1),Base(:,2),'k+')

hold on % Draws the Borders
plot(Borders(:,1,1),Borders(:,2,1),'r',Borders(:,1,2),Borders(:,2,2),'r',Borders(:,1,3),Borders(:,2,3),'r',Borders(:,1,4),Borders(:,2,4),'r',Borders(:,1,5),Borders(:,2,5),'r',Borders(:,1,6),Borders(:,2,6),'r',Borders(:,1,7),Borders(:,2,7),'r')

% axis([-3*(r-0.5) ,3*(r-0.5) ,-3*(r-0.5) ,3*(r-0.5)])
legend('UE','Centers','Base Stations','Borders')

toc