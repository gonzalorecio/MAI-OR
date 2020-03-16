%%%%%%%%%%%%%%%%%%%%% PRACTICAL WORK 1 %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Landmark detection and descriptors %%%%%%%%%%%%%

%%
%%%%%%%%%%%%%%%%%%%%%%%% Create a dataset  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

original = imread('buildings.jpeg');
figure;
imshow(original);



%% Task 2
%%%%%%%%%%%%%%%%% Apply image distorsions to the data set %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main functions:
% - Scale
% - Rotation
% - Blur
% - Contrast 



%% Test and compare several pipelines 

%%%%%%%%%%%%% SURF (detection function and Description method) %%%%%%%%%%%%

% RESIZE images 

% We can resize image by number of columns and rows
%numrows = [250]
%numcol = [250]

size_dimensions= [0.7,0.9,1.3,1.5]
for i =1:4
    
    original_img = imread('buildings.jpeg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img = imresize(original_img_gray,size_dimensions(i));
    
    variable = size_dimensions
    str = 'scale'
    % Choose tform_type 
    % tform_type = 'similarity'
    % tform_type = 'affine'
    tform_type = 'projective';
    SURF_method(original_img_gray, disorted_img,tform_type,variable,str,i);
end 

 
%%

% ROTATION 
theta = [15,30,90,180]
for i =1:4
    
    original_img = imread('buildings.jpeg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img = imrotate(original_img_gray,theta(i));
    
    variable = theta
    str = 'rotation'
    % Choose tform_type 
    % tform_type = 'similarity'
    % tform_type = 'affine'
     tform_type = 'projective';
    SURF_method_2(original_img_gray, disorted_img,tform_type,variable,str,i);
   
end 
%%

% BLURRING
windowWidth = [2,5,10,15]
for i =1:4
    
    original_img = imread('buildings.jpeg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img = blur_img(original_img_gray,windowWidth(i));
    
    variable = windowWidth
    str = 'blur'
    % Choose tform_type 
    % tform_type = 'similarity'
     tform_type = 'affine'
    % tform_type = 'projective';
    SURF_method_2(original_img_gray, disorted_img,tform_type,variable,str,i);
   
end 

%%

% INTENSITY AND CONTRAST
low_in = [0.1,0.2,0.3,0.4];
high_in = [0.9,0.8,0.7,0.6];
combination = [1,2,3,4];
for i =1:4
    
    original_img = imread('buildings.jpeg');
    original_img_gray = rgb2gray(original_img);
    disorted_img = imadjust(original_img_gray,[low_in(i) high_in(i)]);
    
    variable = combination;
    str = 'contrast combination';
    % Choose tform_type 
    % tform_type = 'similarity'
    % tform_type = 'affine'
    tform_type = 'projective';
    SURF_method_2(original_img_gray, disorted_img,tform_type,variable,str,i);
   
end 

%%

% PROJECTION 
proj_1 = affine2d([1.5 0 0;-0.5 1 0; 0 0 1])
proj_2 = affine2d([2 0.33 0; 0 1 0; 0 0 1])
proj_3 = affine2d([0.7 0.5 0; -0.5 1 0; 0 0 1])
proj_4 = affine2d([1 0.2 0; 0 1 0; 0 0 1])
projections = [proj_1,proj_2,proj_3,proj_4]
projection_type = [1,2,3,4];

for i = 1:4
    tform = affine2d([1.5 0 0;-0.5 1 0; 0 0 1])
    original_img = imread('buildings.jpeg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img= imwarp(original_img_gray,projections(i));
    
    variable = projection_type;
    str = 'projection type';
    % Choose tform_type 
     tform_type = 'similarity'
    % tform_type = 'affine'
    % tform_type = 'projective';
    SURF_method(original_img_gray, disorted_img,tform_type,variable,str,i);

end



%% Test and compare several pipelines 
%%%%%%%%%%%%% BRSIK (detection function and Description method) %%%%%%%%%%%

% SCALE
size_dimensions= [0.7,0.9,1.3,1.5]
for i =1:4
    
    original_img = imread('buildings.jpeg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img = imresize(original_img_gray,size_dimensions(i));
    
    variable = size_dimensions
    str = 'scale'
    % Choose tform_type 
    tform_type = 'similarity'
    % tform_type = 'affine'
    % tform_type = 'projective';
    BRISK_method(original_img_gray, disorted_img,tform_type,variable,str,i);
end 

 
%%
% ROTATION 
theta = [15,30,90,180]
for i =1:4
    
    original_img = imread('buildings.jpeg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img = imrotate(original_img_gray,theta(i));
    
    variable = theta
    str = 'rotation'
    % Choose tform_type 
    % tform_type = 'similarity'
    % tform_type = 'affine'
     tform_type = 'projective';
    BRISK_method(original_img_gray, disorted_img,tform_type,variable,str,i);
   
end 

%%
% BLURRING
windowWidth = [2,5,10,15]
for i =1:4
    
    original_img = imread('buildings.jpeg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img = blur_img(original_img_gray,windowWidth(i));
    
    variable = windowWidth
    str = 'blur'
    % Choose tform_type 
    % tform_type = 'similarity'
     tform_type = 'affine'
    % tform_type = 'projective';
    BRISK_method(original_img_gray, disorted_img,tform_type,variable,str,i);
   
end 

%%

% INTENSITY AND CONTRAST
low_in = [0.1,0.2,0.3,0.4];
high_in = [0.9,0.8,0.7,0.6];
combination = [1,2,3,4];
for i =1:4
    
    original_img = imread('buildings.jpeg');
    original_img_gray = rgb2gray(original_img);
    disorted_img = imadjust(original_img_gray,[low_in(i) high_in(i)]);
    
    variable = combination;
    str = 'contrast combination';
    % Choose tform_type 
    % tform_type = 'similarity'
    % tform_type = 'affine'
    tform_type = 'projective';
    BRISK_method(original_img_gray, disorted_img,tform_type,variable,str,i);
   
end 
%%
% PROJECTION 
proj_1 = affine2d([1.5 0 0;-0.5 1 0; 0 0 1])
proj_2 = affine2d([2 0.33 0; 0 1 0; 0 0 1])
proj_3 = affine2d([0.7 0.5 0; -0.5 1 0; 0 0 1])
proj_4 = affine2d([1 0.2 0; 0 1 0; 0 0 1])
projections = [proj_1,proj_2,proj_3,proj_4]
projection_type = [1,2,3,4];

for i = 1:4
    tform = affine2d([1.5 0 0;-0.5 1 0; 0 0 1])
    original_img = imread('buildings.jpeg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img= imwarp(original_img_gray,projections(i));
    
    variable = projection_type;
    str = 'projection type';
    % Choose tform_type 
     tform_type = 'similarity'
    % tform_type = 'affine'
    % tform_type = 'projective';
    BRISK_method(original_img_gray, disorted_img,tform_type,variable,str,i);

end



