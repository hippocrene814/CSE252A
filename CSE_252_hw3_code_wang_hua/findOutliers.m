function[inlier, outlier] = findOutliers(points3D, P2, outlierTH, corsSSD)
%points3D is 4*n, P2 is 3*4. back=P2*points3D
corsB=corsSSD(:,1:2);%n*2 matrix
corsB=corsB';%2*n matrix
back=P2*points3D; %3*n matrix
szback=size(corsB);

bback(1,:)=back(1,:)./back(3,:);
bback(2,:)=back(2,:)./back(3,:); %bback 2*n matrix

p=1;
q=1;
for i=1:(szback(1,2))
    if(((corsB(1,i)-bback(1,i))^2+(corsB(2,i)-bback(2,i))^2)>(outlierTH^2))
        outlier(:,p)=bback(:,i);
        p=p+1;
    else
        inlier(:,q)=bback(:,i);
        q=q+1;
    end
end

szin=q-1;
szout=p-1;


