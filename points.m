
r=1;
Centers= [0,0 ; 0,2*sqrt(3)*r/2  ; 3*r/2,sqrt(3)*r/2 ; 3*r/2,-sqrt(3)*r/2 ; 0,-2*sqrt(3)*r/2 ; -3*r/2,-sqrt(3)*r/2; -3*r/2, r*sqrt(3)/2];

% u=[r/2,r*sqrt(3)/2];
% v=[r,0];
% 
x=-1+Centers(2,1)+(1--1).*rand(100,1);
y=-1+Centers(2,2)+2*r*sqrt(3)/2.*rand(100,1);


% % xp=x(1:6);
% % yp=y(1:6);
% 
% hold off
% plot([0 u(1) v(1)],[0 u(2) v(2)],'r')
% hold on
% plot(xp,yp,'bo')

i1=find(y>r*sqrt(3)/2+Centers(2,2));
i2=find(y<-r*sqrt(3)/2+Centers(2,2));
i3=find(y>-sqrt(3)*r*(x-Centers(2,1)) +sqrt(3)*r*r+Centers(2,2));
i4=find(y<sqrt(3)*r*(x-Centers(2,1)) -sqrt(3)*r*r +Centers(2,2));
i5=find(y<-sqrt(3)*r*(x-Centers(2,1))-sqrt(3)*r*r +Centers(2,2));
i6=find(y>sqrt(3)*r*(x-Centers(2,1)) +sqrt(3)*r*r +Centers(2,2));

 i=[i1;i2;i3;i4;i5;i6 ];
  x(i)=[];
  y(i)=[];

a=[Centers(2,1)+r/2, Centers(2,1)+r, Centers(2,1)+r/2, Centers(2,1)-r/2, Centers(2,1)-r, Centers(2,1)-r/2, Centers(2,1)+r/2];
b=[Centers(2,2)+r*sqrt(3)/2, Centers(2,2), Centers(2,2)-sqrt(3)*r/2, Centers(2,2)-sqrt(3)*r/2, Centers(2,2), Centers(2,2)+sqrt(3)*r/2, Centers(2,2)+r*sqrt(3)/2 ];

hold off
plot(a,b,'r')
hold on
 plot(x,y,'bo')