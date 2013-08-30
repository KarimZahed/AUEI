
%% GUI Input
prompt1={'Total Number of Time Steps tmax (ms)','Enter the Frequency (MHz)',' Expected Field Strength E received by the DTT (dB uv/m)','DTT_x ','DTT y-coordinate'};
name1='Input';
numlines=1;
defaultanswer1={'1000','708','56.9','0','0'};
answer1=inputdlg(prompt1,name1,numlines,defaultanswer1);

matdata1=cellfun(@str2num,answer1);
tmax=matdata1(1);
freq=matdata1(2);
E_median=matdata1(3);
DTT_x=matdata1(4);
DTT_y=matdata1(5);

prompt2={'Maximum width of the Hexagon R (km)','Number of Base Stations','Number of UEs in each Hexagon','Base Station Antenna Tilt (degrees)','Environment (0=Urban, 1=Suburban, 2=Rural)'};
name2='Layout';
defaultanswer2={'2','9','6','3','1'};
answer2=inputdlg(prompt2,name2,numlines,defaultanswer2);

matdata2=cellfun(@str2num,answer2);
R=matdata2(1);
Total_Base=matdata2(2);
UE_Hexagon=matdata2(3);
tow=matdata2(4)*pi/180;

if matdata2(5)==0
    Environment='Urban';
elseif matdata2(5)==1
    Environment='Suburban';
elseif matdata2(5)==2
    Environment='Rural';
end 

prompt3={'ACS','ACLR',' PLxile according to Setting 1,2, or 3(dB)','Gamma between 0 & 1'};
name3='Power Conditions';
defaultanswer3={'55','33','122','1'};
answer3=inputdlg(prompt3,name3,numlines,defaultanswer3);

matdata3=cellfun(@str2num,answer3);
ACS=matdata3(1);
ACLR=matdata3(2);
PLxile=matdata3(3);
gamma=matdata3(4);

tic
%% Preliminary Calculations
r=R/2; % r is length of hexagon's side in km
DTT_locations=10000;
Hexagons=7;
Total_UE=UE_Hexagon*Hexagons; %42
BS_h=30; UE_h=1.5; DTT_h=10; %(m)

PRco=21; % dB
ACIR=-10*log10( (10^(-ACLR/10)) + 10^(-ACS/10) ); % Derived from Equation (6)
PRadj= PRco - ACIR; %  Equation (4)

G=9.15; %(dB)DTT Maximum Gain with no discrimination
G0=15;%(dB)  BS Maximum gain with no discrimination
Bloss=3; G_UE=-3; %Body Loss(dB), G:UE Antenna gain (dB)
N=-98.17; %(dBm)
P_UE_min= -40 ; P_UE_max= 23 ; %(dBm,dBm )  
Rmin=P_UE_min-P_UE_max;

%Instantiate Matrices: 
counter=zeros(DTT_locations,1); % Interference counter for each DTT location

sigma=zeros(Total_UE,Total_Base); % Sigma for each UE wrt each Base Station
PL_UE_matrix= zeros(Total_UE,Total_Base); % Pathloss Matrix
Pt_UE_min=zeros(Total_UE,1); % Vector of minimum Transmit power 
PL_UE_DTT=zeros(Total_UE,DTT_locations); %
%Base Station index for each UE
UE_BS_index= zeros(Total_UE,1);
%Angle Matrices
phi_matrix=zeros(Total_UE,Total_Base);
theta_matrix=zeros(Total_UE,Total_Base);
%% Plots Centers,Borders and BaseStations
[Centers,Borders,Base]=Initiate(r,BS_h,Total_Base);

%% DTT Field Strength
DTT = E_median - 77.2 + G - 20*log10(freq); %%%% Received DTT  (dBm)
C= DTT + 5.5*randn(DTT_locations,1) ; %dBm for E around 67, C is around -55dBm

ii=find(C<N+PRco); %find the indices which have noise interference
counter(ii)=tmax; %% Will always face interference 
%% 
DTT_xyz=[DTT_x,DTT_y,DTT_h]; %Set them to inputted values.
DTT_station=[DTT_xyz(1)+1,DTT_xyz(2)];
 
Random=0;
 if (DTT_xyz(1)==0 && DTT_xyz(2)==0) %IF DTT x and y =0, (random distribution of DTT)
 Random=1;
 dttplot=zeros(tmax,2);
 end 

