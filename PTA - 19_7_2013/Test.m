tic
clc; clear all;
E=[];
FS=[];
OH=[];
TCA=[];
%[ E,MFS] = predict_f(PathType,freq,dist,T_perc,h1,ha,heff,h2,R1,R2,environment,theta,theta_eff, AdjToSea, RecOnLand )

% 
% %Case 1
% for z=1:1:100
%     E1=predict_f('land',100,z,1,300,300,300,10,0,10,0,0,0,0,1);
%     E=[E ;E1];
% end
%   xlswrite('Cases_15_7.xls', {'Case1'}, 1, 'A1');
%   xlswrite('Cases_15_7.xls', E, 1, 'A2');

% % %Case 2
% for z=1:1:100
%     E2=predict_f('land',100,z,50,300,300,300,10,0,10,0,0,0,0,1);
%     E=[E ;E2];
% end
%   xlswrite('Cases_15_7.xls', {'Case2'}, 1, 'C1');
%   xlswrite('Cases_15_7.xls', E, 1, 'C2');
% % 

% %Case 3
% for z=1:1:100
%     E3=predict_f('land',600,z,1,300,300,300,10,0,10,0,0,0,0,1);
%     E=[E ;E3];
% end
%   xlswrite('Cases_15_7.xls', {'Case3'}, 1, 'E1');
%   xlswrite('Cases_15_7.xls', E, 1, 'E2');

% %Case 4
% for z=1:1:100
%     E4=predict_f('land',600,z,50,300,300,300,10,0,10,0,0,0,0,1);
%     E=[E ;E4];
% end
%   xlswrite('Cases_15_7.xls', {'Case4'}, 1, 'G1');
%   xlswrite('Cases_15_7.xls', E, 1, 'G2');

%   % %Case 5
% for z=1:1:100
%     E5=predict_f('land',2000,z,1,300,300,300,10,0,10,0,0,0,0,1);
%     E=[E ;E5];
% end
%   xlswrite('Cases_15_7.xls', {'Case5'}, 1, 'I1');
%   xlswrite('Cases_15_7.xls', E, 1, 'I2');

%    % %Case 6
% for z=1:1:100
%     E6=predict_f('land',2000,z,50,300,300,300,10,0,10,0,0,0,0,1);
%     E=[E ;E6];
% end
%   xlswrite('Cases_15_7.xls', {'Case6'}, 1, 'K1');
%   xlswrite('Cases_15_7.xls', E, 1, 'K2');
  
% %Case 7
% for z=1:1:100
%     E7=predict_f('land',600,z,50,450,450,450,10,0,10,0,0,0,0,1);
%     E=[E ;E7];
% end
%   xlswrite('Cases_15_7.xls', {'Case7'}, 1, 'M1');
%   xlswrite('Cases_15_7.xls', E, 1, 'M2');
  
% %Case 8
% for z=1:1:100
%     E8=predict_f('land',500,z,50,450,450,450,10,0,10,0,0,0,0,1);
%     E=[E ;E8];
% end
%   xlswrite('Cases_15_7.xls', {'Case8'}, 1, 'O1');
%   xlswrite('Cases_15_7.xls', E, 1, 'O2');
%


%[ E,MFS] = predict_f(PathType,freq,dist,T_perc,h1,ha,heff,h2,R1,R2,environment,theta,theta_eff, AdjToSea, RecOnLand )

% %Case 9

% for z=1:1:100
%     E9=predict_f('land',500,z,50,450,450,450,1.5,0,10,'suburban',0,0,0,1);
%     E=[E ;E9];
%     E_oh = OkumuraHata(500,450,1.5,z );
%     OH=[OH E_oh];
% end
% zx=1:1:100;
% semilogx(zx,E,zx,OH)
% 
%   xlswrite('Cases_15_7.xls', {'Case9'}, 2, 'A1');
%   xlswrite('Cases_15_7.xls', E, 2, 'A2');  
  

% % %Case 10
% for z=1:1:100
%     E10=predict_f('land',500,z,50,450,450,450,30,0,20,'urban',0,0,0,1);
%     E=[E ;E10];
% end
% 
%   xlswrite('Cases_15_7.xls', {'Case10'}, 2, 'C1');
%   xlswrite('Cases_15_7.xls', E, 2, 'C2');  

