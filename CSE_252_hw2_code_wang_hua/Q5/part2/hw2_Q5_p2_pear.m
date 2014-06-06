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
imshow(I1s);
imshow(I1s,[0.0704,0.9310]);

for i=1:328
for j=1:262
I1uv(i,j)=sqrt(I1suv(i,j,2)*I1suv(i,j,2)+I1suv(i,j,3)*I1suv(i,j,3));
end
end
imshow(I1uv);

for i=1:328
for j=1:262
I2suv(i,j,:)=Kz*Ky*[IM2(i,j,1);IM2(i,j,2);IM2(i,j,3)];
end
end

I2s=I2suv(:,:,1);
imshow(I2s);
imshow(I2s,[0.0704,0.9310]);

for i=1:328
for j=1:262
I2uv(i,j)=sqrt(I2suv(i,j,2)*I2suv(i,j,2)+I2suv(i,j,3)*I2suv(i,j,3));
end
end
imshow(I2uv);

for i=1:328
for j=1:262
I3suv(i,j,:)=Kz*Ky*[IM3(i,j,1);IM3(i,j,2);IM3(i,j,3)];
end
end

I3s=I3suv(:,:,1);
imshow(I3s);
imshow(I3s,[0.0704,0.9310]);

for i=1:328
for j=1:262
I3uv(i,j)=sqrt(I3suv(i,j,2)*I3suv(i,j,2)+I3suv(i,j,3)*I3suv(i,j,3));
end
end
imshow(I3uv);

for i=1:328
for j=1:262
I4suv(i,j,:)=Kz*Ky*[IM4(i,j,1);IM4(i,j,2);IM4(i,j,3)];
end
end

I4s=I4suv(:,:,1);
imshow(I4s);
imshow(I4s,[0.0704,0.9310]);

for i=1:328
for j=1:262
I4uv(i,j)=sqrt(I4suv(i,j,2)*I4suv(i,j,2)+I4suv(i,j,3)*I4suv(i,j,3));
end
end
imshow(I4uv);



figure
subplot(2,2,1);
imshow(I1uv);
title('I1uv');
subplot(2,2,2);
imshow(I2uv);
title('I2uv');
subplot(2,2,3);
imshow(I3uv);
title('I3uv');
subplot(2,2,4);
imshow(I4uv);
title('I4uv');

figure
subplot(2,2,1);
imshow(I1s);
title('I1s');
subplot(2,2,2);
imshow(I2s);
title('I2s');
subplot(2,2,3);
imshow(I3s);
title('I3s');
subplot(2,2,4);
imshow(I4s);
title('I4s');

figure
subplot(2,2,1);
imshow(IM1);
title('IM1');
subplot(2,2,2);
imshow(IM2);
title('IM2');
subplot(2,2,3);
imshow(IM3);
title('IM3');
subplot(2,2,4);
imshow(IM4);
title('IM4');