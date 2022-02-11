%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to add uneven illumination to an image source
%% Copyright (c) 2021, AYMAN BEGHDADI
%% All rights reserved.
%% Author: Ayman Beghdadi
%% Email: aymanaymar.beghdadi@univ-evry.fr
%% Date: September 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function parameters:
% imgin: Original image.
% name_in: name of the new distorted image.
% area_factor: Radius of the unaffected area of ​​the image, specified as a numeric scalar.
% attenuation: Attenuation factor of the uneven illumination.
% outputFolder: directory where are writted the new distorted image.

%% Function distortion_illumination that performs a local drop in brightness  	

function imG_out = distortion_object_defocus(imgin,name_in,mask,gaussian_size,gaussian_sigma,outputFolder,outputHead)

if ~exist(fullfile(outputFolder,outputHead), 'dir')
  mkdir(outputFolder,outputHead)
end
output= [outputFolder '/' outputHead];
outputFolder = [output,'/'];

outputnames = sprintf('/%f',gaussian_sigma);
% outputnames = sprintf('/object_defocus');
if ~exist(fullfile(outputFolder,outputnames), 'dir')
  mkdir(outputFolder,outputnames)
end
output= [outputFolder outputnames];
outputFolder = [output,'/'];

%%% LOCAL DEFOCUS BLUR APPLICATION %%%
%% Create image to use as a mask for creating the output local defocus image %%
obj = imgin;
% Specified the Width and Height of the original image
% p1: modified image
% p: output image
WIDTH = size(obj,1);
HEIGHT = size(obj,2);
CHANEL=size(obj,3);
p = zeros(WIDTH,HEIGHT,CHANEL);
p1 = zeros(WIDTH,HEIGHT,CHANEL);
size_mask=size(mask,3);
% imG = uint8(obj(:,:,:));
p1(:,:,:) = imgaussfilt(obj(:,:,:),gaussian_sigma,'FilterSize',gaussian_size);
for k=1:size_mask
    for i=1:WIDTH
        for j=1:HEIGHT
            if mask(i,j,k)~=1
                if(k==1)
                    p(i,j,:) = obj(i,j,:);
                end
                    
            else
                p(i,j,:) = p1(i,j,:);
            end
            
        end
    end
    p(i,j,:)=p1(i,j,:);
end

imG_out = uint8(p);

outputname = sprintf('%s',name_in);
imwrite(imG_out, [outputFolder outputname]);

end