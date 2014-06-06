function targetImage = warp(targetImage, logoImage, targetPoints, H)

logoimgr = logoImage(:,:,1);
logoimgg = logoImage(:,:,2);
logoimgb = logoImage(:,:,3);

sz = size(targetImage);
[X Y] = meshgrid(1:sz(1,2), 1:sz(1,1));

xv = [targetPoints(:,1)',targetPoints(1,1)];
yv = [targetPoints(:,2)', targetPoints(1,2)];
in = inpolygon(X,Y,xv,yv);
XY=[Y(in) X(in)]';
szXY=size(XY);
XYZ=[XY(2,:);XY(1,:);ones(1,szXY(:,2))];
XYZ=H*XYZ;
XYZ=XYZ./[XYZ(3,:);XYZ(3,:);XYZ(3,:)];
                ZIr=interp2(double(logoimgr), XYZ(1,:)',XYZ(2,:)');
                ZIg=interp2(double(logoimgg), XYZ(1,:)',XYZ(2,:)');
                ZIb=interp2(double(logoimgb), XYZ(1,:)',XYZ(2,:)');

szXYZ=size(XYZ);
for i=1:szXYZ(1,2)
                targetImage(XY(1,i),XY(2,i),1)=ZIr(i,1);
                targetImage(XY(1,i),XY(2,i),2)=ZIg(i,1);
                targetImage(XY(1,i),XY(2,i),3)=ZIb(i,1);
        end;

