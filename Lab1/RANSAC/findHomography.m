function [H corrPtIdx] = findHomography(pts1,pts2)
% [H corrPtIdx] = findHomography(pts1,pts2)
%	Find the homography between two planes using a set of corresponding
%	points. PTS1 = [x1,x2,...;y1,y2,...]. RANSAC method is used.
%	corrPtIdx is the indices of inliers.
%	Yan Ke @ THUEE, 20110123, xjed09@gmail.com


coef.minPtNum = 4;
coef.iterNum = 30;
coef.thDist = 4;
coef.thInlrRatio = .1;
[H corrPtIdx] = ransac1(pts1,pts2,coef,@solveHomo,@calcDist);

end

function d = calcDist(H,pts1,pts2)
%	Project PTS1 to PTS3 using H, then calcultate the distances between
%	PTS2 and PTS3
m = min(length(pts1), length(pts2));
n = size(pts1,2);
pts3 = H.*[pts1;ones(1,n)];
pts3 = pts3(1:2,:)./repmat(pts3(3,:),2,1);
% size(pts2);
% size(pts3);
% m = min(length(pts2), length(pts3));
d = sum((pts2(1:m)-pts3(1:m)).^2,1);

end