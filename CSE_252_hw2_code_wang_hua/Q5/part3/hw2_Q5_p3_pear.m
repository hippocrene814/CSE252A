load specular-pear.mat
theta=asin(c(2,1));
fi=atan(c(3,1)/c(1,1));
Ky=[cos(fi), 0, sin(fi); 0, 1, 0; -sin(fi), 0, cos(fi)];
Kz=[cos(-theta), -sin(-theta), 0; sin(-theta), cos(-theta), 0; 0, 0 ,1];

IM1=mat2gray(im1);
IM2=mat2gray(im2);
IM3=mat2gray(im3);
IM4=mat2gray(im4);

for i=1:328
for j=1:262
I1suv(i,j,:)=Kz*Ky*[IM1(i,j,1);IM1(i,j,2);IM1(i,j,3)];
end
end

I1s=I1suv(:,:,1);
imshow(I1s,[0.0704,0.9310]);

for i=1:328
for j=1:262
I1uv(i,j)=sqrt(I1suv(i,j,2)*I1suv(i,j,2)+I1suv(i,j,3)*I1suv(i,j,3));
end
end

for i=1:328
for j=1:262
I2suv(i,j,:)=Kz*Ky*[IM2(i,j,1);IM2(i,j,2);IM2(i,j,3)];
end
end

I2s=I2suv(:,:,1);
imshow(I2s,[0.0704,0.9310]);

for i=1:328
for j=1:262
I2uv(i,j)=sqrt(I2suv(i,j,2)*I2suv(i,j,2)+I2suv(i,j,3)*I2suv(i,j,3));
end
end

for i=1:328
for j=1:262
I3suv(i,j,:)=Kz*Ky*[IM3(i,j,1);IM3(i,j,2);IM3(i,j,3)];
end
end

I3s=I3suv(:,:,1);
imshow(I3s,[0.0704,0.9310]);

for i=1:328
for j=1:262
I3uv(i,j)=sqrt(I3suv(i,j,2)*I3suv(i,j,2)+I3suv(i,j,3)*I3suv(i,j,3));
end
end

for i=1:328
for j=1:262
I4suv(i,j,:)=Kz*Ky*[IM4(i,j,1);IM4(i,j,2);IM4(i,j,3)];
end
end

I4s=I4suv(:,:,1);
imshow(I4s,[0.0704,0.9310]);

for i=1:328
for j=1:262
I4uv(i,j)=sqrt(I4suv(i,j,2)*I4suv(i,j,2)+I4suv(i,j,3)*I4suv(i,j,3));
end
end

subplot(2,2,1), imshow(I1uv, [min(I1uv(:)) max(I1uv(:))]);
hold on
title('Recovered Diffuse Image 1');
hold off
subplot(2,2,2), imshow(I2uv, [min(I2uv(:)) max(I2uv(:))]);
hold on
title('Recovered Diffuse Image 2');
hold off
subplot(2,2,3), imshow(I3uv, [min(I3uv(:)) max(I3uv(:))]);
hold on
title('Recovered Diffuse Image 3');
hold off
subplot(2,2,4), imshow(I4uv, [min(I4uv(:)) max(I4uv(:))]);
hold on
title('Recovered Diffuse Image 4');
hold off



ims(:,:,:,1) = IM1;
ims(:,:,:,2) = IM2;
ims(:,:,:,3) = IM3;
ims(:,:,:,4) = IM4;
n = size(ims);
for i = 1:n(1)
for j = 1:n(2)
sNormal(i,j,1) = 0.0;
sNormal(i,j,2) = 0.0;
sNormal(i,j,3) = 0.0;
albedo(i,j) = 0.0;
end
end

for im = 1:4
grayims(:,:,im) = rgb2gray(ims(:,:,:,im));
end

L = [l1; l2; l3; l4];

