function y = dist_compression(imgval_path,path_annotation,outputFolder)
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
% imgval_path='C:\Users\beghd\OneDrive\Bureau\Dataset\COCO\val2017';

%Add path
addpath(imgval_path);


%% Create the distortion directories

% Specified the path to your annotations files from train, val, or test
% folders
% path_annotation =('C:\Users\beghd\OneDrive\Bureau\Dataset\COCO\annotations_unpacked_valfull2017\matFiles');
addpath(path_annotation);
path_dir  = [path_annotation,'/*.mat'];
%% Extract image to use
useAnnotation = true;
if (useAnnotation == true)
    mat = dir(path_dir);
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

% outputFolder=('C:\Users\beghd\OneDrive\Bureau\Dataset\COCO\val2017_d/');
addpath(outputFolder);

outputHead = 'compression';
%% Define all parameters for the various distortion functions (excepted name
% ,imgin and outputFolder)



%% Commented list of the distortion function to copy into the loop and
%nuncomment the corresponding variables above 

compression = [5 15 25 35 45 55 65 75 85 95];

for j =1:10
    for i=1:size_mat
        % Display the progress of the process i: images and j: distortion
        % level
        a=[i j]
        name = data{1,i}.imageName;
        bboxe = data{1,i}.bbox;
        label = data{1,i}.label;
        mask = data{1, i}.masks;

        myImages= imread(fullfile(Imgsrc{1,choice}, name));
    % Past here the desired distortion function as:
        distortion_compression(myImages,name,compression(j),outputFolder,outputHead);   
    end

end
