%%%%%%%%%%%%%%%%%%%%% PRACTICAL WORK 1 %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Landmark detection and descriptors %%%%%%%%%%%%%

%%
%%%%%%%%%%%%%%%%%%%%%%%% Create a dataset  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

original_img = imread('bacteria.jpg'); 
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
% - Projection

original_img = imread('bacteria.jpg'); 
original_img_gray = rgb2gray(original_img);
proj_4 = affine2d([1 0.2 0; 0 1 0; 0 0 1]);

disorted_img= imwarp(original_img_gray,proj_4);
figure
imshow(disorted_img)


%% Test and compare several pipelines 

%%%%%%%%%%%%% SURF (detection function and Description method) %%%%%%%%%%%%

% RESIZE images 

% We can resize image by number of columns and rows
%numrows = [250]
%numcol = [250]

size_dimensions= [0.7,0.9,1.3,1.5];

time = []; time_b =[];
kpoints1 = []; kpoints1_b = [];
kpoints2 = []; kpoints2_b = [];
matches_c = []; matches_b = []; 
matched_ratio_c = []; matched_ratio_b = [];
scale = [];
results_scale_blobs = [];
for i =1:4
    
    original_img = imread('bacteria.jpg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img = imresize(original_img_gray,size_dimensions(i));
    
    variable = size_dimensions
    str = 'scale';
    % Choose tform_type 
    % tform_type = 'similarity'
    % tform_type = 'affine'
    tform_type = 'projective';
    
    % SURF
    tic;
    [kp1,kp2,matched,ratio] = SURF_method(original_img_gray, disorted_img,tform_type,variable,str,i);
    timeElapsed = toc;
    
    % BRISK 
    tic;
    [kp1_b,kp2_b,matched_b,ratio_b] = BRISK_method(original_img_gray, disorted_img,tform_type,variable,str,i);
    timeElapsed_b = toc;
    
    scale = [scale size_dimensions(i)];
    
    time = [time timeElapsed];
    kpoints1 = [kpoints1 kp1];
    kpoints2 = [kpoints2 kp2];
    matches_c = [matches_c matched];
    matched_ratio_c = [matched_ratio_c ratio];
    
    time_b = [time_b timeElapsed_b];
    kpoints1_b = [kpoints1_b kp1_b];
    kpoints2_b = [kpoints2_b kp2_b];
    matches_b = [matches_b matched_b];
    matched_ratio_b = [matched_ratio_b ratio_b];
    
    field1 = 'Scale'; value1 = scale;
    field2 = 'time_SURF'; value2 = time;
    field3 = 'kp_Original_SURF'; value3 = kpoints1;
    field4 = 'kp_Disorted_SURF'; value4 = kpoints2;
    field5 = 'Matches_SURF'; value5 = matches_c;
    field6 = 'Matched_ratio_SURF'; value6 = matched_ratio_c
    
    field7 = 'time_BRISK'; value7 = time_b;
    field8 = 'kp_Original_BRISK'; value8 = kpoints1_b;
    field9 = 'kp_Disorted_BRISK'; value9 = kpoints2_b;
    field10 = 'Matches_BRISK'; value10 = matches_b;
    field11 = 'Matched_ratio_BRISK'; value11 = matched_ratio_b
    
    s = struct(field1, value1, field2, value2, field3, value3, field4, ...
        value4, field5, value5, field6, value6,field7,value7,field8,value8,...
        field9,value9,field10,value10,field11,value11);
    
    results_scale_blobs = [results_scale_blobs s];
    
    
    scale =[];
    time =[]; time_b =[];
    kpoints1 =[];  kpoints1_b =[];
    kpoints2=[]; kpoints2_b=[];
    matches_c =[]; matches_b =[];
    matched_ratio_c =[];matched_ratio_b =[];

    
end 
 
%%

% ROTATION 
time = []; time_b =[];
kpoints1 = []; kpoints1_b = [];
kpoints2 = []; kpoints2_b = [];
matches_c = []; matches_b = []; 
matched_ratio_c = []; matched_ratio_b = [];
rot = [];
results_rot_blobs = [];
theta = [15,30,90,180]
for i =1:4
    
    original_img = imread('bacteria.jpg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img = imrotate(original_img_gray,theta(i));
    
    variable = theta
    str = 'rotation'
    % Choose tform_type 
    % tform_type = 'similarity'
    % tform_type = 'affine'
    
    % SURF
     tform_type = 'projective';
    tic;
    [kp1,kp2,matched,ratio] = SURF_method(original_img_gray, disorted_img,tform_type,variable,str,i);
    timeElapsed = toc;
    
  
    % BRISK 
    tic;
    [kp1_b,kp2_b,matched_b,ratio_b] = BRISK_method(original_img_gray, disorted_img,tform_type,variable,str,i);
    timeElapsed_b = toc;
    
    
    rot = [rot theta(i)];
    
    time = [time timeElapsed];
    kpoints1 = [kpoints1 kp1];
    kpoints2 = [kpoints2 kp2];
    matches_c = [matches_c matched];
    matched_ratio_c = [matched_ratio_c ratio];
    
    
    time_b = [time_b timeElapsed_b];
    kpoints1_b = [kpoints1_b kp1_b];
    kpoints2_b = [kpoints2_b kp2_b];
    matches_b = [matches_b matched_b];
    matched_ratio_b = [matched_ratio_b ratio_b];
    
    field1 = 'Rotation'; value1 = rot;
    field2 = 'time_SURF'; value2 = time;
    field3 = 'kp_Original_SURF'; value3 = kpoints1;
    field4 = 'kp_Disorted_SURF'; value4 = kpoints2;
    field5 = 'Matches_SURF'; value5 = matches_c;
    field6 = 'Matched_ratio_SURF'; value6 = matched_ratio_c
    
    field7 = 'time_BRISK'; value7 = time_b;
    field8 = 'kp_Original_BRISK'; value8 = kpoints1_b;
    field9 = 'kp_Disorted_BRISK'; value9 = kpoints2_b;
    field10 = 'Matches_BRISK'; value10 = matches_b;
    field11 = 'Matched_ratio_BRISK'; value11 = matched_ratio_b
    
    s = struct(field1, value1, field2, value2, field3, value3, field4, ...
        value4, field5, value5, field6, value6,field7,value7,field8,value8,...
        field9,value9,field10,value10,field11,value11);
    
    results_rot_blobs = [results_rot_blobs s];
    
    rot =[];
    time =[]; time_b =[];
    kpoints1 =[];  kpoints1_b =[];
    kpoints2=[]; kpoints2_b=[];
    matches_c =[]; matches_b =[];
    matched_ratio_c =[];matched_ratio_b =[];
    
    
   
end 
%%

% BLURRING
time = []; time_b =[];
kpoints1 = []; kpoints1_b = [];
kpoints2 = []; kpoints2_b = [];
matches_c = []; matches_b = []; 
matched_ratio_c = []; matched_ratio_b = [];

window = [];
results_blur_blobs = [];
windowWidth = [2,5,10,15]
for i =1:4
    
    original_img = imread('bacteria.jpg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img = blur_img(original_img_gray,windowWidth(i));
    
    variable = windowWidth
    str = 'blur'
    % Choose tform_type 
    % tform_type = 'similarity'
     tform_type = 'affine'
    % tform_type = 'projective';
    
    % SURF
    tic;
    [kp1,kp2,matched,ratio] = SURF_method(original_img_gray, disorted_img,tform_type,variable,str,i);
    timeElapsed = toc;
    
    % BRISK 
    tic;
    [kp1_b,kp2_b,matched_b,ratio_b] = BRISK_method(original_img_gray, disorted_img,tform_type,variable,str,i);
    timeElapsed_b = toc;
    
    window = [windowWidth(i)];
    
    time = [time timeElapsed];
    kpoints1 = [kpoints1 kp1];
    kpoints2 = [kpoints2 kp2];
    matches_c = [matches_c matched];
    matched_ratio_c = [matched_ratio_c ratio];
    
    
    time_b = [time_b timeElapsed_b];
    kpoints1_b = [kpoints1_b kp1_b];
    kpoints2_b = [kpoints2_b kp2_b];
    matches_b = [matches_b matched_b];
    matched_ratio_b = [matched_ratio_b ratio_b];
    
    field1 = 'window'; value1 = window;
    field2 = 'time_SURF'; value2 = time;
    field3 = 'kp_Original_SURF'; value3 = kpoints1;
    field4 = 'kp_Disorted_SURF'; value4 = kpoints2;
    field5 = 'Matches_SURF'; value5 = matches_c;
    field6 = 'Matched_ratio_SURF'; value6 = matched_ratio_c
    
    field7 = 'time_BRISK'; value7 = time_b;
    field8 = 'kp_Original_BRISK'; value8 = kpoints1_b;
    field9 = 'kp_Disorted_BRISK'; value9 = kpoints2_b;
    field10 = 'Matches_BRISK'; value10 = matches_b;
    field11 = 'Matched_ratio_BRISK'; value11 = matched_ratio_b
    
    s = struct(field1, value1, field2, value2, field3, value3, field4, ...
        value4, field5, value5, field6, value6,field7,value7,field8,value8,...
        field9,value9,field10,value10,field11,value11);
    
    results_blur_blobs =[results_blur_blobs s];
    
    window =[];
    time =[]; time_b =[];
    kpoints1 =[];  kpoints1_b =[];
    kpoints2=[]; kpoints2_b=[];
    matches_c =[]; matches_b =[];
    matched_ratio_c =[];matched_ratio_b =[];
    
   
end 

%%

% INTENSITY AND CONTRAST
time = []; time_b =[];
kpoints1 = []; kpoints1_b = [];
kpoints2 = []; kpoints2_b = [];
matches_c = []; matches_b = []; 
matched_ratio_c = []; matched_ratio_b = [];

low_in = [0.1,0.2,0.3,0.4];
high_in = [0.9,0.8,0.7,0.6];
combination = [1,2,3,4];
high = [];
low = [];
results_contrast_blobs = [];
for i =1:4
    
    original_img = imread('bacteria.jpg');
    original_img_gray = rgb2gray(original_img);
    disorted_img = imadjust(original_img_gray,[low_in(i) high_in(i)]);
    
    variable = combination;
    str = 'contrast combination';
    % Choose tform_type 
    % tform_type = 'similarity'
    % tform_type = 'affine'
    tform_type = 'projective';
    
    % SURF
    tic;
    [kp1,kp2,matched,ratio] = SURF_method(original_img_gray, disorted_img,tform_type,variable,str,i);
    timeElapsed = toc;
    
    % BRISK 
    tic;
    [kp1_b,kp2_b,matched_b,ratio_b] = BRISK_method(original_img_gray, disorted_img,tform_type,variable,str,i);
    timeElapsed_b = toc;
    
    low = [low low_in(i)];
    high = [high high_in(i)];
    
    time = [time timeElapsed];
    kpoints1 = [kpoints1 kp1];
    kpoints2 = [kpoints2 kp2];
    matches_c = [matches_c matched];
    matched_ratio_c = [matched_ratio_c ratio];
    
    time_b = [time_b timeElapsed_b];
    kpoints1_b = [kpoints1_b kp1_b];
    kpoints2_b = [kpoints2_b kp2_b];
    matches_b = [matches_b matched_b];
    matched_ratio_b = [matched_ratio_b ratio_b];
    
    field1 = 'low'; value1 = low;
    field2 = 'high' ;value2 = high;
    field3 = 'time_SURF'; value3 = time;
    field4 = 'kp_Original_SURF'; value4 = kpoints1;
    field5 = 'kp_Disorted_SURF'; value5 = kpoints2;
    field6 = 'Matches_SURF'; value6 = matches_c;
    field7 = 'Matched_ratio_SURF'; value7 = matched_ratio_c;
    
    field8 = 'time_BRISK'; value8 = time_b;
    field9 = 'kp_Original_BRISK'; value9 = kpoints1_b;
    field10 = 'kp_Disorted_BRISK'; value10 = kpoints2_b;
    field11 = 'Matches_BRISK'; value11 = matches_b;
    field12 = 'Matched_ratio_BRISK'; value12 = matched_ratio_b;
    
    s = struct(field1, value1, field2, value2, field3, value3, field4, ...
        value4, field5, value5, field6, value6,field7,value7,field8,value8,...
        field9,value9,field10,value10,field11,value11,field12,value12);
    
    results_contrast_blobs =[results_contrast_blobs s];
    
    low =[]; high =[];
    time =[]; time_b =[];
    kpoints1 =[];  kpoints1_b =[];
    kpoints2=[]; kpoints2_b=[];
    matches_c =[]; matches_b =[];
    matched_ratio_c =[];matched_ratio_b =[];
    
   
end 
%%

% PROJECTION 
proj_1 = affine2d([1.5 0 0;-0.5 1 0; 0 0 1]);
proj_2 = affine2d([2 0.33 0; 0 1 0; 0 0 1]);
proj_3 = affine2d([0.7 0.5 0; -0.5 1 0; 0 0 1]);
proj_4 = affine2d([1 0.2 0; 0 1 0; 0 0 1]);
projections = [proj_1,proj_2,proj_3,proj_4];
projection_type = [1,2,3,4];

time = []; time_b =[];
kpoints1 = []; kpoints1_b = [];
kpoints2 = []; kpoints2_b = [];
matches_c = []; matches_b = []; 
matched_ratio_c = []; matched_ratio_b = [];

proj = [];
results_3D_blobs = [];

for i = 1:4
    tform = affine2d([1.5 0 0;-0.5 1 0; 0 0 1])
    original_img = imread('bacteria.jpg'); 
    original_img_gray = rgb2gray(original_img);
    disorted_img= imwarp(original_img_gray,projections(i));
    
    variable = projection_type;
    str = 'projection type';
    % Choose tform_type 
     tform_type = 'similarity'
    % tform_type = 'affine'
    % tform_type = 'projective';
    
     % SURF
    tic;
    [kp1,kp2,matched,ratio] = SURF_method(original_img_gray, disorted_img,tform_type,variable,str,i);
    timeElapsed = toc;
    
    % BRISK 
    tic;
    [kp1_b,kp2_b,matched_b,ratio_b] = BRISK_method(original_img_gray, disorted_img,tform_type,variable,str,i);
    timeElapsed_b = toc;
    
    proj = [proj projection_type(i)];
    
    time = [time timeElapsed];
    kpoints1 = [kpoints1 kp1];
    kpoints2 = [kpoints2 kp2];
    matches_c = [matches_c matched];
    matched_ratio_c = [matched_ratio_c ratio];
    
    
    time_b = [time_b timeElapsed_b];
    kpoints1_b = [kpoints1_b kp1_b];
    kpoints2_b = [kpoints2_b kp2_b];
    matches_b = [matches_b matched_b];
    matched_ratio_b = [matched_ratio_b ratio_b];
    
    field1 = 'Proj_type'; value1 = proj;
    field2 = 'time_SURF'; value2 = time;
    field3 = 'kp_Original_SURF'; value3 = kpoints1;
    field4 = 'kp_Disorted_SURF'; value4 = kpoints2;
    field5 = 'Matches_SURF'; value5 = matches_c;
    field6 = 'Matched_ratio_SURF'; value6 = matched_ratio_c
    
    field7 = 'time_BRISK'; value7 = time_b;
    field8 = 'kp_Original_BRISK'; value8 = kpoints1_b;
    field9 = 'kp_Disorted_BRISK'; value9 = kpoints2_b;
    field10 = 'Matches_BRISK'; value10 = matches_b;
    field11 = 'Matched_ratio_BRISK'; value11 = matched_ratio_b
    
    s = struct(field1, value1, field2, value2, field3, value3, field4, ...
        value4, field5, value5, field6, value6,field7,value7,field8,value8,...
        field9,value9,field10,value10,field11,value11);
    
    results_3D_blobs = [results_3D_blobs s];
    
    proj =[];
    time =[]; time_b =[];
    kpoints1 =[];  kpoints1_b =[];
    kpoints2=[]; kpoints2_b=[];
    matches_c =[]; matches_b =[];
    matched_ratio_c =[];matched_ratio_b =[];

end