for i = 1:n(1)
for j = 1:n(2)
for im = 1:4
I(im) = double(grayims(i,j,im));
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
for i = 1:floor(n(1)/8)
for j = 1:floor(n(2)/8)
x(i,j) = X(i*8, j*8);
y(i,j) = Y(i*8, j*8);
ps(i,j) = p(i*8, j*8);
qs(i,j) = q(i*8, j*8);
height(i,j) = Height(i*8, j*8);
sn1_s(i,j) = sn1(i*8, j*8);
sn2_s(i,j) = sn2(i*8, j*8);
sn3_s(i,j) = sn3(i*8, j*8);
end
end

figure
imshow(albedo, [min(albedo(:)) max(albedo(:))])
hold on
title('Albedo Map');
hold off

figure
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
figure, h=surf(Height)
set(h,'edgecolor','none');


for i = 1:328
for j = 1:262
sNormaluv(i,j,1) = 0.0;
sNormaluv(i,j,2) = 0.0;
sNormaluv(i,j,3) = 0.0;
albedo(i,j) = 0.0;
end
end


imsuv(:,:,1) = I1uv;
imsuv(:,:,2) = I2uv;
imsuv(:,:,3) = I3uv;
imsuv(:,:,4) = I4uv;

for i = 1:328
for j = 1:262
sNuv(i,j,1) = 0.0;
sNuv(i,j,2) = 0.0;
sNuv(i,j,3) = 0.0;
albedouv(i,j) = 0;
end
end

for i = 1:328
for j = 1:262
for im = 1:4
I(im) = double(imsuv(i,j,im));
end
[normaluv, albuv] = FindNormal(I, L);
sNuv(i,j,1) = normaluv(1);
sNuv(i,j,2) = normaluv(2);
sNuv(i,j,3) = normaluv(3);
albedouv(i,j) = albuv;
end
end

snuv1 = sNuv(:,:,1);
snuv2 = sNuv(:,:,2);
snuv3 = sNuv(:,:,3);

for i = 1:328
for j = 1:262
puv(i,j) = sNuv(i,j,1)/sNuv(i,j,3);
quv(i,j) = sNuv(i,j,2)/sNuv(i,j,3);
end
end

Heightuv(1,1) = 0;

for i = 2:328
Heightuv(i,1) = Heightuv(i-1,1) + quv(i-1,1);
end
for i = 1:328
for j = 2:262
Heightuv(i,j) = Heightuv(i,j-1) + puv(i,j-1);
end
end
[Xuv Yuv ] = meshgrid(1:262, 1:328);
for i = 1:floor(328/8)
for j = 1:floor(262/8)
xuv(i,j) = Xuv(i*8, j*8);
yuv(i,j) = Yuv(i*8, j*8);
psuv(i,j) = puv(i*8, j*8);
qsuv(i,j) = quv(i*8, j*8);
heightuv(i,j) = Heightuv(i*8, j*8);
snuv1_s(i,j) = snuv1(i*8, j*8);
snuv2_s(i,j) = snuv2(i*8, j*8);
snuv3_s(i,j) = snuv3(i*8, j*8);
end
end

figure
imshow(albedouv, [min(albedouv(:)) max(albedouv(:))])
hold on
title('Diffuse Images--Albedo Map');
hold off

figure
subplot(2,2,1), imshow(snuv1, [min(snuv1(:)) max(snuv1(:))])
hold on
title('Diffuse Images--Nx Component');
hold off

subplot(2,2,2), imshow(snuv2, [min(snuv2(:)) max(snuv2(:))])
hold on
title('Diffuse Images--Ny Component');
hold off

subplot(2,2,3), imshow(snuv3, [min(snuv3(:)) max(snuv3(:))])
hold on
title('Diffuse Images--Nz Component');
hold off

figure, quiver3(xuv,yuv,heightuv, snuv1_s, snuv2_s, snuv3_s)
figure, h=surf(Heightuv)
set(h,'edgecolor','none');