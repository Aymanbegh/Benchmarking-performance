%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to increase the contrast to an image source
%% Copyright (c) 2021, AYMAN BEGHDADI
%% All rights reserved.
%% Author: Ayman Beghdadi
%% Email: aymanaymar.beghdadi@univ-evry.fr
%% Date: September 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function parameters:
% imgin: Original image.
% name_in: name of the new distorted image.
% contrast: Contrast value to apply.
% outputFolder: directory where are writted the new distorted image.

%% Function distortion_contraste that performs a global contrast increase  	

function imG_out = distortion_contraste(imgin,name_in,contraste,outputFolder,outputHead)

%% Creation of outuput directories and output name variables
if ~exist(fullfile(outputFolder,outputHead), 'dir')
  mkdir(outputFolder,outputHead)
end
output= [outputFolder '/' outputHead];
outputFolder = [output,'/'];

outputnames = sprintf('/%f_%f',contraste(1),contraste(2));

if ~exist(fullfile(outputFolder,outputnames), 'dir')
  mkdir(outputFolder,outputnames)
end
output= [outputFolder outputnames];
outputFolder = [output,'/'];

imG_out =imadjust(imgin,contraste,[]);

%% Contrast augmentation
outputname = sprintf('%s',name_in);
imwrite(imG_out, [outputFolder outputname]);

end