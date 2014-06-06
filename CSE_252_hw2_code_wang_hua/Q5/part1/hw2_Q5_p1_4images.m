load synthetic_data.mat
ims(:,:,1) = im1;
ims(:,:,2) = im2;
ims(:,:,3) = im3;
ims(:,:,4) = im4;
n = size(ims);
for i = 1:n(1)
for j = 1:n(2)
sNormal(i,j,1) = 0.0;
sNormal(i,j,2) = 0.0;
sNormal(i,j,3) = 0.0;
albedo(i,j) = 0.0;
end
end
L = [l1; l2; l3; l4];
for i = 1:n(1)
for j = 1:n(2)
for im = 1:4
I(im) = double(ims(i,j,im));
end
[normal, alb] = FindNormal(I, L);
sNormal(i,j,1) = normal(1);
sNormal(i,j,2) = normal(2);
sNormal(i,j,3) = normal(3);
albedo(i,j) = alb;
end
end

sn1 = sNormal(:,:,1);
sn2 = sNormal(:,:,2);
sn3 = sNormal(:,:,3);
for i = 1:n(1)
for j = 1:n(2)
p(i,j) = sNormal(i,j,1)./sNormal(i,j,3);
q(i,j) = sNormal(i,j,2)./sNormal(i,j,3);
end
end

Height(1,1) = 0;
for i = 2:n(1)
Height(i,1) = Height(i-1,1) + q(i-1,1);
end

for i = 1:n(1)
for j = 2:n(2)
Height(i,j) = Height(i,j-1) + p(i,j-1);
end
end

[X Y ] = meshgrid(1:n(2), 1:n(1));

for i = 1:uint8(n(1)/4)
for j = 1:uint8(n(2)/4)
x(i,j) = X(i*4, j*4);
y(i,j) = Y(i*4, j*4);
ps(i,j) = p(i*4, j*4);
qs(i,j) = q(i*4, j*4);
height(i,j) = Height(i*4, j*4);
sn1_s(i,j) = sn1(i*4, j*4);
sn2_s(i,j) = sn2(i*4, j*4);
sn3_s(i,j) = sn3(i*4, j*4);
end
end


figure;
imshow(albedo, [min(albedo(:)) max(albedo(:))])
hold on
title('Albedo Map');
hold off

figure;
subplot(2,2,1), imshow(sn1, [min(sn1(:)) max(sn1(:))])
hold on
title('Surface Normal X Component');
hold off

subplot(2,2,2), imshow(sn2, [min(sn2(:)) max(sn2(:))])
hold on
title('Surface Normal Y Component');
hold off

subplot(2,2,3), imshow(sn3, [min(sn3(:)) max(sn3(:))])
hold on
title('Surface Normal Z Component');
hold off

figure, quiver3(x,y,height, sn1_s, sn2_s, sn3_s)
figure, surf(Height)