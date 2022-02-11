%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to add a rain mask to an image source
%% Copyright (c) 2021, AYMAN BEGHDADI
%% All rights reserved.
%% Author: Ayman Beghdadi
%% Email: aymanaymar.beghdadi@univ-evry.fr
%% Date: September 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function parameters:
% imgin: Original image.
% name_in: name of the new distorted image.
% imrain: Input rain mask image to apply.
% alpha: Factor of the rain mask to apply.
% outputFolder: directory where are writted the new distorted image.

%% Function distortion_rain that performs a global application of synthetic rain on a input image  	

function imG_out = distortion_rain(imgin,name_in,imrain,alpha,outputFolder, outputHead)

%% Creation of outuput directories and output name variables
if ~exist(fullfile(outputFolder,outputHead), 'dir')
  mkdir(outputFolder,outputHead)
end
output= [outputFolder '/' outputHead];
outputFolder = [output,'/'];

outputnames = sprintf('/%f',alpha);
if ~exist(fullfile(outputFolder,outputnames), 'dir')
  mkdir(outputFolder,outputnames)
end
output= [outputFolder outputnames];
outputFolder = [output,'/'];

%%% SYNTHETIC RAIN APPLICATION %%%
%% Create image to use as a mask for creating an output synthetic rain image %%

% Specified the Width and Height of the original image
width = size(imgin,2);
height = size(imgin,1);
imrain1 = imresize(imrain,[height width]);

I = 1 - (1 - im2double(imgin)).*(1 - alpha*im2double(imrain1));
imG_out= im2uint8(I);


outputname = sprintf('%s',name_in);
imwrite(imG_out, [outputFolder outputname]);

end