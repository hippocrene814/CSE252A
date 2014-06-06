P1=[-1,-0.5,2,1]';
P2=[1,-0.5,2,1]';
P3=[1,0.5,2,1]';
P4=[-1,0.5,2,1]';
P=[P1, P2, P3, P4];

Pe1=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
Pi11=[1 0 0 0; 0 1 0 0; 0 0 1 0];
Pi21=[0.5 0 0 0; 0 0.5 0 0; 0 0 0 1];
Q11=Pi11*Pe1*P;
Q11=Q11./[Q11(3,:);Q11(3,:);Q11(3,:)];
Q21=Pi21*Pe1*P;
Q21=Q21./[Q21(3,:);Q21(3,:);Q21(3,:)];


Pe2=[1 0 0 0; 0 1 0 0; 0 0 1 1; 0 0 0 1];
Pi12=[1 0 0 0; 0 1 0 0; 0 0 1 0];
PP2=Pe2*P;
x02=sum(PP2(1,:))/4;
y02=sum(PP2(2,:))/4;
z02=sum(PP2(3,:))/4;
Pi22=[1/(z02) 0 -1*x02/(z02*z02) 1*x02/z02; 0 1/(z02) -1*y02/(z02*z02) 1*y02/z02; 0 0 0 1];
Q12=Pi12*Pe2*P;
Q12=Q12./[Q12(3,:);Q12(3,:);Q12(3,:)];
Q22=Pi22*Pe2*P;
Q22=Q22./[Q22(3,:);Q22(3,:);Q22(3,:)];


Pe3=[cos(pi/3) 0 sin(pi/3) 0; 0 1 0 0; -sin(pi/3) 0 cos(pi/3) 1; 0 0 0 1]*[cos(pi/6) -sin(pi/6) 0 0; sin(pi/6) cos(pi/6) 0 0; 0 0 1 0; 0 0 0 1];
Pi13=[1 0 0 0; 0 1 0 0; 0 0 1 0];
PP3=Pe3*P;
x03=sum(PP3(1,:))/4;
y03=sum(PP3(2,:))/4;
z03=sum(PP3(3,:))/4;
Pi23=[1/(z03) 0 -1*x03/(z03*z03) 1*x03/z03; 0 1/(z03) -1*y03/(z03*z03) 1*y03/z03; 0 0 0 1];
Q13=Pi13*Pe3*P;
Q13=Q13./[Q13(3,:);Q13(3,:);Q13(3,:)];
Q23=Pi23*Pe3*P;
Q23=Q23./[Q23(3,:);Q23(3,:);Q23(3,:)];


Pe4=[cos(pi/3) 0 sin(pi/3) 0; 0 1 0 0; -sin(pi/3) 0 cos(pi/3) 13; 0 0 0 1]*[cos(pi/6) -sin(pi/6) 0 0; sin(pi/6) cos(pi/6) 0 0; 0 0 1 0; 0 0 0 1];
Pi14=[1 0 0 0; 0 1 0 0; 0 0 0.2 0];
PP4=Pe4*P;
x04=sum(PP4(1,:))/4;
y04=sum(PP4(2,:))/4;
z04=sum(PP4(3,:))/4;
Pi24=[5/(z04) 0 -5*x04/(z04*z04) 5*x04/z04; 0 5/(z04) -5*y04/(z04*z04) 1*y04/z04; 0 0 0 1];
Q14=Pi14*Pe4*P;
Q14=Q14./[Q14(3,:);Q14(3,:);Q14(3,:)];
Q24=Pi24*Pe4*P;
Q24=Q24./[Q24(3,:);Q24(3,:);Q24(3,:)];

SUBPLOT(4,2,1), plotsquare(Q11),title('proj,origin');
SUBPLOT(4,2,2), plotsquare(Q21),title('affine,origin');
SUBPLOT(4,2,3), plotsquare(Q12),title('proj,translation');
SUBPLOT(4,2,4), plotsquare(Q22),title('affine,translation');
SUBPLOT(4,2,5), plotsquare(Q13),title('proj,rotation');
SUBPLOT(4,2,6), plotsquare(Q23),title('affine,rotation');
SUBPLOT(4,2,7), plotsquare(Q14),title('proj,rotation long distance');
SUBPLOT(4,2,8), plotsquare(Q24),title('affine,rotation long distance');


