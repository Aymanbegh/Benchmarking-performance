%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to add noise to an image source
%% Copyright (c) 2021, AYMAN BEGHDADI
%% All rights reserved.
%% Author: Ayman Beghdadi
%% Email: aymanaymar.beghdadi@univ-evry.fr
%% Date: September 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function parameters:
% imgin: Original image.
% name: name of the new distorted image.
% mean: Mean of Gaussian noise, specified as a numeric scalar.
% variance: Variance of Gaussian noise, specified as a numeric scalar.
% outputFolder: directory where are writted the new distorted image.

%% Function distortion_noise that adds a gaussian noise to image

function imG_out = distortion_noise(imgin,name,mean,variance,outputFolder,outputHead)

%% Creation of outuput directories and output name variables
if ~exist(fullfile(outputFolder,outputHead), 'dir')
  mkdir(outputFolder,outputHead)
end
output= [outputFolder '/' outputHead];
outputFolder = [output,'/'];

outputnames = sprintf('/%f',variance);
if ~exist(fullfile(outputFolder,outputnames), 'dir')
  mkdir(outputFolder,outputnames)
end
output= [outputFolder outputnames];
outputFolder = [output,'/'];

%%% GAUSSIAN NOISE %%%
%% Create gaussian noise for the original image %%
    obj = imgin;
    obj(:,:,:)  = imnoise(obj(:,:,:),'gaussian',mean,variance);   % Add gaussian noise
    
    imG = double(obj(:,:,:));
    imG_out(:,:,:) = (imG - min(imG(:))) ./ max(imG(:));
    outputname = sprintf('%s',name);
    imwrite(imG_out, [outputFolder outputname]);

end