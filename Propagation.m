function [ L ] = Propagation( freq,dist , Hb,Hm, env,AboveRoof )
%for frequencies between 30MHz and 3 GHz
%freq is in MHz
%distances up to 100km

L=zeros(length(dist),1);
sigma=zeros(length(dist),1);

L_004=32.5+20*log10(freq)+20*log10(0.04);
L_01 =32.5+20*log10(freq)+20*log10(0.1);

    if freq >30  && freq <3000 % Within the range of frequencies applicable

%         L=32.5+20*log10(freq)+20*log10(dist); %(in dB)

        %% case 1
        d1=find(dist<=0.04);
        L(d1)=32.4 + 20*log10(freq)+10*log10(dist(d1).^2 + ((Hb-Hm)^2/10^6)) ;
        
        sigma(d1)=3.5; %(dB)
        
        %% case 2
        d2=find(dist>=0.1 & dist<=100);
        
        a=(1.1*log10(freq)-0.7)*min(10,Hm)-(1.56*log10(freq)-0.8)+max(0,20*log10(Hm/10)); %scalar value
        b=min(0,20*log10(Hb/30)); % scalar value
%       b=(1.1*log10(freq)-0.7)*min(10,Hm)-(1.56*log10(freq)-0.8)+max(0,20*log10(Hm/10));
%       what case is short range and low base station height
        
        d21=find(dist>=0.1 & dist<=20);
        d22=find(dist>20 & dist<=100);
        
        alfa=zeros(length(d2),1);
        alfa(d21)=1;
        alfa(d22)=1+(0.14 + 1.87*(10^-4)*freq +1.07*(10^-3)*Hb)*(log10(dist(d22)/20)).^0.8;
        
        
          % standard urban case  
            
        if(freq>30 && freq<= 150 )

           L(d2)=69.6 + 26.2*log10(150)-20*log10(150/freq)-13.82*log10(max(30,Hb))+(44.9 - 6.55*log10(max(30,Hb))).*(log10(dist(d2)).^alfa(d2)) -a-b;

        elseif ( freq>150 && freq<= 1500)

           L(d2)=69.6 + 26.2*log10(freq)- 13.82*log10(max(30,Hb))+(44.9 - 6.55*log10(max(30,Hb)))*(log10(dist(d2)).^alfa) -a-b;

        elseif ( freq>1500 && freq<= 2000)

           L(d2)=46.3 + 33.9*log10(freq)- 13.82*log10(max(30,Hb))+(44.9 - 6.55*log10(max(30,Hb)))*(log10(dist(d2)).^alfa) -a-b;

        elseif ( freq>2000 && freq<= 3000)

            L(d2)=46.3 + 33.9*log10(2000) + 10*log10(freq/2000) - 13.82*log10(max(30,Hb))+(44.9 - 6.55*log10(max(30,Hb)))*(log10(dist(d2)).^alfa) -a-b;

        end
        
        
        if (strcmpi(env,'Suburban'))
            
           L(d2)=L(d2)-2*(log10((min(max(150,freq),2000))/28))^2 -5.4;               
            
        elseif (strcmpi(env,'Open'))
        
           L(d2)=L(d2)-4.78*(log10((min(max(150,freq),2000))))^2 +18.33*(log10((min(max(150,freq),2000)))) - 40.94;     
            
        end 
            
        
        d23=find(dist>0.1 & dist<=0.2);
        d24=find(dist>0.2 & dist<=0.6);
        d25=find(dist>0.6 & dist<=100);
        
        
        if AboveRoof==1
          sigma(d23)=12;
          sigma(d24)=12+(9-12)/(0.6-0.2)*(dist(d24)-0.2);
        
        else
          sigma(d23)=17;
          sigma(d24)=17+(9-17)/(0.6-0.2)*(dist(d24)-0.2);
        end 
        
        sigma(d25)=9;
        
        %case 3
        
        d3=find(dist>0.04 & dist<0.1);
        L(d3)=L_004+( (log10(dist(d3))-log10(0.04))/(log10(0.1)-log10(0.04)))*(L_01-L_004);
        
        if(AboveRoof==1)
          sigma(d3)=3.5+(12-3.5)/(0.1-0.04)*(dist(d3)-0.04);
        else
          sigma(d3)=3.5+(17-3.5)/(0.1-0.04)*(dist(d3)-0.04);
        end
        
        %% confirm T(G(V)
%         v1=2*sigma*rand(1,1)-1;
%         v2=2*sigma*rand(1,1)-1;
%         s= v1.^2 + v2.^2;
%         
%         T=v1.*sqrt(-2*log(s)./s);
%         
%         L=L+T;
        
    else 

    'not in frequency range'
    
    end 



end

