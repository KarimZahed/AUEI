tic 

r=5; %length of hexagon's side

% Centers of the Cells
Centers= [0,0 ; 0,2*sqrt(3)*r  ; 3*r/2,r*sqrt(3) ; 3*r/2,-sqrt(3)*r ; 0,-2*sqrt(3)*r ; -3*r/2,-sqrt(3)*r; -3*r/2, r*sqrt(3)];

%Base= GenerateBase(Centers, r);
% Calculation of Base Location
Base(1,1)= Centers(1,1)+r/2;  % Base1 Location
Base(1,2)= Centers(1,2)+sqrt(3)*r;

Base(2,1)=Centers(1,1)+2*r;
Base(2,2)=Centers(1,2)-2*sqrt(3)*r;  % Base2 Location

Base(3,1)=Centers(1,1)-r;
Base(3,2)=Centers(1,2)-2*sqrt(3)*r;  % Base3 Location

Base(4,1)=Centers(1,1)-5*r/2;
Base(4,2)=Centers(1,2)+sqrt(3)*r;  % Base4 Location


% Generate the UE location, and calculates Distance to respective Base
UE= GenerateUE(r,Centers,Base); % List of UEs 

% DTT=zeros(10000,1);


Borders=GenerateBorders(Centers,r);


hold off % Plots UE randomly distributed pointspoints
plot(UE(:,1),UE(:,2),'o')

hold on  % Plot Centers and Base STations
plot(Centers(:,1),Centers(:,2),'rx', Base(:,1),Base(:,2),'k+')

hold on % Plot Borders
plot(Borders(:,1,1),Borders(:,2,1),'r',Borders(:,1,2),Borders(:,2,2),'r',Borders(:,1,3),Borders(:,2,3),'r',Borders(:,1,4),Borders(:,2,4),'r',Borders(:,1,5),Borders(:,2,5),'r',Borders(:,1,6),Borders(:,2,6),'r',Borders(:,1,7),Borders(:,2,7),'r')


axis([-15 15 -25 25])
legend('UE','Centers','Base Stations')

%For distribution of Field Strength
% E_sigma=5.5; 
% E_med=125;
% X=E_med+(-4:0.1:4);
% Gauss=1/(sqrt(2*pi)*E_sigma)*exp(-0.5*(X-E_med).^2/(E_sigma^2));% Creates the Gaussian function



% Make sure of the variables
% Calculate E for the 42 UEs in consideration
% 
% E=E_predict('land',600,z,50,600,600,600,10,0,10,'suburban',0,0,0,1); %
% distance here is according to distance between pixel Centers (DTT) and BS
% E is calculated for each 

toc

