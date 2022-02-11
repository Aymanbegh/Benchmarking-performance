%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Main script to call distortion functions 
%% Copyright (c) 2021, AYMAN BEGHDADI
%% All rights reserved.
%% Author: Ayman Beghdadi
%% Email: aymanaymar.beghdadi@univ-evry.fr
%% Date: September 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%% Paths to directories
%Path to validation set images from COCO 2017
imgval_path='C:\Users\beghd\OneDrive\Bureau\Dataset\COCO\val2017';
%Path to validation set annotations from COCO 2017
path_annotation =('C:\Users\beghd\OneDrive\Bureau\Dataset\COCO\annotations_unpacked_valfull2017\matFiles');
%Path to output directory where distortions are generated
outputFolder=('C:\Users\beghd\OneDrive\Bureau\Dataset\COCO\val2017_d1/');
%Path to the rain masks to apply for the rain distortion
rainFolder=('C:\Users\beghd\OneDrive\Bureau\Distortions\video extraction\rain5/');
%Path to the haze masks to apply for the haze distortion
hazeFolder=('C:\Users\beghd\OneDrive\Bureau\Distortions\video extraction\fog1/');

%% Call of functions
% dist_defocus(imgval_path,path_annotation,outputFolder);
% dist_haze(imgval_path,path_annotation,outputFolder,hazeFolder);
% dist_motion(imgval_path,path_annotation,outputFolder);
% dist_rain(imgval_path,path_annotation,outputFolder,rainFolder);
% dist_object_motion(imgval_path,path_annotation,outputFolder);
% dist_object_illum(imgval_path,path_annotation,outputFolder);
% dist_object_defocus(imgval_path,path_annotation,outputFolder);
% dist_compression(imgval_path,path_annotation,outputFolder);
% dist_contraste(imgval_path,path_annotation,outputFolder);
dist_noise(imgval_path,path_annotation,outputFolder);