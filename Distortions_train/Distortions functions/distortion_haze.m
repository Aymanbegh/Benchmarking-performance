%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to add a synthetic haze to an image source
%% Copyright (c) 2021, AYMAN BEGHDADI
%% All rights reserved.
%% Author: Ayman Beghdadi
%% Email: aymanaymar.beghdadi@univ-evry.fr
%% Date: September 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function parameters:
% imgin: Original image.
% name_in: name of the new distorted image.
% imhaze: input image of the haze used as mask.
% alpha: Factor to apply at the mask.
% outputFolder: directory where are writted the new distorted image.

%% Function distortion_haze that performs a global disrtortion through an adding of synthetic haze	

function imG_out = distortion_haze(imgin,name_in,imhaze,alpha,outputFolder)

outputFolder = [outputFolder,'/'];
%%% GLOBAL HAZE APPLICATION %%%
%% Create image to use as mask for creating a synthetic haze image %%

% Specified the Width and Height of the original image
width = size(imgin,2);
height = size(imgin,1);
imhaze1 = imresize(imhaze,[height width]);

I = 1 - (1 - im2double(imgin)).*(1 - alpha*im2double(imhaze1));
imG_out= im2uint8(I);


outputname = sprintf('%s',name_in);
imwrite(imG_out, [outputFolder outputname]);

end