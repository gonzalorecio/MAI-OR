function [T] = transform_image_to_original(I1,I2, keypoints1, keypoints2)
% TRANSFORM_IMAGE_TO_ORIGINAL maps distorted img to original image given
% keypoints from each other
    [featuresOriginal,validPtsOriginal] = extractFeatures(I1, keypoints1);
    [featuresDistorted,validPtsDistorted] = extractFeatures(I2,keypoints2);

    indexPairs = matchFeatures(featuresOriginal,featuresDistorted);
    matchedPoints1 = validPtsOriginal(indexPairs(:,1),:);
    matchedPoints2 = validPtsDistorted(indexPairs(:,2),:);

    trans = fitgeotrans(matchedPoints2.Location,matchedPoints1.Location,'NonreflectiveSimilarity');

    showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
    T = imwarp(I2,trans,'OutputView',imref2d(size(I1)));
    
end

