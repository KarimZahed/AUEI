tic 

UE=zeros(42,3); % Preallocating 42 UEs ( 6 in the cell and others are in the adjacent 6 cells)


r=5; %length of hexagon's side !
UE= GeneratePoints(r);

hold off
plot(UE(:,1),UE(:,2),'o')
hold on 
plot(4*r,3*sqrt(3)*r,'rx')
axis([4 36 4 50])

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

