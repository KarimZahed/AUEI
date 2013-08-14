function [ UE ,dist_UE_BS ] = Tilt( UE, Base, UE_BS_index , tow )

x=zeros(42,1); xp=zeros(42,1); xpp=zeros(42,1);
y=zeros(42,1); yp=zeros(42,1); ypp=zeros(42,1);
z=zeros(42,1); zp=zeros(42,1); zpp=zeros(42,1);

u=1:6; f= [ 7:12, 19:24 , 31:36 ]; d= [13:18, 25:30, 37:42];

x(1:42)= UE(1:42,1)- Base(UE_BS_index(1:42),1);
y(1:42)= UE(1:42,2)- Base(UE_BS_index(1:42),2);
z(1:42)= UE(1:42,3)- Base(UE_BS_index(1:42),3);

% For Forward zone 
xp(f)=x(f)*cos(tow) - z(f)*sin(tow);
yp(f)=y(f);
zp(f)=x(f)*sin(tow) + z(f)*cos(tow);

UE(f,1:3)=[xp(f),yp(f),zp(f)];

% For Downward zone
xp(d)=x(d)*cos(120) - y(d)*sin(120);
yp(d)=x(d)*sin(120) + y(d)*cos(120);
zp(d)=z(d);

xpp(d)=xp(d)*cos(tow) - zp(d)*sin(tow);
ypp(d)=yp(d);
zpp(d)=xp(d)*sin(tow) + zp(d)*cos(tow);

UE(d,1:3)=[xpp(d),ypp(d),zpp(d)];

% For Upward Zone 
xp(u)=x(u)*cos(240) - y(u)*sin(240);
yp(u)=x(u)*sin(240) + y(u)*cos(240);
zp(u)=z(u);

xpp(u)=xp(u)*cos(tow) - zp(u)*sin(tow);
ypp(u)=yp(u);
zpp(u)=xp(u)*sin(tow) + zp(u)*cos(tow);

UE(u,1:3)=[xpp(u),ypp(u),zpp(u)];

dist_UE_BS=( ( UE(1:42,1)).^2 +(UE(1:42,2)).^2 ).^(1/2); % distance to respective z'' axis

end