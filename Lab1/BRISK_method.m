function [kp1,kp2,matches,matched_ratio]=BRISK_method(original_img_gray, disorted_img, tform_type,variable,str,i)
 %  Detect matching features between the original and distorted image
    
    % 1) Detect BRSIK features in original and rotated image
    ptsOriginal  = detectBRISKFeatures(original_img_gray);
    ptsDistorted = detectBRISKFeatures(disorted_img);
   % 'MinContrast',0.01

    % 2) Extract features in both images 
    
    [f1,vpts1] = extractFeatures(original_img_gray,ptsOriginal,'Method','BRISK');
    [f2,vpts2] = extractFeatures(disorted_img,ptsDistorted,'Method','BRISK');
    kp1 = length(vpts1);
    kp2 = length(vpts2);
    
   

    % 3) Find candidate matches: Remeber! Two patches that match can indicate like features but might not be a correct match.
    indexPairs = matchFeatures(f1,f2,'MatchThreshold',40,'MaxRatio',0.8)
    
    matches = length(indexPairs)
    % 4) Find point locations from both images: retrieve the locations of the matched points
    matchedPoints1 = vpts1(indexPairs(:,1));
    matchedPoints2 = vpts2(indexPairs(:,2));
    
    matched_ratio = matches/((kp1 + kp2)/2)


    % Display the candidate matches
    figure(4);
    subplot(2,2,i);
    showMatchedFeatures(original_img_gray,disorted_img,matchedPoints1,matchedPoints2);
    title(['Candidate matched points (',str,' = ', num2str(variable(i)),')'])
    sgtitle(['BRISK Feature Detection and Feature Extraction method (',str,')'])


    % 5) RANSAC - Analyze the feature locations: remove the false matches
    % (If there are a sufficient number of valid matches, remove the false
    % matches). The transform type determine the accuracy. The greater the 
    % number of matched pairs of points, the greater the accuracy of the
    % estimated transformation. 
   
    
    [tform,inlierDistorted,inlierOriginal] = ...
    estimateGeometricTransform(matchedPoints2.Location,...
        matchedPoints1.Location,tform_type);
   
    %  Display matching points: inliers only
    figure(5)
    subplot(2,2,i)
    showMatchedFeatures(original_img_gray,disorted_img,inlierOriginal,inlierDistorted)
    title(['Matching points (',str,'=' ,num2str(variable(i)),')'])
    legend('ptsOriginal','ptsDistorted')
    sgtitle(['BRISK Feature Detection and Feature Extraction method (',str,')'])

    % Verify the computed geometric transform: Apply the computed geometric transform to the distorted image.
    outputView = imref2d(size(original_img_gray));
    recovered  = imwarp(disorted_img,tform,'OutputView',outputView);
    
    % Display Original vs Recovered images 
    figure(6)
    subplot(2,2,i)
    imshowpair(original_img_gray,recovered,'montage')
    title(['Compare Original img vs Recovered img (',str, ' = ',num2str(variable(i)),')'])
    sgtitle(['BRISK Feature Detection and Feature Extraction method (',str,')'])
    
end
