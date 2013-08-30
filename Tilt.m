function [ phi,theta ] = Tilt( UE, RespectiveBase, tow )
%takes as input all UEs and a  certain Base Station

SIZE=size(UE,1);

UEnew=zeros(SIZE,3);

x=zeros(SIZE,1); xp=zeros(SIZE,1); xpp=zeros(SIZE,1);
y=zeros(SIZE,1); yp=zeros(SIZE,1); ypp=zeros(SIZE,1);
z=zeros(SIZE,1); zp=zeros(SIZE,1); zpp=zeros(SIZE,1);


Reference(1:SIZE,1)=2;
Reference(1:SIZE,2)=0;

x(1:SIZE)= UE(1:SIZE,1)- RespectiveBase(1); 
y(1:SIZE)= UE(1:SIZE,2)- RespectiveBase(2);
z(1:SIZE)= UE(1:SIZE,3)- RespectiveBase(3);

 normUE(1:SIZE)=( ( x(1:SIZE)).^2 +(y(1:SIZE).^2)).^(1/2); 
 normRef(1:SIZE)=( ( Reference(:,1)).^2 +((Reference(:,2)).^2)).^(1/2);
 dotp(1:SIZE)=x(:).*Reference(:,1)+y(:).*Reference(:,2);
 Angles=acos(dotp(1:SIZE)./(normUE.*normRef)) *180/pi;


f=find(abs(Angles)<60);
du=find(abs(Angles)>=60 ); % might need to include 
u=find(y>=0);
u=intersect(u,du);
d=find(y<0);
d=intersect(d,du);

%--- till here its fine... The problem is down there ? 
% For Forward zone 
xp(f)=x(f)*cos(tow) - z(f)*sin(tow);
yp(f)=y(f);
zp(f)=x(f)*sin(tow) + z(f)*cos(tow);

UEnew(f,1:3)=[xp(f),yp(f),zp(f)];

% For Downward zone
xp(d)=x(d)*cos(120*pi/180) - y(d)*sin(120*pi/180);
yp(d)=x(d)*sin(120*pi/180) + y(d)*cos(120*pi/180);
zp(d)=z(d);

xpp(d)=xp(d)*cos(tow) - zp(d)*sin(tow);
ypp(d)=yp(d);
zpp(d)=xp(d)*sin(tow) + zp(d)*cos(tow);


UEnew(d,1:3)=[xpp(d),ypp(d),zpp(d)];

% For Upward Zone 
xp(u)=x(u)*cos(240*pi/180) - y(u)*sin(240*pi/180);
yp(u)=x(u)*sin(240*pi/180) + y(u)*cos(240*pi/180);
zp(u)=z(u);

xpp(u)=xp(u)*cos(tow) - zp(u)*sin(tow);
ypp(u)=yp(u);
zpp(u)=xp(u)*sin(tow) + zp(u)*cos(tow);

UEnew(u,1:3)=[xpp(u),ypp(u),zpp(u)];

dist=(UEnew(:,1).^2+UEnew(:,2).^2).^(1/2);

%  newnormUE(1:SIZE)=( ( UEnew(:,1)).^2 +(UEnew(:,2).^2)).^(1/2);
%  dotp2(1:SIZE)=UEnew(:,1).*Reference(:,1)+UEnew(:,2).*Reference(:,2);
%  phi=acos(dotp2(1:SIZE)./(newnormUE.*normRef)) *180/pi;

phi=atan(UEnew(:,2)./UEnew(:,1))*180/pi;

theta=atan(abs(UEnew(:,3)./(1000*dist)))*180/pi;


end