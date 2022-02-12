%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Main function to use distortion functions
%% Copyright (c) 2021, AYMAN BEGHDADI
%% All rights reserved.
%% Author: Ayman Beghdadi
%% Email: aymanaymar.beghdadi@univ-evry.fr
%% Date: September 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function main_distortion:
% Call the different functions to generate distortions on the train set of
% the MS-COCO 2017 dataset
% 

clear all;
clc;
addpath('./Distortions functions');
%% Path declarations for COCO dataset

% Dataset image for the training
imgtrain_path='C:\Users\aymanaymar.beghdadi\Desktop\Dataset\COCO\train2017\train2017';

%Add path
addpath(imgtrain_path);

%% Path declaration for the output distortion directory
% Dataset of the distorted image for the training
imgtrain_dist='D:\train2017_d';

% Add path
addpath(imgtrain_dist);

%% Create the distortion directories

% Specified the path to your annotations files from train, val, or test
% folders
path_annotation =('C:\Users\aymanaymar.beghdadi\Desktop\Dataset\COCO\annotations_unpacked_17\matFiles');
addpath(path_annotation);

hazeFolder=('C:\Users\aymanaymar.beghdadi\Desktop\Distortions\video extraction\fog1/');
addpath(hazeFolder);
rainFolder=('C:\Users\aymanaymar.beghdadi\Desktop\Distortions\video extraction\rain6/');
addpath(rainFolder);

%% Extract image to use
mat = dir('C:\Users\aymanaymar.beghdadi\Desktop\Dataset\COCO\annotations_unpacked_17\matFiles/*.mat');
outputFolder=('D:\train2017_d/');
    addpath(outputFolder);

