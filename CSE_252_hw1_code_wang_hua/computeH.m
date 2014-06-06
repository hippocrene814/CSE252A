function H = computeH(targetPoints, sourcePoints)

A(1,:) = [-targetPoints(1,1), -targetPoints(1,2), -1, 0, 0, 0, sourcePoints(1,1)*targetPoints(1,1), sourcePoints(1,1)*targetPoints(1,2), sourcePoints(1,1)];
A(2,:) = [0, 0, 0, -targetPoints(1,1), -targetPoints(1,2), -1, sourcePoints(1,2)*targetPoints(1,1), sourcePoints(1,2)*targetPoints(1,2), sourcePoints(1,2)];
A(3,:) = [-targetPoints(2,1), -targetPoints(2,2), -1, 0, 0, 0, sourcePoints(2,1)*targetPoints(2,1), sourcePoints(2,1)*targetPoints(2,2), sourcePoints(2,1)];
A(4,:) = [0, 0, 0, -targetPoints(2,1), -targetPoints(2,2), -1, sourcePoints(2,2)*targetPoints(2,1), sourcePoints(2,2)*targetPoints(2,2), sourcePoints(2,2)];
A(5,:) = [-targetPoints(3,1), -targetPoints(3,2), -1, 0, 0, 0, sourcePoints(3,1)*targetPoints(3,1), sourcePoints(3,1)*targetPoints(3,2), sourcePoints(3,1)];
A(6,:) = [0, 0, 0, -targetPoints(3,1), -targetPoints(3,2), -1, sourcePoints(3,2)*targetPoints(3,1), sourcePoints(3,2)*targetPoints(3,2), sourcePoints(3,2)];
A(7,:) = [-targetPoints(4,1), -targetPoints(4,2), -1, 0, 0, 0, sourcePoints(4,1)*targetPoints(4,1), sourcePoints(4,1)*targetPoints(4,2), sourcePoints(4,1)];
A(8,:) = [0, 0, 0, -targetPoints(4,1), -targetPoints(4,2), -1, sourcePoints(4,2)*targetPoints(4,1), sourcePoints(4,2)*targetPoints(4,2), sourcePoints(4,2)];
[U S V] = svd(A);

H(1,:) = V(1:3,9);
H(2,:) = V(4:6,9);
H(3,:) = V(7:9,9);


