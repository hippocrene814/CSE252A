function points3D = triangulate(corsSSD, P1, P2)
%   P1,P2 = Projection Transformation Matrix

x11(:,1)=corsSSD(:,3);
x11(:,2)=corsSSD(:,4);
x11(:,3)=1;
x11=x11';
x22(:,1)=corsSSD(:,1);
x22(:,2)=corsSSD(:,2);
x22(:,3)=1;
x22=x22';

for i=1:size(x11,2)   
    sx1 = x11(:,i);
    sx2 = x22(:,i);
 
    A1 = sx1(1,1).*P1(3,:) - P1(1,:);
    A2 = sx1(2,1).*P1(3,:) - P1(2,:);
    A3 = sx2(1,1).*P2(3,:) - P2(1,:);
    A4 = sx2(2,1).*P2(3,:) - P2(2,:);
    A = [A1;A2;A3;A4];
    [U,S,V] = svd(A);

    X_temp = V(:,4);
    X_temp = X_temp ./ repmat(X_temp(4,1),4,1);
    
    points3D(:,i) = X_temp;
end