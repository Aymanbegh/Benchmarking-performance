%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to compress an original image through a compression factor
%% Copyright (c) 2021, AYMAN BEGHDADI
%% All rights reserved.
%% Author: Ayman Beghdadi
%% Email: aymanaymar.beghdadi@univ-evry.fr
%% Date: September 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function parameters:
% imgin: Original image.
% name_in: name of the new distorted image.
% compression: Compression factor to apply (between 1 and 100).
% outputFolder: directory where are writted the new distorted image.

%% Function distortion_compression that performs a compression of the input image  	

function imgin = distortion_compression(imgin,name_in,compression,outputFolder,outputHead)

%% Creation of outuput directories and output name variables
if ~exist(fullfile(outputFolder,outputHead), 'dir')
  mkdir(outputFolder,outputHead)
end
output= [outputFolder '/' outputHead];
outputFolder = [output,'/'];

outputnames = sprintf('/%f',compression);

if ~exist(fullfile(outputFolder,outputnames), 'dir')
  mkdir(outputFolder,outputnames)
end
output= [outputFolder outputnames];
outputFolder = [output,'/'];

%% Compression of input image
outputname = sprintf('%s',name_in);
imwrite(imgin, [outputFolder outputname],'jpg','Quality',compression);

end