% breaks down annotation extraction into 6 steps to not overload MATLAB capabilities
for iter=1:6
    
    if iter ==1
        size_mat=20000;
        data=cell(1,size_mat);
        for q = 1:20000, data{q} = load(mat(q).name); end
    end
    if iter ==2
        size_mat=20000;
        data=cell(1,size_mat);
        for q = 20001:40000, data{q-20000} = load(mat(q).name); end
    end
    if iter ==3
        size_mat=20000;
        data=cell(1,size_mat);
        for q = 40001:60000, data{q-40000} = load(mat(q).name); end
    end
    if iter ==4
        size_mat=20000;
        data=cell(1,size_mat);
        for q = 60001:80000, data{q-60000} = load(mat(q).name); end
    end
    if iter ==5
        size_mat=20000;
        data=cell(1,size_mat);
        for q = 80001:100000, data{q-80000} = load(mat(q).name); end
    end
    if iter ==6
        size_mat=17266;
        data=cell(1,size_mat);
        for q = 100001:117266, data{q-100000} = load(mat(q).name); end
    end

    %% Dataset division
    % half of the images are distorted according to the 10 types while the rest are kept as such
    mat_sampling = round(size_mat*0.5);
    dist_sampling = round(mat_sampling/10);
    %% Choose and apply distortions
    %Select the image directory by using the variable choice
    img_natural =zeros(5,20000);
    img_natural1 =zeros(1,17266);
    %Choice:1 => image train, Choice:2 => image val, etc... 
    Imgsrc={imgtrain_path};
    choice=1;

    

    %% Define all parameters for the various distortion functions (excepted name
    % ,imgin and outputFolder)

    contraste = [0.3 0.7;0.2 0.8;0.2 1.0;0.3 0.8;0.2 0.9; 0.3 0.9;...
        0.3 1.0;0.35 0.9;0.35 1.0;0.4 0.9];


    %% Commented list of the distortion function to copy into the loop and
    mat_tab = zeros(size_mat,2);
    cpt = 0;
    cpt1 = 0;
    cpt_noise = 0;
    cpt_blur = 0;
    cpt_defocus = 0;
    cpt_object_defocus = 0;
    cpt_object_blur = 0;
    cpt_object_illum = 0;
    cpt_haze = 0;
    cpt_rain = 0;
    cpt_contrast = 0;
    cpt_compression = 0;
    sum = 10;
    cptc=0;
    cptc1=0;
    cpth =0;
    cptn=0;
    cptr =0;
    cptb =0;
    cptd =0;
    cptoi =0;
    cptod=0;
    cptob =0;
    
    % Assigns randomly the distortion type for images
    while cpt < mat_sampling-4
        a = [1 2 3 4 5 6 7 8 9 10];
        i = randi([1 size_mat],1);
        if(mat_tab(i,1)==0)
            if(cpt_compression == dist_sampling)
                cptc =1;
                a([10])=[];
            end
            if(cpt_contrast == dist_sampling)
                cptc1 =1;
                a([9])=[];
            end
            if(cpt_rain == dist_sampling)
                cptr =1;
                a([8])=[];
            end
            if(cpt_haze == dist_sampling)
                cpth =1;
                a([7])=[];
            end
            if(cpt_object_illum == dist_sampling)
                cptoi =1;
                a([6])=[];
            end
            if(cpt_object_blur == dist_sampling)
                cptob =1;
                a([5])=[];
            end
            if(cpt_object_defocus == dist_sampling)
                cptod =1;
                a([4])=[];
            end
            if(cpt_defocus == dist_sampling)
                cptd =1;
                a([3])=[];
            end
            if(cpt_blur == dist_sampling)
                cptb =1;
                a([2])=[];
            end
            if(cpt_noise == dist_sampling)
                cptn =1;
                a([1])=[];
            end
            cpt1 = cptc+cptc1+cpth+cptn+cptr+cptb+cptd+cptoi+cptod+cptob;
            sum = sum -cpt1;
            if sum >=2
                val =randi([1 sum],1);
            else
                val =1;
            end
            if(isempty(a)==1)
                re=1;
            end
            j=a(val);
            if j == 1
                cpt_noise = cpt_noise+1;
            elseif j == 2
                cpt_blur=cpt_blur+1;
            elseif j ==3
                cpt_defocus = cpt_defocus+1;
            elseif j == 4
                cpt_object_defocus=cpt_object_defocus +1;
            elseif j == 5
                cpt_object_blur = cpt_object_blur+1;
            elseif j == 6
                cpt_object_illum = cpt_object_illum +1;
            elseif j == 7
                cpt_haze = cpt_haze+1;
            elseif j == 8
                cpt_rain = cpt_rain+1;
            elseif j == 9
                cpt_contrast = cpt_contrast+1;
            elseif j == 10
                cpt_compression =cpt_compression+1;        
            end

            mat_tab(i,2)= j;
            mat_tab(i,1)= 1;
            cpt = cpt + 1;     
        end
    end

    
    for i=1:size_mat
        % Display the current image that is processed 
        current = i 
        name = data{1,i}.imageName;
        bboxe = data{1,i}.bbox;
        label = data{1,i}.label;
        mask = data{1, i}.masks;
        myImages= imread(fullfile(Imgsrc{1,choice}, name));
        % Check if the current image must distorted according to the
        % previous random assignation
        if mat_tab(i,1)== 1
            % Display the distortion type to apply
            modes = [i mat_tab(i,2)]
            if mat_tab(i,2)== 1
                mean = 0;
                variance = randi([1 20],1)*0.001;
                data{1, i}.parameters = [mean variance];
                distortion_noise(myImages,name,mean,variance,outputFolder);       
            end

            if mat_tab(i,2)== 2
                angle = 45;
                len = randi([1 15],1);
                data{1, i}.parameters = [angle len];
                distortion_motion_blur(myImages,name,len,angle,outputFolder);
            end

            if mat_tab(i,2)== 3
                gaussian_size = 9;
                gaussian_sigma = randi([1 20],1)*0.1;
                data{1, i}.parameters = [gaussian_size gaussian_sigma];
                distortion_defocus_blur(myImages,name,gaussian_size,gaussian_sigma,outputFolder);
            end

            if mat_tab(i,2)== 4
                gaussian_size = 9;
                gaussian_sigma = randi([1 20],1)*0.1;
                data{1, i}.parameters = [gaussian_size gaussian_sigma];
                distortion_object_defocus(myImages,name,mask,gaussian_size,gaussian_sigma,outputFolder);
            end

            if mat_tab(i,2)== 5
                size_label=size(label);
                len=zeros(size_label(1),1);
                angle=zeros(size_label(1),1);
                for j=1:size_label(1)  
                    angle(j,1)=randi([-40 40],1);
                    len(j,1)=round(randi([2 15],1));
                    if(len(j,1)==0)
                        len(j,1)= 4;
                    end  
                end
                data{1, i}.parameters = [len angle];
                distortion_object_blur(myImages,name,mask,bboxe,len,angle,outputFolder);
            end
            if mat_tab(i,2)== 6
                attenuation = randi([5 35],1)*0.01;
                data{1, i}.parameters = [attenuation -1];
                distortion_object_illumination(myImages,name,mask,attenuation,outputFolder);
            end
            if mat_tab(i,2)== 7
                alpha = randi([5 19],1)*0.1;
                data{1, i}.parameters = [alpha -1];
                nb_fog = randi([605 929],1);
                outputhaze = sprintf('fog_%d.jpg',nb_fog);
                Outputhazes =[hazeFolder outputhaze];
                fog = imread(Outputhazes);
                distortion_haze(myImages,name,fog,alpha,outputFolder);
            end
            if mat_tab(i,2)== 8
                alpha = randi([5 37],1)*0.1;
                data{1, i}.parameters = [alpha -1];
                nb_rain = randi([1 329],1);
                outputhaze = sprintf('rain_%d.jpg',nb_rain);
                Outputhazes =[rainFolder outputhaze];
                rain = imread(Outputhazes);
                distortion_rain(myImages,name,rain,alpha,outputFolder);
            end
            if mat_tab(i,2)== 9
                cn = randi([1 10],1);
                distortion_contrast(myImages,name,contraste(cn,:),outputFolder);  
            end

            if mat_tab(i,2)== 10
                compression = randi([20 65],1);
                distortion_compression(myImages,name,compression,outputFolder);  
            end

        else     
            imwrite(myImages,[outputFolder name]);
            if iter==6
                img_natural1(iter,i)=1;
            else
                img_natural(iter,i)=1;
            end
        end

    end
end
save('dist_data.mat','img_natural','outputFolder');




