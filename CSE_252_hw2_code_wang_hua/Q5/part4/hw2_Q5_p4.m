smask = imread('spheremask.png');
bmask = imread('bottlemask.png');

MAX = [0,0];
 
 for i = 1:332
     k = 0;
 for j = 1:328;
     if (smask(i, j) == 255)
        k = k+1;
     end
 end
      if (k>MAX(1,1))
         MAX(1,1) = k;
         MAX(1,2) = i;
     end
 end
 
 CenterY = [0,0];
 
 for i = 1:328
     k = 0;
 for j = 1:332;
     if (smask(j, i) == 255)
        k = k+1;
     end
 end
      if (k>CenterY(1,1))
         CenterY(1,1) = k;
         CenterY(1,2) = i;
     end
 end
 
maskZ = zeros(332,328);
for i = 1:332
    for j = 1:328
        if((143^2 - (i-170)^2 - (j-162)^2)>0)
        maskZ(i,j) = sqrt(143^2 - (i-170)^2 - (j-162)^2);
        elseif((143^2 - (i-170)^2 - (j-162)^2)==0)
        maskZ(i,j) = 0;   
        end
    end
end

for i = 1:332
    for j = 1:328
        maskN(i,j,1) = (i-170)/143;
        maskN(i,j,2) = (j-162)/143;
        maskN(i,j,3) = (maskZ(i,j)-0)/143;
    end
end

s1 = imread('sphere1.png');
s2 = imread('sphere2.png');
s3 = imread('sphere3.png');
s4 = imread('sphere4.png');
s5 = imread('sphere5.png');
s6 = imread('sphere6.png');
s7 = imread('sphere7.png');
s8 = imread('sphere8.png');
b1 = imread('bottle1.png');
b2 = imread('bottle2.png');
b3 = imread('bottle3.png');
b4 = imread('bottle4.png');
b5 = imread('bottle5.png');
b6 = imread('bottle6.png');
b7 = imread('bottle7.png');
b8 = imread('bottle8.png');

[row col] = find(smask);
a(:,1) = row(:);
a(:,2) = col(:);

maskNx = maskN(:,:,1);
maskNy = maskN(:,:,2);
maskNz = maskN(:,:,3);

for i = 1:65233
a(i,3) = maskNx(a(i,1),a(i,2));
a(i,4) = maskNy(a(i,1),a(i,2));
a(i,5) = maskNz(a(i,1),a(i,2));
end

ricut = zeros(65233,24);
for i = 1:65233
ricut(i,1) = s1(a(i,1),a(i,2),1);
ricut(i,2) = s1(a(i,1),a(i,2),2);
ricut(i,3) = s1(a(i,1),a(i,2),3);
ricut(i,4) = s2(a(i,1),a(i,2),1);
ricut(i,5) = s2(a(i,1),a(i,2),2);
ricut(i,6) = s2(a(i,1),a(i,2),3);
ricut(i,7) = s3(a(i,1),a(i,2),1);
ricut(i,8) = s3(a(i,1),a(i,2),2);
ricut(i,9) = s3(a(i,1),a(i,2),3);
ricut(i,10) = s4(a(i,1),a(i,2),1);
ricut(i,11) = s4(a(i,1),a(i,2),2);
ricut(i,12) = s4(a(i,1),a(i,2),3);
ricut(i,13) = s5(a(i,1),a(i,2),1);
ricut(i,14) = s5(a(i,1),a(i,2),2);
ricut(i,15) = s5(a(i,1),a(i,2),3);
ricut(i,16) = s6(a(i,1),a(i,2),1);
ricut(i,17) = s6(a(i,1),a(i,2),2);
ricut(i,18) = s6(a(i,1),a(i,2),3);
ricut(i,19) = s7(a(i,1),a(i,2),1);
ricut(i,20) = s7(a(i,1),a(i,2),2);
ricut(i,21) = s7(a(i,1),a(i,2),3);
ricut(i,22) = s8(a(i,1),a(i,2),1);
ricut(i,23) = s8(a(i,1),a(i,2),2);
ricut(i,24) = s8(a(i,1),a(i,2),3);
end
[row col] = find(bmask);
ab(:,1) = row(:);
ab(:,2) = col(:);
ticut = zeros(337894,24);
for i = 1:337894
ticut(i,1) = b1(ab(i,1),ab(i,2),1);
ticut(i,2) = b1(ab(i,1),ab(i,2),2);
ticut(i,3) = b1(ab(i,1),ab(i,2),3);
ticut(i,4) = b2(ab(i,1),ab(i,2),1);
ticut(i,5) = b2(ab(i,1),ab(i,2),2);
ticut(i,6) = b2(ab(i,1),ab(i,2),3);
ticut(i,7) = b3(ab(i,1),ab(i,2),1);
ticut(i,8) = b3(ab(i,1),ab(i,2),2);
ticut(i,9) = b3(ab(i,1),ab(i,2),3);
ticut(i,10) = b4(ab(i,1),ab(i,2),1);
ticut(i,11) = b4(ab(i,1),ab(i,2),2);
ticut(i,12) = b4(ab(i,1),ab(i,2),3);
ticut(i,13) = b5(ab(i,1),ab(i,2),1);
ticut(i,14) = b5(ab(i,1),ab(i,2),2);
ticut(i,15) = b5(ab(i,1),ab(i,2),3);
ticut(i,16) = b6(ab(i,1),ab(i,2),1);
ticut(i,17) = b6(ab(i,1),ab(i,2),2);
ticut(i,18) = b6(ab(i,1),ab(i,2),3);
ticut(i,19) = b7(ab(i,1),ab(i,2),1);
ticut(i,20) = b7(ab(i,1),ab(i,2),2);
ticut(i,21) = b7(ab(i,1),ab(i,2),3);
ticut(i,22) = b8(ab(i,1),ab(i,2),1);
ticut(i,23) = b8(ab(i,1),ab(i,2),2);
ticut(i,24) = b8(ab(i,1),ab(i,2),3);
end

 ns = CREATENS(double(ricut),'NSMethod','kdtree');
idxx = knnsearch(ns,double(ticut));

n=size(bmask);
bottleN=zeros(1176,398,3);
for i=1:337894
    bottleN(ab(i,1),ab(i,2),1)=a(idxx(i,1),3);
    bottleN(ab(i,1),ab(i,2),2)=a(idxx(i,1),4);
    bottleN(ab(i,1),ab(i,2),3)=a(idxx(i,1),5);
end

sn1 = bottleN(:,:,2);
sn2 = bottleN(:,:,1);
sn3 = bottleN(:,:,3);
for i = 1:n(1)
for j = 1:n(2)
    if (bottleN(i,j,3)==0)
        p(i,j)=0;
        q(i,j)=0;
    else
    p(i,j) = bottleN(i,j,2)./bottleN(i,j,3);
    q(i,j) = bottleN(i,j,1)./bottleN(i,j,3);
    end
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
figure ,H=surf(Height);
set(H, 'edgecolor', 'none');


%bbmask=double(bmask);
%g = integrate_horn2(q,p,bbmask,50000,1);
%figure ,H=surf(g);
%set(H, 'edgecolor', 'none');

[X Y ] = meshgrid(1:n(2), 1:n(1));

for i = 1:floor(n(1)/8)
for j = 1:floor(n(2)/8)
x(i,j) = X(i*8, j*8);
y(i,j) = Y(i*8, j*8);
height(i,j) = Height(i*8, j*8);
sn1_s(i,j) = sn1(i*8, j*8);
sn2_s(i,j) = sn2(i*8, j*8);
sn3_s(i,j) = sn3(i*8, j*8);
end
end

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
