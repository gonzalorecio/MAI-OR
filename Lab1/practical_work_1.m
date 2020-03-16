%%%%%%%%%%%%%%%%%%%%% PRACTICAL WORK 1 %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Landmark detection and descriptors %%%%%%%%%%%%%

%%% Local Feature detection and extraction 
I = imread('circuit.tif');
imshow(I)


corners = detectFASTFeatures(I,'MinContrast',0.1);
J = insertMarker(I,corners,'circle');
imshow(J)


 
% Tutorials
openExample('vision/HowToUseLocalFeaturesExample')
openExample('vision/UseSURFFeaturesToFindCorrespondingPointsExample')

%% Task 1
%%%%%%%%%%%%%%%%%%%%%%%% Create a dataset  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

original = imread('buildings.jpeg');
figure;
imshow(original);



%% Task 2
%%%%%%%%%%%%%%%%% Apply image distorsions to the data set %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main functions: 


% resized images: 
numrows = 300
numcol = 300
disorted_img = imresize(original,[numrows numcol]);
imshow(disorted_img)

% ROTATION
theta = 30
disorted_img = imrotate(original,theta);
imshow(disorted_img)

% If the method is not rotation invariant will fins other key points. The
% idea is to find the method that is rotation invariant. The performance of
% matching without being roation invariant will be less robust. 

% PROJECTIONS: fitgeotrans (MATLAB FUNCTION)
fixedPoints = [41 41; 281 161]; movingPoints = [56 175; 324 160];
tform = fitgeotrans(movingPoints,fixedPoints,'NonreflectiveSimilarity')
Jregistered = imwarp(original,tform,'OutputView',imref2d(size(original))); 
figure 
imshowpair(original,Jregistered)

% BLURRING 
blur_img(original,10);

% INTENSITY & CONTRAST 
low_in = 0.5
high_in = 1
J = imadjust(original,[low_in high_in]);
figure
imshow(J);

%% Test and compare several pipelines 
% SURF (detection function and Description method)

% RESIZE images 

% We can resize image by number of columns and rows
%numrows = [250]
%numcol = [250]

size_dimensions= [0.7,0.9,1.3,1.5]
for i =1:4
    
    original_img = imread('buildings.jpeg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img = imresize(original_img_gray,size_dimensions(i));

    %  Detect matching features between the original and distorted image
    
    % 1) Detect SURF features in original and rotated image
    ptsOriginal  = detectSURFFeatures(original_img_gray);
    ptsDistorted = detectSURFFeatures(disorted_img);

    % 2) Extract features in both images with the SURF features detected
    % (possible that not all of the original points were used to extract
    % descriptors). Points might have been rejected if they were too close
    % to the image border. Therefore, the valid points are returned in 
    % addition to the feature descriptors (vpts)
    
    [f1,vpts1] = extractFeatures(original_img_gray,ptsOriginal);
    [f2,vpts2] = extractFeatures(disorted_img,ptsDistorted);
   

    % 3) Find candidate matches: Remeber! Two patches that match can indicate like features but might not be a correct match.
    indexPairs = matchFeatures(f1,f2) ;
    
    % 4) Find point locations from both images: retrieve the locations of the matched points
    matchedPoints1 = vpts1(indexPairs(:,1));
    matchedPoints2 = vpts2(indexPairs(:,2));

    % Display the candidate matches
    figure(1);
    subplot(2,2,i);
    showMatchedFeatures(original_img_gray,disorted_img,matchedPoints1,matchedPoints2);
    title(['Candidate matched points (Scale= ' num2str(size_dimensions(i)) ')'])
    sgtitle('SURF Feature Detection and Feature Extraction method (SCALAE)')
    


    % 5) RANSAC - Analyze the feature locations: remove the false matches
    % (If there are a sufficient number of valid matches, remove the false
    % matches). The transform type determine the accuracy. The greater the 
    % number of matched pairs of points, the greater the accuracy of the
    % estimated transformation. 
   
    % similarity: 2
    %tform_type = 'similarity'
    % affine : 3
    %tform_type = 'affine'
    % projective : 4
     tform_type = 'projective';
    
    [tform, inlierDistorted,inlierOriginal] = ...
        estimateGeometricTransform(matchedPoints1,...
            matchedPoints2,tform_type);
   
    %  Display matching points: inliers only
    figure(2)
    subplot(2,2,i)
    showMatchedFeatures(original_img_gray,disorted_img,inlierOriginal,inlierDistorted)
    title(['Matching points (' num2str(size_dimensions(i)) ')'])
    legend('ptsOriginal','ptsDistorted')
    sgtitle('SURF Feature Detection and Feature Extraction method (SCALE)')
    

    % Verify the computed geometric transform: Apply the computed geometric transform to the distorted image.
    outputView = imref2d(size(original_img_gray));
    recovered  = imwarp(disorted_img,tform,'OutputView',outputView);
    degrees = theta(i)
    
    % Display Original vs Recovered images
    figure(3)
    subplot(2,2,i)
    imshowpair(original_img_gray,recovered,'montage')
    title(['Compare Original img vs Recovered img (Size = ' num2str(size_dimensions(i)) ' degrees)'])
    sgtitle('SURF Feature Detection and Feature Extraction method (SCALE)')


