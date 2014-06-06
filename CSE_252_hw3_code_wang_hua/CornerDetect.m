function corners = CornerDetect(Image, nCorners, SmoothSTD, windowSize)

dx = [-1 0 1; -1 0 1; -1 0 1];
dy = dx';
im1 = rgb2gray(Image);
Ix = conv2(im1, dx, 'valid');
Iy = conv2(im1, dy, 'valid');

[dx, dy] = meshgrid(-(windowSize-1)/2: (windowSize-1)/2);
K = inline('exp(-(x.^2 + y.^2)/2/SmoothSTD^2)');
weight = K(SmoothSTD, dx, dy)/sum(sum(K(SmoothSTD, dx, dy)));

Ix2 = conv2(Ix.^2, weight, 'valid');
Iy2 = conv2(Iy.^2, weight, 'valid');
Ixy = conv2(Ix.*Iy, weight, 'valid');

sz = size(Image);

q1 = zeros(sz(1,1)*sz(1,2),1);
q2 = zeros(sz(1,1)*sz(1,2),1);
q3 = zeros(sz(1,1)*sz(1,2),1);

sumFilter = ones(windowSize);

q1 = conv2(Ix2, sumFilter, 'same');
q2 = conv2(Iy2, sumFilter, 'same');
q3 = conv2(Ixy, sumFilter, 'same');

S = sqrt(-4.*(q1.*q2-q3.^2) + (q1 + q2).^2);
l1 = (q1+q2+S)/2;
l2 = (q1+q2-S)/2;

%lambda1 = reshape(l1, sz(1,1), sz(1,2));
%lambda2 = reshape(l2, sz(1,1), sz(1,2));

lambda(:,:,1) = l1;
lambda(:,:,2) = l2;

sz1 = size(l1);
lambda = reshape(lambda, [size(lambda,1)*size(lambda,2) size(lambda,3)]);
localmin = min(lambda, [], 2);
localmin = reshape(localmin, sz1(1, 1), sz1(1,2));

R = localmin(2:size(localmin,1)-1, 2:size(localmin,2)-1) > localmin(2:size(localmin,1)-1, 3:size(localmin,2));
L = localmin(2:size(localmin,1)-1, 2:size(localmin,2)-1) > localmin(2:size(localmin,1)-1, 1:size(localmin,2)-2);
U = localmin(2:size(localmin,1)-1, 2:size(localmin,2)-1) > localmin(1:size(localmin,1)-2, 2:size(localmin,2)-1);
D = localmin(2:size(localmin,1)-1, 2:size(localmin,2)-1) > localmin(3:size(localmin,1), 2:size(localmin,2)-1);
UR = localmin(2:size(localmin,1)-1, 2:size(localmin,2)-1) > localmin(1:size(localmin,1)-2, 3:size(localmin,2));
DR = localmin(2:size(localmin,1)-1, 2:size(localmin,2)-1) > localmin(3:size(localmin,1), 3:size(localmin,2));
UL = localmin(2:size(localmin,1)-1, 2:size(localmin,2)-1) > localmin(1:size(localmin,1)-2, 1:size(localmin,2)-2);
DL = localmin(2:size(localmin,1)-1, 2:size(localmin,2)-1) > localmin(3:size(localmin,1), 1:size(localmin,2)-2);
m = zeros(sz1);
m(2:sz1(1,1)-1, 2:sz1(1,2)-1) = R .* L .* U .* D.* UR .* DR .* UL .* DL;
localmin1 = m .* localmin; % local maxima



[sortedValues, sortIndex] = sort(localmin1(:), 'descend');
ind = sortIndex(1:nCorners);

[r1 c1] = ind2sub([size(localmin,1), size(localmin,2)], ind);

corners = [r1 c1];

figure(1), imshow(Image), hold on
plot(c1, r1, 'o', 'MarkerSize', 10, 'linewidth',2), title('corners detected');


end
