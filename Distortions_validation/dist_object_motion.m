function y = dist_object_motion()

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

outputHead = 'object_blur';
% Uncomment Parameters for motion blur %%
lens = [3 6 9 12 15 18 21 24 27 30];
angles = 45;

for k = 1:10
%% Commented list of the distortion function to copy into the loop and
%nuncomment the corresponding variables above

objects = cell(size_mat,1);
    for i=3758:size_mat  
        if(i~=1433 || i~=3757)
            % Display the progress of the process i: images and k: distortion
        % level
            a=[i k]
            name = data{1,i}.imageName;
            bboxe = data{1,i}.bbox;
            label = data{1,i}.label;
            mask = data{1, i}.masks;
            size_label=size(label);
            len=zeros(size_label(1),1);
            angle=zeros(size_label(1),1);
            for j=1:size_label(1)
                    angle(j,1)=angles;
                    len(j,1)=lens(k);
            end
            myImages= imread(fullfile(Imgsrc{1,choice}, name));
        % Past here the desired distortion function as:
            distortion_object_blur(myImages,name,mask,bboxe,len,angle,outputFolder,outputHead);  
        end
        
    end

end