end 
%% Test and compare several pipelines 
% SURF (detection function and Description method)

% ROTATION 
theta = [15,30,90,180]
for i =1:4
    
    original_img = imread('buildings.jpeg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img = imrotate(original_img_gray,theta(i));

    %  Detect matching features between the original and distorted image
    
    % 1) Detect SURF features in original and rotated image
    ptsOriginal  = detectSURFFeatures(original_img_gray);
    ptsDistorted = detectSURFFeatures(disorted_img);

    % 2) Extract features in both images with the SURF features detected
    % (possible that not all of the original points were used to extract
    % descriptors). Points might have been rejected if they were too close
    % to the image border. Therefore, the valid points are returned in 
    % addition to the feature descriptors (vpts)
    
    [f1,vpts1] = extractFeatures(original_img_gray,ptsOriginal);
    [f2,vpts2] = extractFeatures(disorted_img,ptsDistorted);
   

    % 3) Find candidate matches: Remeber! Two patches that match can indicate like features but might not be a correct match.
    indexPairs = matchFeatures(f1,f2) ;
    
    % 4) Find point locations from both images: retrieve the locations of the matched points
    matchedPoints1 = vpts1(indexPairs(:,1));
    matchedPoints2 = vpts2(indexPairs(:,2));

    % Display the candidate matches
    figure(1);
    subplot(2,2,i);
    showMatchedFeatures(original_img_gray,disorted_img,matchedPoints1,matchedPoints2);
    title(['Candidate matched points (Rotation= ' num2str(theta(i)) 'º)'])
    sgtitle('SURF Feature Detection and Feature Extraction method (ROTATION)')


    % 5) RANSAC - Analyze the feature locations: remove the false matches
    % (If there are a sufficient number of valid matches, remove the false
    % matches). The transform type determine the accuracy. The greater the 
    % number of matched pairs of points, the greater the accuracy of the
    % estimated transformation. 
   
    % similarity: 2
    %tform_type = 'similarity'
    % affine : 3
    %tform_type = 'affine'
    % projective : 4
     tform_type = 'projective';
    
    [tform, inlierDistorted,inlierOriginal] = ...
        estimateGeometricTransform(matchedPoints1,...
            matchedPoints2,tform_type);
   
    %  Display matching points: inliers only
    figure(2)
    subplot(2,2,i)
    showMatchedFeatures(original_img_gray,disorted_img,inlierOriginal,inlierDistorted)
    title(['Matching points (Rotation=' num2str(theta(i)) 'º)'])
    legend('ptsOriginal','ptsDistorted')
    sgtitle('SURF Feature Detection and Feature Extraction method (ROTATION)')

    % Verify the computed geometric transform: Apply the computed geometric transform to the distorted image.
    outputView = imref2d(size(original_img_gray));
    recovered  = imwarp(disorted_img,tform,'OutputView',outputView);
    degrees = theta(i)
    
    % Display Original vs Recovered images 
    figure(3)
    subplot(2,2,i)
    imshowpair(original_img_gray,recovered,'montage')
    title(['Compare Original img vs Recovered img (Rotation = ' num2str(theta(i)) 'º)'])
    sgtitle('SURF Feature Detection and Feature Extraction method (ROTATION)')


end 
