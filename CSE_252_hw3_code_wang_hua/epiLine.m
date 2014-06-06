function [c1 c2]=epiLine(I1, I2, cor1, cor2)
sz=size(I1);
F=fund(cor2, cor1);
cor11=cor1';
for i=1:14
cor11(3,i)=1;
end;

cor21=cor2';
for i=1:14
cor21(3,i)=1;
end;

x=[1,sz(1,1)];
y=[1,sz(1,1)];

figure
imshow(I1);
hold on;

for i=1:14
plot(cor1(i,1),cor1(i,2),'o');
end

for i=1:14
    c2(:,i)=F*cor21(:,i);
    pts2(:,:,i)=linePts(c2(:,i)',x,y);%c2(:,i) 3*1
end

for i=1:14
plot([pts2(1,1,i),pts2(2,1,i)],[pts2(1,2,i),pts2(2,2,i)]);
end

%%%%%%%%%%%%%%%%%%

figure
imshow(I2);
hold on;

for i=1:14
plot(cor2(i,1),cor2(i,2),'o'); % x, y~ column row
end

for i=1:14
    c1(:,i)=F'*cor11(:,i);
    pts1(:,:,i)=linePts(c1(:,i)',x,y);%C1(:,i) 3*1
end

for i=1:14
plot([pts1(1,1,i),pts1(2,1,i)],[pts1(1,2,i),pts1(2,2,i)]);%[x x][y y]~[colume column][row row]
end