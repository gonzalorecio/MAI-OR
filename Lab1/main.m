%% 
I1 = imread('images/landscape.jpeg');
I1 = rgb2gray(I1);
I2 = imresize(imrotate(I1,-20),1.2);

imshowpair(I1,I2,'montage')


%%
% corners1 = detectFASTFeatures(I1,'MinContrast',0.1);
% corners2 = detectFASTFeatures(I2,'MinContrast',0.1);
pts1 = detectSURFFeatures(I1);
pts2 = detectSURFFeatures(I2);
J = insertMarker(I1,corners1,'circle');
imshow(J)


%%
[featuresOriginal, validPtsOriginal]  = extractFeatures(I1, keypoints1);
[featuresDistorted,validPtsDistorted] = extractFeatures(I2, keypoints2);

indexPairs = matchFeatures(featuresOriginal,featuresDistorted);


%% For matlab goe 'fitgeotrans'

T = transform_image_to_original(I1, I2, pts1, pts2);
% imshowpair(T, 'montage');
% imshow(T)

%% Example with affine transformation

A = imread('pout.tif');
tform = affine2d([1.5 0 0; -0.5 1 0; 0 0 1]);
B = imwarp(I,tform);
figure 
imshow(B);
