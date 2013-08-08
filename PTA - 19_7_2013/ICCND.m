function [ Q,Q_max,Q_min ] = ICCND(T_perc, T_perc_min, T_perc_max)
%Equations from Annex 5, Section 16
%valid for x between 0.01 and 0.99 

	x=T_perc/100;
    xmin=T_perc_min/100;
    xmax=T_perc_max/100;
    T_x=sqrt(-2*log(x)); % T(x)
    T_xx=sqrt(-2*log(1-x)); %T(1-x)
    T_xmin=sqrt(-2*log(xmin)); % T(xmin)
    T_xxmin=sqrt(-2*log(1-xmin)); %T(1-xmin)
    T_xmax=sqrt(-2*log(xmax)); % T(xmax)
    T_xxmax=sqrt(-2*log(1-xmax)); %T(1-xmax)
    C0=2.515517;
    C1=0.802853;
    C2=0.010328;
    D1=1.432788;
    D2=0.189269;
    D3=0.001308;
    epsilon=((C2*T_x+C1)*T_x+C0)/(((D3*T_x+D2)*T_x+D1)*T_x+1); %epsilon(x)
    epsilonx=((C2*T_xx+C1)*T_xx+C0)/(((D3*T_xx+D2)*T_xx+D1)*T_xx+1);%epsilon(1-x)
    epsilonmin=((C2*T_xmin+C1)*T_xmin+C0)/(((D3*T_xmin+D2)*T_xmin+D1)*T_xmin+1); %epsilon(xmin)
    epsilonxmin=((C2*T_xxmin+C1)*T_xxmin+C0)/(((D3*T_xxmin+D2)*T_xxmin+D1)*T_xxmin+1);%epsilon(1-xmin)
    epsilonmax=((C2*T_xmax+C1)*T_xmax+C0)/(((D3*T_xmax+D2)*T_xmax+D1)*T_xmax+1); %epsilon(xmax)
    epsilonxmax=((C2*T_xxmax+C1)*T_xxmax+C0)/(((D3*T_xxmax+D2)*T_xxmax+D1)*T_xxmax+1);%epsilon(1-xmax)

    if x<=0.5
        Q=T_x-epsilon;
        Q_min=T_xmin-epsilonmin;
        Q_max=T_xmax-epsilonmax;
    else
        Q=-(T_xx-epsilonx);
        Q_min=T_xxmin-epsilonxmin;
        Q_max=T_xxmax-epsilonxmax;
    end


end