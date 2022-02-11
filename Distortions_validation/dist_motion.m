function y = dist_motion()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Main function to call function the function to apply 
%% Copyright (c) 2021, AYMAN BEGHDADI
%% All rights reserved.
%% Author: Ayman Beghdadi
%% Email: aymanaymar.beghdadi@univ-evry.fr
%% Date: September 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function main_distortion:
% Call the different functions to perform distortions
% 


addpath('./Distortions functions');
%% Path declarations for COCO dataset
% Dataset image for the validation
imgval_path='C:\Users\beghd\OneDrive\Bureau\Dataset\COCO\val2017';

%Add path
addpath(imgval_path);

%% Path declaration for the distortion directories
% Dataset of the distorted image for the validation
imgval_dist='C:\Users\beghd\OneDrive\Bureau\Dataset\COCO/val2014/distortion';

% Add path
addpath(imgval_dist);

%% Create the distortion directories

% Specified the path to your annotations files from train, val, or test
% folders
path_annotation =('C:\Users\beghd\OneDrive\Bureau\Dataset\COCO\annotations_unpacked_valfull2017\matFiles');
addpath(path_annotation);

%% Extract image to use
useAnnotation = true;
if (useAnnotation == true)
    mat = dir('C:\Users\beghd\OneDrive\Bureau\Dataset\COCO\annotations_unpacked_valfull2017\matFiles/*.mat');
    size_mat=length(mat);
%     size_mat=round(size_mat);
    for q = 1:size_mat, data{q} = load(mat(q).name); end   
else
       
end

%% Choose and apply distortions
%Select the image directory by using the variable choice

%Choice:1 => image train, Choice:2 => image val, etc... 
Imgsrc={imgtrain_path,imgval_path,imgtest_path};
choice=2;

outputFolder=('C:\Users\beghd\OneDrive\Bureau\Dataset\COCO\val2017_d/');
addpath(outputFolder);

outputHead = 'blur_motion';

%% Commented list of the distortion function to copy into the loop and
%nuncomment the corresponding variables above 
lens = [2.5 5.0 7.5 10.0 12.5 15.0 17.5 20.0 22.5 25.0];

for j =1:10
    for i=1:size_mat
        % Display the progress of the process i: images and j: distortion
        % level
        a=[i j]
        name = data{1,i}.imageName;
        bboxe = data{1,i}.bbox;
        label = data{1,i}.label;
        mask = data{1, i}.masks;
        angle = 45;
        len = lens(j);
        myImages= imread(fullfile(Imgsrc{1,choice}, name));
        data{1, i}.parameters = [len, angle];
    % Past here the desired distortion function as:
        distortion_motion_blur(myImages,name,len,angle,outputFolder,outputHead)   
    end
end