for t=1:tmax
    
 %% Sets up the DTT pixel location 
     if (Random==1) %IF DTT x and y =0, -> random distribution of DTT

        [DTT_x,DTT_y]=GenerateDTT(Centers(1,:),r,t);  % Update DTT Location
        DTT_xyz=[DTT_x,DTT_y,DTT_h];
        DTT_station=[DTT_xyz(1)+5,DTT_xyz(2)];   % Update DTT station's location
        dttplot(t,:)=[DTT_xyz(1),DTT_xyz(2)];        
     else
       dttplot= [DTT_x,DTT_y]; 
     end 
 
    UE= GenerateUE(r,Centers,Base,UE_h, UE_Hexagon, Hexagons); % Generates UEs
    
    for z=1:Total_Base
        
        [PL_UE_matrix(:,z),sigma(:,z)] = Propagation( freq, UE(:,z+3)  , BS_h, UE_h, Environment,1 ); % Path loss between UE and BS1
        [phi_matrix(:,z),theta_matrix(:,z)]=Tilt(UE, Base(z,:),tow); % Gives V & H angle between each BS and UE after accounting for tilt
        
    end    
    %               42x9                              42x9
    PL_UE_matrix= PL_UE_matrix + Bloss - G_UE - G0 - AngleGain(phi_matrix,theta_matrix) + sigma.*randn(size(sigma)); % discrimination loss from BS
                                           
    %TPC Equation
    transmit=P_UE_max+ min(0,max(Rmin,gamma*(PL_UE_matrix-PLxile))); %vector containing Standard Transmit power of each of the 42 UEs 
    %42x9 --- but the transmit matrix is full of value 23 
    
 %% Minimum Path loss  
    [Pt_UE_min,UE_BS_index] = min(transmit,[],2); %finds the minimum power loss and the respective BS index
    idx=sub2ind(size(sigma), (1:Total_UE), UE_BS_index');
    sigma_min=sigma(idx);
    
 [DTT_UE_discrim , normDTT] =DTTGain(UE,DTT_xyz,DTT_station ); % Gain between DTT and UE
 DTT_UE_discrim=repmat(DTT_UE_discrim,1,DTT_locations);
 
  %^42x1               ^Discrimination Gain
 Pt_UE=repmat(Pt_UE_min,1,DTT_locations); %42x10000
 sigma_matrix=repmat(sigma_min',1,DTT_locations);
 
 %% Interference         normDTT-distance from UEs to DTT
 PL_UE_DTT = Propagation( freq, (normDTT)' , DTT_h, UE_h, Environment,1 ); % calculate the median values of I for each UE
 PL_UE_DTT = repmat(PL_UE_DTT,1,DTT_locations); % Replicate the standard values in a 42x10000 matrix
 
 PL_UE_DTT= PL_UE_DTT + sigma_matrix.*rand(Total_UE,DTT_locations); %% add the random numbers
 
 I_UE= Pt_UE - PL_UE_DTT + DTT_UE_discrim ; % 42 x 10000,DTT_UE_Gain is negative so it Reduces the power due to discrimination from angle with DTT
 I_t=( 10*log10(sum(10.^(I_UE/10),1)) )'; %(dB) Power Addition
 %% 
 xx= C-10*log10(10.^((I_t+PRadj)/10) + 10.^((N+PRco)/10));
 interfered=find(xx<0);
 
 counter(interfered)=counter(interfered) +1;
end

limit=find (counter>tmax);
counter(limit)=tmax;

Percentages=counter*100/tmax;

s=100;
num=zeros(s,1);
ii=1:s;
I=0.2*ii;
for i=ii
num(i)=size(find (Percentages<I(i)),1);
end 

L=num*100/DTT_locations;
IP= mean(Percentages);

%     xlswrite('testing.xls', {'Location probability'}, 1, 'N1');
%     xlswrite('testing.xls', L , 1, 'N2');
% stem(1:length(counter),Percentages)
% 
% figure(3)
% plot(L,I,'ko')

% figure(2)
% % hold off
%  plot(UE(:,1),UE(:,2),'bo') % Plots the UE
%  hold on % Plots centers and base stations
% plot(Centers(:,1),Centers(:,2),'rx', Base(:,1),Base(:,2),'k+') 
%  hold on % Draws the Borders
%  plot(Borders(:,1,1),Borders(:,2,1),'r',Borders(:,1,2),Borders(:,2,2),'r',Borders(:,1,3),Borders(:,2,3),'r',Borders(:,1,4),Borders(:,2,4),'r',Borders(:,1,5),Borders(:,2,5),'r',Borders(:,1,6),Borders(:,2,6),'r',Borders(:,1,7),Borders(:,2,7),'r')
%  hold on
%  plot(dttplot(:,1),dttplot(:,2),'yx')
%  hold off
toc 