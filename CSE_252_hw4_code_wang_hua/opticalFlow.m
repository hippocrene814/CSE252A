function [u, v, hitMap] = opticalFlow(I1, I2, windowSize, tau)

I1 = I1/max(I1(:));
I2 = I2/max(I2(:));

im1 = double(I1);
im2 = double(I2);

Ix = conv2(im1, 0.25*[-1 1; -1 1]) + conv2(im2, 0.25*[-1 1; -1 1]);
Iy = conv2(im1, 0.25*[-1 -1; 1 1]) + conv2(im2, 0.25*[-1 -1; 1 1]);
%It = conv2(im1, 0.25*ones(2)) + conv2(im2, -0.25*ones(2));
It = im2 - im1;

Ix = Ix(1:size(Ix, 1)-1, 1:size(Ix, 2)-1);
Iy = Iy(1:size(Iy, 1)-1, 1:size(Iy, 2)-1);
%It = It(1:size(It, 1)-1, 1:size(It, 2)-1);

u = zeros(size(im1));
v = zeros(size(im2));

%sigma = 1;

%    gaussianWidth = 3*sigma;
%    x = -gaussianWidth:1:gaussianWidth;
%    gaussianKernel = 1/(sqrt(2*pi)*sigma)*exp(-.5*(x.^2)/sigma^2);

%Ix = conv2(Ix, gaussianKernel, 'same');
%Iy = conv2(Iy, gaussianKernel, 'same');

%Ix = Ix/(windowSize^2);
%Iy = Iy/(windowSize^2);
%It = It/(windowSize^2);

sz = size(im1);
hitMap = zeros(sz(1,1), sz(1,2));
        
sumFilter = ones(windowSize);

sumIx2 = conv2((Ix.^2), sumFilter, 'same');
sumIy2 = conv2((Iy.^2), sumFilter, 'same');
sumIxy = conv2((Ix.*Iy), sumFilter, 'same');
sumIxt = conv2((Ix.*It), sumFilter, 'same');
sumIyt = conv2((Iy.*It), sumFilter, 'same');

sumIx2 = sumIx2/(windowSize^2);
sumIy2 = sumIy2/(windowSize^2);
sumIxy = sumIxy/(windowSize^2);
sumIxt = sumIxt/(windowSize^2);
sumIyt = sumIyt/(windowSize^2);

q1 = sumIx2;
q2 = sumIy2;
q3 = sumIxy;

S = sqrt(-4.*(q1.*q2-q3.^2) + (q1 + q2).^2);
l1 = (q1+q2+S)/2;
%l1 = l1/max(l1(:));
l2 = (q1+q2-S)/2;
%l2 = l2/max(l2(:));

for i = 1:sz(1,1)
    for j = 1:sz(1,2)
        if (l1(i,j) > tau && l2(i,j) > tau)
            hitMap(i,j) = 1;
            
            A = [sumIx2(i,j) sumIxy(i,j); sumIxy(i,j) sumIy2(i,j)];
            B = [sumIxt(i,j); sumIyt(i,j)];
        
            U = inv(A)*B;
            
            u(i,j) = (-1)*U(1);
            v(i,j) = (-1)*U(2);
        end
        
    end
end

[x y] = meshgrid(1:size(im1,1), 1:size(im1,2));
for i = 1:floor(size(im1,1)/10)
for j = 1:floor(size(im1,1)/10)
xs(i,j) = x(10*i, 10*j);
ys(i,j) = y(10*i, 10*j);
us(i,j) = u(10*i, 10*j);
vs(i,j) = v(10*i, 10*j);
end
end

tmp = imread('bt.000.png');
subplot(2,3,1), imshow(double(tmp)), hold on;
quiver(xs, ys, us, vs, 0.8, 'linewidth', 1.5);
