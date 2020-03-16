function SURF_method(original_img_gray, disorted_img, tform_type,variable,str,i)
 %  Detect matching features between the original and distorted image
    
    % 1) Detect SURF features in original and rotated image
    ptsOriginal  = detectSURFFeatures(original_img_gray);
    ptsDistorted = detectSURFFeatures(disorted_img);

    % 2) Extract features in both images with the SURF features detected
    % (possible that not all of the original points were used to extract
    % descriptors). Points might have been rejected if they were too close
    % to the image border. Therefore, the valid points are returned in 
    % addition to the feature descriptors (vpts)
    
    [f1,vpts1] = extractFeatures(original_img_gray,ptsOriginal,'Method','SURF');
    [f2,vpts2] = extractFeatures(disorted_img,ptsDistorted,'Method','SURF');
   

    % 3) Find candidate matches: Remeber! Two patches that match can indicate like features but might not be a correct match.
    indexPairs = matchFeatures(f1,f2) ;
    
    % 4) Find point locations from both images: retrieve the locations of the matched points
    matchedPoints1 = vpts1(indexPairs(:,1));
    matchedPoints2 = vpts2(indexPairs(:,2));

    % Display the candidate matches
    figure(1);
    subplot(2,2,i);
    showMatchedFeatures(original_img_gray,disorted_img,matchedPoints1,matchedPoints2);
    title(['Candidate matched points (',str,' = ', num2str(variable(i)),')'])
    sgtitle(['SURF Feature Detection and Feature Extraction method (',str,')'])


    % 5) RANSAC - Analyze the feature locations: remove the false matches
    % (If there are a sufficient number of valid matches, remove the false
    % matches). The transform type determine the accuracy. The greater the 
    % number of matched pairs of points, the greater the accuracy of the
    % estimated transformation. 
   
    
    [tform, inlierDistorted,inlierOriginal] = ...
        estimateGeometricTransform(matchedPoints2,...
            matchedPoints1,tform_type);
   
    %  Display matching points: inliers only
    figure(2)
    subplot(2,2,i)
    showMatchedFeatures(original_img_gray,disorted_img,inlierOriginal,inlierDistorted)
    title(['Matching points (',str,'=' ,num2str(variable(i)),')'])
    legend('ptsOriginal','ptsDistorted')
    sgtitle(['SURF Feature Detection and Feature Extraction method (',str,')'])

    % Verify the computed geometric transform: Apply the computed geometric transform to the distorted image.
    outputView = imref2d(size(original_img_gray));
    recovered  = imwarp(disorted_img,tform,'OutputView',outputView);
    
    % Display Original vs Recovered images 
    figure(3)
    subplot(2,2,i)
    imshowpair(original_img_gray,recovered,'montage')
    title(['Compare Original img vs Recovered img (',str, ' = ',num2str(variable(i)),')'])
    sgtitle(['SURF Feature Detection and Feature Extraction method (',str,')'])
    
end
