function [T] = transform_image_to_original(I1,I2, keypoints1, keypoints2)
% TRANSFORM_IMAGE_TO_ORIGINAL maps distorted img to original image given
% keypoints from each other
    [featuresOriginal,validPtsOriginal] = extractFeatures(I1, keypoints1);
    [featuresDistorted,validPtsDistorted] = extractFeatures(I2,keypoints2);

    indexPairs = matchFeatures(featuresOriginal,featuresDistorted, 'MatchThreshold', 0.3, 'MaxRatio', 0.6, 'Unique', true);
    size(indexPairs)
    matchedPoints1 = validPtsOriginal(indexPairs(:,1),:);
    matchedPoints2 = validPtsDistorted(indexPairs(:,2),:);
    length(matchedPoints1)
    length(keypoints1)
    length(validPtsOriginal)
    length(keypoints2)
    length(validPtsDistorted)
    2*length(matchedPoints2)/(length(keypoints1) + length(keypoints2))

    trans = fitgeotrans(matchedPoints2.Location,matchedPoints1.Location,'NonreflectiveSimilarity');
    figure;
    showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
    T = imwarp(I2,trans,'OutputView',imref2d(size(I1)));
    
end

