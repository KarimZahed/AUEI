 dist = [0.01;0.03; 0.035; 0.6;0.7; 0.9 ; 4 ];
% 
freq=100; T_perc=50; 
BS_h=10; UE_h=1.5; DTT_h=10; DTT_UH_h_diff=DTT_h-UE_h;

% [ L_b, E]= E_p('land',freq,dist(5),T_perc,UE_h,UE_h,UE_h,BS_h,0,10,'suburban',0,0,0,1) 

    [ L ] = Propagation( freq,dist , 20, 10 ,1 )