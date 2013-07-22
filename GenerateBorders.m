function [ Borders ] = GenerateBorders(Centers,r )

Borders(:,1,1)= [Centers(1,1)+r/2, Centers(1,1)+r, Centers(1,1)+r/2, Centers(1,1)-r/2, Centers(1,1)-r, Centers(1,1)-r/2, Centers(1,1)+r/2];
Borders(:,2,1)= [Centers(1,2)+r*sqrt(3), Centers(1,2), Centers(1,2)-sqrt(3)*r, Centers(1,2)-sqrt(3)*r, Centers(1,2), Centers(1,2)+sqrt(3)*r, Centers(1,2)+r*sqrt(3) ];

Borders(:,1,2)= [Centers(2,1)+r/2, Centers(2,1)+r, Centers(2,1)+r/2, Centers(2,1)-r/2, Centers(2,1)-r, Centers(2,1)-r/2, Centers(2,1)+r/2];
Borders(:,2,2)= [Centers(2,2)+r*sqrt(3), Centers(2,2), Centers(2,2)-sqrt(3)*r, Centers(2,2)-sqrt(3)*r, Centers(2,2), Centers(2,2)+sqrt(3)*r, Centers(2,2)+r*sqrt(3) ];

Borders(:,1,3)= [Centers(3,1)+r/2, Centers(3,1)+r, Centers(3,1)+r/2, Centers(3,1)-r/2, Centers(3,1)-r, Centers(3,1)-r/2, Centers(3,1)+r/2];
Borders(:,2,3)= [Centers(3,2)+r*sqrt(3), Centers(3,2), Centers(3,2)-sqrt(3)*r, Centers(3,2)-sqrt(3)*r, Centers(3,2), Centers(3,2)+sqrt(3)*r, Centers(3,2)+r*sqrt(3) ];

Borders(:,1,4)= [Centers(4,1)+r/2, Centers(4,1)+r, Centers(4,1)+r/2, Centers(4,1)-r/2, Centers(4,1)-r, Centers(4,1)-r/2, Centers(4,1)+r/2];
Borders(:,2,4)= [Centers(4,2)+r*sqrt(3), Centers(4,2), Centers(4,2)-sqrt(3)*r, Centers(4,2)-sqrt(3)*r, Centers(4,2), Centers(4,2)+sqrt(3)*r, Centers(4,2)+r*sqrt(3) ];

Borders(:,1,5)= [Centers(5,1)+r/2, Centers(5,1)+r, Centers(5,1)+r/2, Centers(5,1)-r/2, Centers(5,1)-r, Centers(5,1)-r/2, Centers(5,1)+r/2];
Borders(:,2,5)= [Centers(5,2)+r*sqrt(3), Centers(5,2), Centers(5,2)-sqrt(3)*r, Centers(5,2)-sqrt(3)*r, Centers(5,2), Centers(5,2)+sqrt(3)*r, Centers(5,2)+r*sqrt(3) ];

Borders(:,1,6)= [Centers(6,1)+r/2, Centers(6,1)+r, Centers(6,1)+r/2, Centers(6,1)-r/2, Centers(6,1)-r, Centers(6,1)-r/2, Centers(6,1)+r/2];
Borders(:,2,6)= [Centers(6,2)+r*sqrt(3), Centers(6,2), Centers(6,2)-sqrt(3)*r, Centers(6,2)-sqrt(3)*r, Centers(6,2), Centers(6,2)+sqrt(3)*r, Centers(6,2)+r*sqrt(3) ];

Borders(:,1,7)= [Centers(7,1)+r/2, Centers(7,1)+r, Centers(7,1)+r/2, Centers(7,1)-r/2, Centers(7,1)-r, Centers(7,1)-r/2, Centers(7,1)+r/2];
Borders(:,2,7)= [Centers(7,2)+r*sqrt(3), Centers(7,2), Centers(7,2)-sqrt(3)*r, Centers(7,2)-sqrt(3)*r, Centers(7,2), Centers(7,2)+sqrt(3)*r, Centers(7,2)+r*sqrt(3) ];


end

