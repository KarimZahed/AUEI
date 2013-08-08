function [ Emix,Emax] = mixed( path1,dist1,path2,dist2,path3,dist3,path4,dist4,path5,dist5,path6,dist6,path7,dist7,freq,T_perc,h1,h2,dist)
% Add step 19 for maximum condition 
%UNTITLED Summary of this function goes here
%Detailed explanation goes here
R1=0;
AdjToSea=0;
RecOnLand=0;
dist_sea=0;

if dist<=dist1 % we have only one path
    
    if strcmpi(path2,'land')
        RecOnLand=1;
    end  
    E1=predict_f(path1,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,RecOnLand);
    
    Emix=E1;

elseif dist<=(dist1+dist2)%this case we are sure we have 2 paths
    
    if strcmpi(path2,'land')
        RecOnLand=1;
    end  
    if strcmpi(path1,'sea') || strcmpi(path1,'WarmSea')||strcmpi(path1,'ColdSea')  
        AdjToSea=1;
    end 
    
    E1=predict_f(path1,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E2=predict_f(path2,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,AdjToSea,RecOnLand);
    if strcmpi(path1,'land')
        dist_land=dist1; %total land length traversed 
        dist_sea=0;
        El1=E1;
        Es1=0;
        dl1=dist1;%land length traversed in this path 
        ds1=0;
    else
        dist_land=0;
        dist_sea=dist1;%total sea length traversed
        
        El1=0;
        Es1=E1;
        dl1=0;
        ds1=dist1;%sea  length traversed in this path
    end
    if strcmpi(path2,'land')
        dist_land=dist_land+dist-dist1;%total land length traversed    
      
        El2=E2;
        Es2=0;
        dl2=dist-dist1;%land length traversed in this path 
        ds2=0;
    else
        
        dist_sea=dist_sea+dist-dist1;%total sea length traversed
        
        El2=0;
        Es2=E2;
        dl2=0;
        ds2=dist-dist1;%sea length traversed in this path 
    end
    Fsea=dist_sea/dist;
    A0=1-(1-(Fsea))^(2/3);
    delta=Es1*(ds1/dist_sea) + Es2*(ds2/dist_sea) -El1*(dl1/dist_land)-El2*(dl2/dist_land);
    v=max(1.0,1.0+(delta/40));
    A=(A0)^v;
    Emix=(1-A)*((dist1*El1/dist_land)+(dist-dist1)*El2/dist_land)+A*((dist1*Es1/dist_sea)+(dist-dist1)*Es2/dist_sea);
    
elseif dist<=(dist1+dist2+dist3)
  
    if strcmpi(path3,'land')
        RecOnLand=1;
    end  
   if strcmpi(path1,'sea') || strcmpi(path1,'WarmSea')||strcmpi(path1,'ColdSea')  
        AdjToSea=1;
    end 
        
    E1=predict_f(path1,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E2=predict_f(path2,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E3=predict_f(path3,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,AdjToSea,RecOnLand);
    
    if strcmpi(path1,'land')
        dist_land=dist1;
        dist_sea=0;
        El1=E1;
        Es1=0;
        dl1=dist1;
        ds1=0;
    else
        dist_land=0;
        dist_sea=dist1;
         El1=0;
        Es1=E1;
        dl1=0;
        ds1=dist1;
    end
    if strcmpi(path2,'land')
        dist_land=dist_land+dist2;
         
        El2=E2;
        Es2=0;
        dl2=dist2;
        ds2=0;
    else
       
        dist_sea=dist_sea+dist2;
        El2=0;
        Es2=E2;
        dl2=0;
        ds2=dist2;
    end
    if strcmpi(path3,'land')
        dist_land=dist_land+dist-dist1-dist2;% total land length traversed
        
        El3=E3;
        Es3=0;
        dl3=dist-dist1-dist2;% land length traversed in this path
        ds3=0;
    else 
        
        dist_sea=dist_sea+dist-dist1-dist2; % total sea length traversed
        El3=0;
        Es3=E3;
        dl3=0;
        ds3=dist-dist1-dist2; %sea length traversed in this path
    end
    
    Fsea=dist_sea/dist;
    A0=1-(1-(Fsea))^(2/3);
    delta=Es1*(ds1/dist_sea) + Es2*(ds2/dist_sea)+Es3*(ds3/dist_sea) -El1*(dl1/dist_land)-El2*(dl2/dist_land)-El3*(dl3/dist_land);
    v=max(1.0,1.0+(delta/40));
    A=(A0)^v;
    Emix=(1-A)*((dist1*El1/dist_land)+dist2*El2/dist_land +(dist-dist1-dist2)*El3/dist_land)+A*( dist1*Es1/dist_sea+ dist2*Es2/dist_sea+ (dist-dist1-dist2)*Es3/dist_sea);
    
elseif dist<=(dist1+dist2+dist3+dist4)

     if strcmpi(path4,'land')
        RecOnLand=1;
    end  
    if strcmpi(path1,'sea') || strcmpi(path1,'WarmSea')||strcmpi(path1,'ColdSea')  
        AdjToSea=1;
    end 
        
    
    E1=predict_f(path1,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E2=predict_f(path2,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E3=predict_f(path3,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E4=predict_f(path4,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,AdjToSea,RecOnLand);
    
    if strcmpi(path1,'land')
        dist_land=dist1;
        dist_sea=0;
        El1=E1;
        Es1=0;
        dl1=dist1;
        ds1=0;
    else
        dist_land=0;
        dist_sea=dist1;
         El1=0;
        Es1=E1;
        dl1=0;
        ds1=dist1;
    end
    if strcmpi(path2,'land')
        dist_land=dist_land+dist2;
        
        El2=E2;
        Es2=0;
        dl2=dist2;
        ds2=0;
    else
        
        dist_sea=dist_sea+dist2;
        El2=0;
        Es2=E2;
        dl2=0;
        ds2=dist2;
    end
    if strcmpi(path3,'land')
        dist_land=dist_land+dist3;
        
        El3=E3;
        Es3=0;
        dl3=dist3;
        ds3=0;
    else
       
        dist_sea=dist_sea+dist3;
        El3=0;
        Es3=E3;
        dl3=0;
        ds3=dist3;
    end
    if strcmpi(path4,'land')
        dist_land=dist_land+dist-dist1-dist2-dist3;
        
        El4=E4;
        Es4=0;
        dl4=dist-dist1-dist2-dist3;
        ds4=0;
    else
        
        dist_sea=dist_sea+dist-dist1-dist2-dist3;
        El4=0;
        Es4=E4;
        dl4=0;
        ds4=dist-dist1-dist2-dist3;
    end
    Fsea=dist_sea/dist;
    A0=1-(1-(Fsea))^(2/3);
    delta=Es1*(ds1/dist_sea) + Es2*(ds2/dist_sea)+Es3*(ds3/dist_sea)+Es4*(ds4/dist_sea) -El1*(dl1/dist_land)-El2*(dl2/dist_land)-El3*(dl3/dist_land)-El4*(dl4/dist_land);
    v=max(1.0,1.0+(delta/40));
    A=(A0)^v;
    Emix=(1-A)*((dist1*El1/dist_land)+dist2*El2/dist_land +dist3*El3/dist_land++(dist-dist1-dist2-dist3)*El4/dist_land)+A*( dist1*Es1/dist_sea+ dist2*Es2/dist_sea+ dist3*Es3/dist_sea+(dist-dist1-dist2-dist3)*Es4/dist_sea);
elseif dist<=(dist1+dist2+dist3+dist4+dist5)
 
     if strcmpi(path5,'land')
        RecOnLand=1;
    end  
    if strcmpi(path1,'sea') || strcmpi(path1,'WarmSea')||strcmpi(path1,'ColdSea')  
        AdjToSea=1;
    end 
        
    
    E1=predict_f(path1,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E2=predict_f(path2,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E3=predict_f(path3,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E4=predict_f(path4,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E5=predict_f(path4,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,AdjToSea,RecOnLand);
    if strcmpi(path1,'land')
        dist_land=dist1;
        dist_sea=0;
        El1=E1;
        Es1=0;
        dl1=dist1;
        ds1=0;
    else
        dist_land=0;
        dist_sea=dist1;
        El1=0;
        Es1=E1;
        dl1=0;
        ds1=dist1;
    end
    if strcmpi(path2,'land')
        dist_land=dist_land+dist2;
        
        El2=E2;
        Es2=0;
        dl2=dist2;
        ds2=0;
    else
        
        dist_sea=dist_sea+dist2;
        El2=0;
        Es2=E2;
        dl2=0;
        ds2=dist2;
    end
    if strcmpi(path3,'land')
        dist_land=dist_land+dist3;
        
        El3=E3;
        Es3=0;
        dl3=dist3;
        ds3=0;
    else
       
        dist_sea=dist_sea+dist3;
        El3=0;
        Es3=E3;
        dl3=0;
        ds3=dist3;
    end
    if strcmpi(path4,'land')
        dist_land=dist_land+dist4;
        
        El4=E4;
        Es4=0;
        dl4=dist4;
        ds4=0;
    else
        
        dist_sea=dist_sea+dist4;
        El4=0;
        Es4=E4;
        dl4=0;
        ds4=dist4;
    end
    if strcmpi(path5,'land')
        dist_land=dist_land+dist-dist1-dist2-dist3-dist4;
        
        El5=E5;
        Es5=0;
        dl5=dist-dist1-dist2-dist3-dist4;
        ds5=0;
    else
        
        dist_sea=dist_sea+dist-dist1-dist2-dist3-dist4;
        El5=0;
        Es5=E5;
        dl5=0;
        ds5=dist-dist1-dist2-dist3-dist4;
    end
      Fsea=dist_sea/dist;
    A0=1-(1-(Fsea))^(2/3);
    delta=Es1*(ds1/dist_sea) + Es2*(ds2/dist_sea)+Es3*(ds3/dist_sea)+Es4*(ds4/dist_sea)+Es5*(ds5/dist_sea) -El1*(dl1/dist_land)-El2*(dl2/dist_land)-El3*(dl3/dist_land)-El4*(dl4/dist_land)-El5*(dl5/dist_land);
    v=max(1.0,1.0+(delta/40));
    A=(A0)^v;
    Emix=(1-A)*((dist1*El1/dist_land)+dist2*El2/dist_land +dist3*El3/dist_land+dist4*El4/dist_land+(dist-dist1-dist2-dist3-dist4)*El5/dist_land)+A*( dist1*Es1/dist_sea+ dist2*Es2/dist_sea+ dist3*Es3/dist_sea+dist4*Es4/dist_sea+(dist-dist1-dist2-dist3-dist4)*Es5/dist_sea);
elseif dist<=(dist1+dist2+dist3+dist4+dist5+dist6)
 
     if strcmpi(path6,'land')
        RecOnLand=1;
    end  
    if strcmpi(path1,'sea') || strcmpi(path1,'WarmSea')||strcmpi(path1,'ColdSea')  
        AdjToSea=1;
    end 
        
    
    E1=predict_f(path1,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E2=predict_f(path2,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E3=predict_f(path3,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E4=predict_f(path4,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E5=predict_f(path5,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E6=predict_f(path6,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,AdjToSea,RecOnLand);
    if strcmpi(path1,'land')
        dist_land=dist1;
        dist_sea=0;
        El1=E1;
        Es1=0;
        dl1=dist1;
        ds1=0;
    else
        dist_land=0;
        dist_sea=dist1;
         El1=0;
        Es1=E1;
        dl1=0;
        ds1=dist1;
    end
    if strcmpi(path2,'land')
        dist_land=dist_land+dist2;
        
        El2=E2;
        Es2=0;
        dl2=dist2;
        ds2=0;
    else
        
        dist_sea=dist_sea+dist2;
        El2=0;
        Es2=E2;
        dl2=0;
        ds2=dist2;
    end
    if strcmpi(path3,'land')
        dist_land=dist_land+dist3;
        
        El3=E3;
        Es3=0;
        dl3=dist3;
        ds3=0;
    else
       
        dist_sea=dist_sea+dist3;
        El3=0;
        Es3=E3;
        dl3=0;
        ds3=dist3;
    end
    if strcmpi(path4,'land')
        dist_land=dist_land+dist4;
        
        El4=E4;
        Es4=0;
        dl4=dist4;
        ds4=0;
    else
        
        dist_sea=dist_sea+dist4;
        El4=0;
        Es4=E4;
        dl4=0;
        ds4=dist4;
    end
    if strcmpi(path5,'land')
        dist_land=dist_land+dist5;
        
        El5=E5;
        Es5=0;
        dl5=dist5;
        ds5=0;
    else
        
        dist_sea=dist_sea+dist5;
        El5=0;
        Es5=E5;
        dl5=0;
        ds5=dist5;
    end
    if strcmpi(path6,'land')
        dist_land=dist_land+dist-dist1-dist2-dist3-dist4-dist5;
        
        El6=E6;
        Es6=0;
        dl6=dist-dist1-dist2-dist3-dist4-dist5;
        ds6=0;
    else
        
        dist_sea=dist_sea+dist-dist1-dist2-dist3-dist4-dist5;
        El6=0;
        Es6=E6;
        dl6=0;
        ds6=dist-dist1-dist2-dist3-dist4-dist5;
    end
      Fsea=dist_sea/dist;
    A0=1-(1-(Fsea))^(2/3);
    delta=Es1*(ds1/dist_sea) + Es2*(ds2/dist_sea)+Es3*(ds3/dist_sea)+Es4*(ds4/dist_sea)+Es5*(ds5/dist_sea)+Es6*(ds6/dist_sea) -El1*(dl1/dist_land)-El2*(dl2/dist_land)-El3*(dl3/dist_land)-El4*(dl4/dist_land)-El5*(dl5/dist_land)-El6*(dl6/dist_land);
    v=max(1.0,1.0+(delta/40));
    A=(A0)^v;
    Emix=(1-A)*((dist1*El1/dist_land)+dist2*El2/dist_land +dist3*El3/dist_land+dist4*El4/dist_land+dist5*El5/dist_land+(dist-dist1-dist2-dist3-dist4-dist5)*El6/dist_land)+A*( dist1*Es1/dist_sea+ dist2*Es2/dist_sea+ dist3*Es3/dist_sea+dist4*Es4/dist_sea+dist5*Es5/dist_sea+(dist-dist1-dist2-dist3-dist4-dist5)*Es6/dist_sea);
elseif dist<=(dist1+dist2+dist3+dist4+dist5+dist6+dist7)
 
     if strcmpi(path7,'land')
        RecOnLand=1;
    end  
    if strcmpi(path1,'sea') || strcmpi(path1,'WarmSea')||strcmpi(path1,'ColdSea')  
        AdjToSea=1;
    end 
        
    
    E1=predict_f(path1,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E2=predict_f(path2,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E3=predict_f(path3,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E4=predict_f(path4,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E5=predict_f(path5,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E6=predict_f(path6,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,0,0);
    E7=predict_f(path7,freq,dist,T_perc,h1,h1,h1,h2,R1,h2,0,0,0,AdjToSea,RecOnLand);
    if strcmpi(path1,'land')
        dist_land=dist1;
        dist_sea=0;
        El1=E1;
        Es1=0;
        dl1=dist1;
        ds1=0;
    else
        dist_land=0;
        dist_sea=dist1;
         El1=0;
        Es1=E1;
        dl1=0;
        ds1=dist1;
    end
    if strcmpi(path2,'land')
        dist_land=dist_land+dist2;
        
        El2=E2;
        Es2=0;
        dl2=dist2;
        ds2=0;
    else
        
        dist_sea=dist_sea+dist2;
        El2=0;
        Es2=E2;
        dl2=0;
        ds2=dist2;
    end
    if strcmpi(path3,'land')
        dist_land=dist_land+dist3;
        
        El3=E3;
        Es3=0;
        dl3=dist3;
        ds3=0;
    else
       
        dist_sea=dist_sea+dist3;
        El3=0;
        Es3=E3;
        dl3=0;
        ds3=dist3;
    end
    if strcmpi(path4,'land')
        dist_land=dist_land+dist4;
        
        El4=E4;
        Es4=0;
        dl4=dist4;
        ds4=0;
    else
        
        dist_sea=dist_sea+dist4;
        El4=0;
        Es4=E4;
        dl4=0;
        ds4=dist4;
    end
    if strcmpi(path5,'land')
        dist_land=dist_land+dist5;
        
        El5=E5;
        Es5=0;
        dl5=dist5;
        ds5=0;
    else
        
        dist_sea=dist_sea+dist5;
        El5=0;
        Es5=E5;
        dl5=0;
        ds5=dist5;
    end
    if strcmpi(path6,'land')
        dist_land=dist_land+dist6;
        
        El6=E6;
        Es6=0;
        dl6=dist6;
        ds6=0;
    else
        
        dist_sea=dist_sea+dist6;
        El6=0;
        Es6=E6;
        dl6=0;
        ds6=dist6;
    end
    if strcmpi(path7,'land')
        dist_land=dist_land+dist-dist1-dist2-dist3-dist4-dist5-dist6;
        
        El7=E7;
        Es7=0;
        dl7=dist-dist1-dist2-dist3-dist4-dist5-dist6;
        ds7=0;
    else
        
        dist_sea=dist_sea+dist-dist1-dist2-dist3-dist4-dist5-dist6;
        El7=0;
        Es7=E7;
        dl7=0;
        ds7=dist-dist1-dist2-dist3-dist4-dist5-dist6;
    end
    Fsea=dist_sea/dist;
    A0=1-(1-(Fsea))^(2/3);
    delta=Es1*(ds1/dist_sea) + Es2*(ds2/dist_sea)+Es3*(ds3/dist_sea)+Es4*(ds4/dist_sea)+Es5*(ds5/dist_sea)+Es6*(ds6/dist_sea)+Es7*(ds7/dist_sea) -El1*(dl1/dist_land)-El2*(dl2/dist_land)-El3*(dl3/dist_land)-El4*(dl4/dist_land)-El5*(dl5/dist_land)-El6*(dl6/dist_land)-El7*(dl7/dist_land);
    v=max(1.0,1.0+(delta/40));
    A=(A0)^v;
    Emix=(1-A)*((dist1*El1/dist_land)+dist2*El2/dist_land +dist3*El3/dist_land+dist4*El4/dist_land+dist5*El5/dist_land+dist6*El6/dist_land+(dist-dist1-dist2-dist3-dist4-dist5-dist6)*El7/dist_land)+A*( dist1*Es1/dist_sea+ dist2*Es2/dist_sea+ dist3*Es3/dist_sea+dist4*Es4/dist_sea+dist5*Es5/dist_sea+dist6*Es6/dist_sea+(dist-dist1-dist2-dist3-dist4-dist5-dist6)*Es7/dist_sea);
end
%Step 19 
if T_perc<50
    dtotal=dist1+dist2+dist3+dist4+dist5+dist6+dist7;
    %height_diff=(abs(h1-h2))/1000;
    %eff_dist=sqrt(height_diff^2+ dist^2);
    eff_dist=dist;
    Emax=(106.9-20*log10(eff_dist))+ dist_sea*(2.38*(1-exp(-eff_dist/8.94))*log10(50/T_perc))/dtotal;
end 


end