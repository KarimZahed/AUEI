function [ Centers, Borders, Base ] = Initiate( r ,BS_h)

%Creates Centers
Centers= [r,0 ; -r/2,-sqrt(3)*r/2; -r/2, r*sqrt(3)/2; r,2*sqrt(3)*r/2  ; 5*r/2,sqrt(3)*r/2 ; 5*r/2,-sqrt(3)*r/2 ; r,-2*sqrt(3)*r/2   ];

%% BASE Stations
Borders(:,1,1)= [Centers(1,1)+r/2, Centers(1,1)+r, Centers(1,1)+r/2, Centers(1,1)-r/2, Centers(1,1)-r, Centers(1,1)-r/2, Centers(1,1)+r/2];
Borders(:,2,1)= [Centers(1,2)+r*sqrt(3)/2, Centers(1,2), Centers(1,2)-sqrt(3)*r/2, Centers(1,2)-sqrt(3)*r/2, Centers(1,2), Centers(1,2)+sqrt(3)*r/2, Centers(1,2)+r*sqrt(3)/2 ];

Borders(:,1,2)= [Centers(2,1)+r/2, Centers(2,1)+r, Centers(2,1)+r/2, Centers(2,1)-r/2, Centers(2,1)-r, Centers(2,1)-r/2, Centers(2,1)+r/2];
Borders(:,2,2)= [Centers(2,2)+r*sqrt(3)/2, Centers(2,2), Centers(2,2)-sqrt(3)*r/2, Centers(2,2)-sqrt(3)*r/2, Centers(2,2), Centers(2,2)+sqrt(3)*r/2, Centers(2,2)+r*sqrt(3)/2 ];

Borders(:,1,3)= [Centers(3,1)+r/2, Centers(3,1)+r, Centers(3,1)+r/2, Centers(3,1)-r/2, Centers(3,1)-r, Centers(3,1)-r/2, Centers(3,1)+r/2];
Borders(:,2,3)= [Centers(3,2)+r*sqrt(3)/2, Centers(3,2), Centers(3,2)-sqrt(3)*r/2, Centers(3,2)-sqrt(3)*r/2, Centers(3,2), Centers(3,2)+sqrt(3)*r/2, Centers(3,2)+r*sqrt(3)/2 ];

Borders(:,1,4)= [Centers(4,1)+r/2, Centers(4,1)+r, Centers(4,1)+r/2, Centers(4,1)-r/2, Centers(4,1)-r, Centers(4,1)-r/2, Centers(4,1)+r/2];
Borders(:,2,4)= [Centers(4,2)+r*sqrt(3)/2, Centers(4,2), Centers(4,2)-sqrt(3)*r/2, Centers(4,2)-sqrt(3)*r/2, Centers(4,2), Centers(4,2)+sqrt(3)*r/2, Centers(4,2)+r*sqrt(3)/2 ];

Borders(:,1,5)= [Centers(5,1)+r/2, Centers(5,1)+r, Centers(5,1)+r/2, Centers(5,1)-r/2, Centers(5,1)-r, Centers(5,1)-r/2, Centers(5,1)+r/2];
Borders(:,2,5)= [Centers(5,2)+r*sqrt(3)/2, Centers(5,2), Centers(5,2)-sqrt(3)*r/2, Centers(5,2)-sqrt(3)*r/2, Centers(5,2), Centers(5,2)+sqrt(3)*r/2, Centers(5,2)+r*sqrt(3)/2 ];

Borders(:,1,6)= [Centers(6,1)+r/2, Centers(6,1)+r, Centers(6,1)+r/2, Centers(6,1)-r/2, Centers(6,1)-r, Centers(6,1)-r/2, Centers(6,1)+r/2];
Borders(:,2,6)= [Centers(6,2)+r*sqrt(3)/2, Centers(6,2), Centers(6,2)-sqrt(3)*r/2, Centers(6,2)-sqrt(3)*r/2, Centers(6,2), Centers(6,2)+sqrt(3)*r/2, Centers(6,2)+r*sqrt(3)/2 ];

Borders(:,1,7)= [Centers(7,1)+r/2, Centers(7,1)+r, Centers(7,1)+r/2, Centers(7,1)-r/2, Centers(7,1)-r, Centers(7,1)-r/2, Centers(7,1)+r/2];
Borders(:,2,7)= [Centers(7,2)+r*sqrt(3)/2, Centers(7,2), Centers(7,2)-sqrt(3)*r/2, Centers(7,2)-sqrt(3)*r/2, Centers(7,2), Centers(7,2)+sqrt(3)*r/2, Centers(7,2)+r*sqrt(3)/2 ];

%% Generates Base Station Locations
Base(1,1)= Centers(1,1)-r;  % Base 1 Location
Base(1,2)= Centers(1,2);

Base(2,1)=Centers(1,1)+r/2;
Base(2,2)=Centers(1,2)+3*sqrt(3)*r/2;  % Base2 Location

Base(3,1)=Centers(1,1)+2*r;
Base(3,2)=Centers(1,2);  % Base3 Location

Base(4,1)=Centers(1,1)+r/2;
Base(4,2)=Centers(1,2)-3*sqrt(3)*r/2;  % Base4 Location

Base(1:4,3)=BS_h;
end

