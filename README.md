# Benchmarking-performance-of-object-detection-under-uncontrolled-environment

Here is an original strategy of image distortion generation applied to the MS-COCO dataset that combines some local and global distortions to reach a better realism. We have shown that training with this distorted dataset improves the robustness of models by 30% approximately.

Overview
-----------------------------------

We propose this full framework evaluation of robustness for a set of object detection methods (Mask-RCNN, EfficientDet, and YOLOv4) through several distortions applied on the MS-COCO dataset. This data augmentation is performed through some common global distortions (noise, motion blur, defocus blur, haze, rain, contrast change, and compression artefacts) in the whole image and some local distortions (object blur, backlight illumination BI and object defocus blur) in specific areas that include the possible dynamic objects or scene conditions.
The main contributions are:
- A new dataset dedicated to the study of the impact of local and global distortions on the robustness of object detection is built from the MS-COCO dataset (see Distorted dataset generation).
- A comprehensive evaluation of the robustness of the state-of-the-art object detection methods against global and local distortions at 10 levels of distortion (see Evaluation).
- An evaluation of the training with distorted images impact on the robustness of YOLOv4-tiny model against synthetic distortions (see Training).


Image Distortions
-----------------------------------

- **Global distortions**: affect the image as a whole and come from different sources related in general to the acquisition conditions. Some are directly dependent on the physical characteristics of the camera and are of photometric or geometric origin. Among the most common distortions that affect the quality of the signal are defocusing blur, photon noise, geometric or chromatic aberrations, and blur due to the movement of the camera or the movement of objects. The other types of degradation are related to the environment and more particularly the lighting and atmospheric disturbances in the case of outdoor scenes. Compression and image transmission artifacts are another source of degradation that is difficult to control. These common distortions have been already considered in benchmarking the performance of some models.
![image](https://user-images.githubusercontent.com/80038451/153573038-0f42a475-05d4-402e-9e8f-932b54e2919a.png)

- **Local distortions**: are undesirable signals affecting one or more localized areas in the image (see figure 1). A typical case is the blurring due to the movement of an object of relatively high speed. Another photometric distortion is the appearance of a halo around the object contours due to the limited sensitivity of the sensors or backlight illumination (BI). The artistic blur affecting a particular part of the targeted scene, the object to be highlighted by the pro-shooter, is another type of local distortion. Thus, integrating the local distortions in the database increases its size and makes it richer and more representative of scenarios close to real applications which improves the relevance of trained models.
![image](https://user-images.githubusercontent.com/80038451/153571907-c17dec87-0999-437a-bd00-92d6d3f730f8.png)

Requirements
-----------------------------------


Distorted dataset generation
-----------------------------------
Distortions are applied to 2 sets from the MS-COCO 2017 dataset: the train (118K images) and validation (5K images) sets
- **Train set**: we applied distortions through 5% of the contained images for each of the 10 distortion types (5.9K images per distortion type). The values of distortions have been randomly chosen in intervals specific to each distortion type. The functions to generate these distortions are structured as following:

    ```
  *Distortion_name*
  ├── annotations
      └──instances_*distortion_name*.json
  │── images
      └── ****.jpg
  ├── list.txt
  ```
  
- **Validation set**: We apply the 10 types of distortions on all images from the validation set of MS-COCO (5K images) through 10 distortion levels specified in each respective generation function ("distortion_*distortion_name*.m"). The values of distortions are giver directly in each specific distortion function ("dist_*distortion_name*.m"). All of these functions are in the following tree structure:

    ```
  Distortions_validation
  ├── Distortions functions
      └──distortion_*distortion_name*.m : function that generate the distortion specified by *distortion_name*
  ├── dist_*distortion_name*.m: functions that call each respective functions in the folder "Distortions functions" 
  ├── main.m: main script that calls all dist_*distortion_name*.m functions
  ```
Paths to directories from the main script need to be modified in order to indicate the correct paths for the image source, the annotations sources and the desired output directories.

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
    
To generate the desired distortion, comment or uncomment the lines of functions in the "main.m" script:

    %% Call of functions
    dist_defocus(imgval_path,path_annotation,outputFolder);
    dist_haze(imgval_path,path_annotation,outputFolder,hazeFolder);
    dist_motion(imgval_path,path_annotation,outputFolder);
    dist_rain(imgval_path,path_annotation,outputFolder,rainFolder);
    dist_object_motion(imgval_path,path_annotation,outputFolder);
    dist_object_illum(imgval_path,path_annotation,outputFolder);
    dist_object_defocus(imgval_path,path_annotation,outputFolder);
    dist_compression(imgval_path,path_annotation,outputFolder);
    dist_contraste(imgval_path,path_annotation,outputFolder);
    dist_noise(imgval_path,path_annotation,outputFolder);
    
The distorted images are  as the following tree structure:   

    ```
  outputFolder: path given in the main script that described the output folder
  ├── noise
      └── Level 1 of distortion (value)
      ...
      ...
      └── Level 10 of distortion (value)
  ├── Next distortion  
      └── Level 1 of distortion (value)
      ...
      ...
      └── Level 10 of distortion (value)
  ...    
  ```
    
    
Evaluation results
-----------------------------------


Training results
-----------------------------------

