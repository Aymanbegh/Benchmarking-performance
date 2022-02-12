%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to add rain to an image source
%% Copyright (c) 2021, AYMAN BEGHDADI
%% All rights reserved.
%% Author: Ayman Beghdadi
%% Email: aymanaymar.beghdadi@univ-evry.fr
%% Date: September 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function parameters:
% imgin: Original image.
% name_in: name of the new distorted image.
% imrain: input image of the rain used as mask.
% alpha: Factor to apply at the mask.
% outputFolder: directory where are writted the new distorted image.

%% Function distortion_rain that performs a global disrtortion through an adding of synthetic rain  	

function imG_out = distortion_rain(imgin,name_in,imrain,alpha,outputFolder)

outputFolder = [outputFolder,'/'];
%%% SYNTHETIC RAIN APPLICATION %%%
%% Create image for use as mask for creating non-uniform illumination %%

% Specified the Width and Height of the original image
width = size(imgin,2);
height = size(imgin,1);
imrain1 = imresize(imrain,[height width]);

I = 1 - (1 - im2double(imgin)).*(1 - alpha*im2double(imrain1));
imG_out= im2uint8(I);


outputname = sprintf('%s',name_in);
imwrite(imG_out, [outputFolder outputname]);

end