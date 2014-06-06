%R=50, SSDth=800
%I1,I2 2 images
%corners1, corners2 n*2
function [I, corsSSD] = naiveCorrespondanceMatching(I1, I2, corners1, corners2, R, SSDth)
sz=size(corners1);
corsSSD=zeros(sz(1,1),2);
szI=size(I1);

for i=1:sz(1,1)
    if (corners1(i,1)+R)<szI(1,1)
    template=I1(corners1(i,1)-R:corners1(i,1)+R, corners1(i,2)-R:corners1(i,2)+R);
    min=4000;
    for j=1:sz(1,1)
    image=I2(corners2(j,1)-R:corners2(j,1)+R, corners2(j,2)-R:corners2(j,2)+R);
    [match score]=SSDmatch(template, image, SSDth);
    if match==1&&score<min
        min=score;
        corsSSD(i,1)=corners2(j,1);
        corsSSD(i,2)=corners2(j,2);
    end
    end
    end
end
corsSSD(:,3)=corners1(:,1);
corsSSD(:,4)=corners1(:,2);

I=[I1 I2];
figure;
imshow(I);
hold on;
for i=1:sz(1,1)
    plot(corsSSD(i,4),corsSSD(i,3),'ro', 'MarkerSize', 10, 'linewidth',2);
end

for i=1:sz(1,1)
    plot(corsSSD(i,2)+szI(1,1),corsSSD(i,1),'ro', 'MarkerSize', 10, 'linewidth',2);
end

for i=1:sz(1,1)
    if corsSSD(i,2)>1
plot([corsSSD(i,4),corsSSD(i,2)+szI(1,1)],[corsSSD(i,3),corsSSD(i,1)], 'MarkerSize', 10, 'linewidth',2);
    end
end