% %Case 11 -- What is Height of ground cover between
% for z=1:1:15
%     E11=predict_f('land',500,z,50,60,60,60,20,0,20,0,0,0,0,1);
%     E=[E ;E11];
% end
% 
%   xlswrite('Cases_15_7.xls', {'Case11'}, 2, 'E1');
%   xlswrite('Cases_15_7.xls', E, 2, 'E2');  
% %   
%   % %Case 12
% for z=0.01:0.01:1
%     [E12,Emax]=predict_f('land',500,z,50,60,60,60,20,0,20,'urban',0,0,0,1);
%     E=[E ;E12];
% end
% 
%   xlswrite('Cases_15_7.xls', {'Case12'}, 2, 'G1');
%   xlswrite('Cases_15_7.xls', E, 2, 'G2'); 

% %   % %Case 14
% for z=1:1:100
%     E14=predict_f('sea',100,z,50,300,300,300,10,0,10,0,0,0,1,0);
%     E=[E ;E14];
% end
% 
%   xlswrite('Cases_15_7.xls', {'Case14'}, 2, 'I1');
%   xlswrite('Cases_15_7.xls', E, 2, 'I2'); 


%%Case 15 -- Working (9/7/13)
% for z=1:1:100
%     E15=predict_f('ColdSea',100,z,10,300,300,300,10,0,10,0,0,0,1,0);
%     E=[E ;E15];
% end
%   xlswrite('Cases_15_7.xls', {'Case15'}, 2, 'K1');
%   xlswrite('Cases_15_7.xls', E, 2, 'K2');
% 
%   %%Case 16
% for z=1:1:100
%     E16=predict_f('WarmSea',100,z,1,300,300,300,10,0,10,0,0,0,1,0);
%     E=[E ;E16];
% end
%   xlswrite('Cases_15_7.xls', {'Case16'}, 2, 'M1');
%   xlswrite('Cases_15_7.xls', E, 2, 'M2');
  
    %%Case 17
% for z=1:1:100
%     E17=predict_f('sea',600,z,50,300,300,300,10,0,10,0,0,0,1,0);
%     E=[E ;E17];
% end
%   xlswrite('Cases_15_7.xls', {'Case17'}, 3, 'A1');
%   xlswrite('Cases_15_7.xls', E, 3, 'A2');
%   
%      %%Case 18
% for z=1:1:100
%     E18=predict_f('ColdSea',600,z,1,300,300,300,10,0,10,0,0,0,1,0);
%     E=[E ;E18];
% end
%   xlswrite('Cases_15_7.xls', {'Case18'}, 3, 'C1');
%   xlswrite('Cases_15_7.xls', E, 3, 'C2');
%   
% 
%      %%Case 19
% for z=1:1:100
%     E19=predict_f('WarmSea',600,z,1,300,300,300,10,0,10,0,0,0,1,0);
%     E=[E ;E19];
% end
%   xlswrite('Cases_15_7.xls', {'Case19'}, 3, 'E1');
%   xlswrite('Cases_15_7.xls', E, 3, 'E2');
% 
%      %%Case 20
% for z=1:1:100
%     E20=predict_f('sea',2000,z,50,300,300,300,10,0,10,0,0,0,1,0);
%     E=[E ;E20];
% end
%   xlswrite('Cases_15_7.xls', {'Case20'}, 3, 'G1');
%   xlswrite('Cases_15_7.xls', E, 3, 'G2');
%   
%      %%Case 21
% for z=1:1:100
%     E21=predict_f('ColdSea',2000,z,1,300,300,300,10,0,10,0,0,0,1,0);
%     E=[E ;E21];
% end
%   xlswrite('Cases_15_7.xls', {'Case21'}, 3, 'K1');
%   xlswrite('Cases_15_7.xls', E, 3, 'K2');


