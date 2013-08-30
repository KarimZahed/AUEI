 BS_h=30; UE_h=30; DTT_h=10;

 freq=708;
 Environment='open';
%  
 UE=[1,0,UE_h; 1,0.5,UE_h; 1,1,UE_h ; 0.5,1,UE_h; 0,1,UE_h; 1,-0.5, UE_h; 1,-1,UE_h; 0.5,-1, UE_h; 0,-1,UE_h; -1,1,UE_h; -1,-1,UE_h];
% 
 tow=3  *pi/180;
% 
 RespectiveBase=[0,0,BS_h];
% 
 [ phi,theta ] = Tilt( UEs, RespectiveBase, tow )

% % Angles are correct since they are done with respect to the BS's line of
% % sight in each hexagon

% UE=[1,0.5,UE_h];
DTT_xyz=[0.5,0,DTT_h];
DTT_station=[2,0];

dist=((DTT_xyz(1)-UE(1)).^2  +(DTT_xyz(2)-UE(2)).^2).^(1/2);

[PL_UE_matrix(1),sigma(1)] = Propagation( freq, dist , BS_h, UE_h, Environment,1 );
%Propogation loss is not the same as tery's
 
[ Gain, normDTT ] = DTTGain(UE,DTT_xyz,DTT_station  );