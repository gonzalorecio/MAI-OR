%% 
I1 = imread('images/landscape.jpeg');
I1 = rgb2gray(I1);
I2 = imresize(imrotate(I1,-20),1.2);

imshowpair(I1,I2,'montage')


%%
% corners1 = detectFASTFeatures(I1,'MinContrast',0.1);
% corners2 = detectFASTFeatures(I2,'MinContrast',0.1);
corners1 = detectSURFFeatures(I1);
corners2 = detectSURFFeatures(I2);
J = insertMarker(I1,corners1,'circle');
imshow(J)

%% 




%% For matlab goe 'fitgeotrans'

T = transform_image_to_original(I1,I2,corners1, corners2);
% imshowpair(T, 'montage');
% imshow(T)

