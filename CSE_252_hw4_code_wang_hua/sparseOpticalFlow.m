function c = sparseOpticalFlow(I1, corners, nCorners, u, v)

c=ones(nCorners,2);
for i=1:nCorners
    c(i,1)=u(corners(i,2),corners(i,1));
    c(i,2)=v(corners(i,2),corners(i,1));
end

figure;
imshow(I1);
hold on;
plot(corners(:,1), corners(:,2), 'ro', 'MarkerSize', 7, 'linewidth',2), title('corners and optical flow');
hold on;



quiver(corners(:,1),corners(:,2),c(:,1),c(:,2),1,'linewidth',2);