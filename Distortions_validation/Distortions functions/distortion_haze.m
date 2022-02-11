%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to add haze to an image source
%% Copyright (c) 2021, AYMAN BEGHDADI
%% All rights reserved.
%% Author: Ayman Beghdadi
%% Email: aymanaymar.beghdadi@univ-evry.fr
%% Date: September 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function parameters:
% imgin: Original image.
% name_in: name of the new distorted image.
% imhaze: haze image applied to the original image.
% alpha: Factor of the haze mask.
% outputFolder: directory where are writted the new distorted image.

%% Function distortion_haze that performs a global application of a haze mask  	

function imG_out = distortion_haze(imgin,name_in,imhaze,alpha,outputFolder, outputHead)

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

%%% GLOBAL MASK HAZE %%%
%% Applies the haze mask on the input image (imgin)  %%

% Specified the Width and Height of the original image
width = size(imgin,2);
height = size(imgin,1);
imhaze1 = imresize(imhaze,[height width]);

I = 1 - (1 - im2double(imgin)).*(1 - alpha*im2double(imhaze1));
imG_out= im2uint8(I);


outputname = sprintf('%s',name_in);
imwrite(imG_out, [outputFolder outputname]);

end