% Testing Case 22 
% for z=1:500  
%     %E22=mixed('land',50,'ColdSea',90,'land',60,'ColdSea',130,'land',70,'ColdSea',40,'Land',60,600,1,600,10,z);
%     E22=mixed_old('land',50,'ColdSea',90,'land',60,'ColdSea',130,'land',70,'ColdSea',40,'Land',60,600,1,600,10,z);
%     E=[E ; E22];
% end 
% 
%   xlswrite('Cases_15_7.xls', {'Case22'}, 3, 'L1');
%   xlswrite('Cases_15_7.xls', E, 3, 'L2');


% %      %%Case 23
% for z=1:1:100
%     E23=predict_f('land',500,z,50,-10,0,-10,10,0,10,0,0,0,0,1);
%     E=[E ;E23];
% end
%   xlswrite('Cases_15_7.xls', {'Case23'}, 3, 'M1');
%   xlswrite('Cases_15_7.xls', E, 3, 'M2');
% 

%      %%Case 24
% zz=0:1:50;
% zz=[-10 zz];
% for z=zz
%     [E23,MFS,TCA_correction]=predict_f('land',600,10,50,450,450,450,10,0,10,0,z,0,0,1);
%     TCA=[TCA ;TCA_correction];
% end
%   xlswrite('Cases_15_7.xls', {'Case24-TCA'}, 4, 'A1');
%   xlswrite('Cases_15_7.xls', TCA, 4, 'A2');


% %%Case 25
% for z=50:50:500
%     [E25,max,TCA_corr]=predict_f('land',500,z,1,450,450,450,10,0,10,0,10,5,0,1);
%     E=[E ;E25];
%     TCA=[TCA ;TCA_corr];
% end
% 
%   xlswrite('Cases_15_7.xls', {'Case25'}, 4, 'C1');
%   xlswrite('Cases_15_7.xls', E, 4, 'C2');

% %      %%Case 26
% for z=1:1:100
%     E26=predict_f('land',600,z,50,600,600,600,10,0,10,'suburban',0,0,0,1);
%     E=[E ;E26];
% end
%   xlswrite('Cases_15_7.xls', {'Case26'}, 4, 'E1');
%   xlswrite('Cases_15_7.xls', E, 4, 'E2');

% %      %%Case 27
% for z=0.01:0.01:1
%     E27=predict_f('land',600,z,50,600,600,600,10,0,10,'suburban',0,0,0,1);
%     E=[E ;E27];
% end
%   xlswrite('Cases_15_7.xls', {'Case27'}, 4, 'G1');
%   xlswrite('Cases_15_7.xls', E, 4, 'G2');

% %      %%Case 28
% for z=1:1:100
%     E28=predict_f('land',600,z,50,600,75,600,10,0,10,'suburban',0,0,0,1);
%     E=[E ;E28];
% end
%   xlswrite('Cases_15_7.xls', {'Case28'}, 4, 'I1');
%   xlswrite('Cases_15_7.xls', E, 4, 'I2');

  % predict_f(PathType,freq,dist,T_perc,h1,ha,heff,h2,R1,R2,environment,theta,theta_eff )
%   
%   % Case 29%  
%  zx=[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95];
%  x=1:30;
%  x2=57:100;
%  zx=[zx x x2];
% for z=zx
%     E29=predict_f('land',600,z,50,600,5,600,10,0,10,'suburban',0,0,0,1); 
%      E_oh = OkumuraHata(600,600,10,100 );
%     E=[E ;E29];
%     %FS=[FS MFS];
%    % OH=[OH E_oh];   
% end 
% % 
%  xlswrite('Cases_15_7.xls', {'Case29'}, 4, 'K1');
%  xlswrite('Cases_15_7.xls', E, 4, 'K2');

 %  Case 30  

% for z=1:100 %%%%%%%%%%%%%%%%%%%
%     z
          E30=predict_f('land',600,10,50,75,75,-20,10,0,10,'suburban',0,0,0,1); 
%        E30=predict_old('land',600,10,50,75,75,-20,10,10,'suburban',0,0 );
%     E=[E ;E30];
% end 
% % 
%  xlswrite('Cases_15_7.xls', {'Case30'}, 4, 'N1');
%  xlswrite('Cases_15_7.xls', E, 4, 'N2');
%  
%  
%  
% 
% semilogx(zx,E,zx,FS,zx,OH)
% % plot(zx,E)

toc 