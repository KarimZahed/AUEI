tic
%% Given (Input)
R=1; r=R/2; % r is length of hexagon's side in km
tmax=360; %(ms)
DTT_locations=10000;

UE_Hexagon=6; % UEs per hexagon
Hexagons=7;   % Number of Hexagons
Total_UE=UE_Hexagon*Hexagons; %

freq=600; T_perc=50; 
BS_h=10; UE_h=1.5; DTT_h=10; %(m)
tow=3; %degrees

E_median=67; %db(uv/m)
G=12+2.15-5; %(dB) ??????????????????????????????????????????????????????? 

DTT_x=r/2; DTT_y=r/2; % DTT coordinates

PRco=21; PRadj=-20; % dB
N=-98.17; %(dBm)- confirmed  
P_UE_min= -40 ; P_UE_max=  23 ;% (dBm)  
Rmin=P_UE_min-P_UE_max;
gamma=1;
PLxile=122; %%(dB) setting 2

%Instantiate Matrices: 
counter=zeros(DTT_locations,1); % Interference counter for each DTT location

PL_UE_matrix= zeros(Total_UE,9); % Pathloss Matrix
sigma=zeros(Total_UE,9);
PL_UE= zeros(Total_UE,1); % 1 is the index of the basestation, 2 is the value of the path loss
UE_BS_index= zeros(Total_UE,1);
Pt_UE_min=zeros(Total_UE,1);
PL_UE_DTT=zeros(Total_UE,DTT_locations);

phi_matrix=zeros(Total_UE,9);
theta_matrix=zeros(Total_UE,9);
%% Plots Centers,Borders and BaseStations
[Centers,Borders,Base]=Initiate(r,BS_h);

%% Sets up the DTT pixel location 
DTT_xyz=[DTT_x,DTT_y,DTT_h];  % allocating a center for the DTT pixel
DTT_station=[DTT_x+5,DTT_y]; 

% Distribution of Field Strength
DTT = E_median - 77.2 + G - 20*log10(freq); %%%% Received DTT  (dBm)
C= DTT + 5.5*randn(DTT_locations,1) ; %dBm for E around 67, C is around -55dBm

ii=find(C<N+PRco); %find the indices which have noise interference
counter(ii)=tmax; %% Will always face interference 

%% 
for t=1:tmax
    
    UE= GenerateUE(r,Centers,Base,UE_h, UE_Hexagon, Hexagons); % Generates UEs
    
    [PL_UE_matrix(:,1),sigma(:,1)] = Propagation( freq, UE(:,4)  , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS1
    [PL_UE_matrix(:,2),sigma(:,2)] = Propagation( freq, UE(:,5)  , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS2
    [PL_UE_matrix(:,3),sigma(:,3)] = Propagation( freq, UE(:,6)  , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS3
    [PL_UE_matrix(:,4),sigma(:,4)] = Propagation( freq, UE(:,7)  , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS4    
    [PL_UE_matrix(:,5),sigma(:,5)] = Propagation( freq, UE(:,8)  , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS5    
    [PL_UE_matrix(:,6),sigma(:,6)] = Propagation( freq, UE(:,9)  , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS6   
    [PL_UE_matrix(:,7),sigma(:,7)] = Propagation( freq, UE(:,10) , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS7    
    [PL_UE_matrix(:,8),sigma(:,8)] = Propagation( freq, UE(:,11) , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS8    
    [PL_UE_matrix(:,9),sigma(:,9)] = Propagation( freq, UE(:,12) , BS_h, UE_h, 'Suburbuan',1 ); % Path loss between UE and BS9 
    
    %Dont know yet which are u f d
    for z=1:9
    [phi_matrix(:,z),theta_matrix(:,z)]=Tilt(UE, Base(z,:),tow); % Gives V & H angle between each BS and UE after accounting for tilt
    end 
    
    %               42x9            42x9
    PL_UE_matrix= PL_UE_matrix - AngleGain(phi_matrix,theta_matrix)-sigma.*randn(size(sigma)); % discrimination loss from BS
    %Angle Gain is negative
    
    transmit=P_UE_max+ min(0,max(Rmin,gamma*(PL_UE_matrix-PLxile))); %vector containing Standard Transmit power of each of the 42 UEs 
    %42x9 --- but the transmit matrix is full of value 23 
    
 %% Minimum Path loss  
    [Pt_UE_min,UE_BS_index] = min(transmit,[],2); %finds the minimum power loss and the respective BS index
    idx=sub2ind(size(sigma), (1:42), UE_BS_index');
    sigma_min=sigma(idx);
    
%% Angle gain here is to DTT so should be changed
[ DTT_UE_Gain , normDTT] =DTTGain(UE,DTT_xyz,DTT_station );
 Pt_UE_min=Pt_UE_min + DTT_UE_Gain; % DTT_UE_Gain is negative so it Reduces the power due to discrimination from angle with DTT
  %^42x1
 Pt_UE=repmat(Pt_UE_min,1,DTT_locations); %42x10000
 sigma_matrix=repmat(sigma_min',1,DTT_locations);
 
 %% Interference         distance from UEs to DTT
 zz = Propagation( freq, (normDTT)' , DTT_h, UE_h, 'Suburbuan',1 ); % calculate the median values of I for each UE
 PL_UE_DTT = repmat(zz,1,DTT_locations); % Replicate the standard values in a 42x10000 matrix
 
 PL_UE_DTT= PL_UE_DTT + sigma_matrix.*rand(42,DTT_locations); %% add the random numbers
 
 I_UE= Pt_UE - PL_UE_DTT; % 42 x 10000
 
 I_t=( 10*log10(sum(10.^(I_UE/10),1)) )'; %(dB) Power Addition

 %% 
 xx= C-10*log10(10.^((I_t+PRadj)/10) + 10.^((N+PRco)/10));
 interfered=find(xx<0);
 
 counter(interfered)=counter(interfered) +1;

end

limit=find (counter>tmax);
counter(limit)=tmax;
Percentages=counter*100/tmax;
N=find (Percentages>5);
size(N)
stem(1:length(counter),Percentages)
% hold off
% plot(UE(:,1),UE(:,2),'bo') % Plots the UE
% hold on % Plots centers and base stations
% plot(Centers(:,1),Centers(:,2),'rx', Base(:,1),Base(:,2),'k+') 
% hold on % Draws the Borders
% plot(Borders(:,1,1),Borders(:,2,1),'r',Borders(:,1,2),Borders(:,2,2),'r',Borders(:,1,3),Borders(:,2,3),'r',Borders(:,1,4),Borders(:,2,4),'r',Borders(:,1,5),Borders(:,2,5),'r',Borders(:,1,6),Borders(:,2,6),'r',Borders(:,1,7),Borders(:,2,7),'r')
toc 