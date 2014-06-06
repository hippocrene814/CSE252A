function [corners Ix Iy] = CornerDetect(img, numCorners, sigma, windowSize)
    if nargin < 3, sigma = 2; end
    if nargin < 4, windowSize = sigma*6+1; end
    
    % Compute a gaussian kernel
    gaussianWidth = 3*sigma;
    x = -gaussianWidth:1:gaussianWidth;
    gaussianKernel = 1/(sqrt(2*pi)*sigma)*exp(-.5*(x.^2)/sigma^2);
    
    % Compute the gradient
    smoothedXDerivativeKernel = conv2(gaussianKernel, [-1 0 1]);
    smoothedYDerivativeKernel = smoothedXDerivativeKernel';
    Ix = conv2(img, smoothedXDerivativeKernel, 'same');
    Iy = conv2(img, smoothedYDerivativeKernel, 'same');
    
    % Compute sums of Ix^2, Iy^2, and Ix*Iy over a windowSizeXwindowSize
    % neighborhood
    sum_Ix_sqr = conv2(Ix.^2, ones(windowSize), 'same'); 
    sum_Iy_sqr = conv2(Iy.^2, ones(windowSize), 'same'); 
    sum_Ix_Iy  = conv2(Ix.*Iy, ones(windowSize), 'same'); 
    
    % Compute the matrix of smallest singular values lambda2 for each 
    % pixel location.  Here, C=[sum_Ix_sqr,sum_Ix_Iy;sum_Ix_Iy,sum_Iy_sqr].
    % Since C is just a 2X2 matrix, we can compute this singular value
    % analytically in closed form, for all pixels simultaneously
    trace_C = sum_Ix_sqr + sum_Iy_sqr;
    determinant_C = sum_Ix_sqr.*sum_Iy_sqr - sum_Ix_Iy.*sum_Ix_Iy;
    lambda2 = .5*(trace_C - sqrt(trace_C.^2 - 4*determinant_C));
    nmsCorners = ones(size(lambda2));
    
    % A pixel is a corner if it passes:
    %   1) Its second eigenvalue lambda2 > threshold
%     nmsCorners = nmsCorners(lambda2 > threshold);
%     lambda2 = lambda2(lambda2 > threshold);
    
    %   2) It passes non-maximal suppression, such that its value of
    %   lambda2 is greater than that of all of its 8 neighboring pixels
    neighbors = [-1 -1; -1 0; -1 1;  0 -1; 0 1;  1 -1; 1 0; 1 1]+2;
    for i=1:size(neighbors,1)
        k = zeros(3);
        k(neighbors(i,1),neighbors(i,2)) = 1;
        nmsCorners = nmsCorners & lambda2 > conv2(lambda2, k, 'same');
    end
    [y x] = ind2sub(size(nmsCorners), find(nmsCorners));
    corners = [x y];
    
    % Throw away corners that are too close to the boundary
    hs = (windowSize-1)/2;
    valid = (x > 1+hs) & (y > 1+hs) & (x < size(img,2)-hs) & (y < size(img,1)-hs);
    corners = corners(valid,:);
    
    scores = lambda2(sub2ind(size(lambda2),corners(:,2),corners(:,1)));
    [v inds] = sort(-scores);
    numCorners = min(length(inds),numCorners);
    corners = corners(inds(1:numCorners),:);
    
    figure(1), imshow(img), hold on
    plot(corners(:,1), corners(:,2), 'ro', 'MarkerSize', 7, 'linewidth',2), title('corners detected');

end