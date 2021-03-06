# Benchmarking-performance-of-object-detection-under-images-distortions-of-an-uncontrolled-environment

Here is an original strategy of image distortion generation applied to the MS-COCO dataset that combines some local and global distortions to reach a better realism. We have shown that training with this distorted dataset improves the robustness of models by 31.5% approximately through this full framework evaluation and training. This repository is summarized as follow:
- [Overview](https://github.com/Aymanbegh/Benchmarking-performance#overview): brief presentation of this framework evaluation of robustness
- [Image Distortions](https://github.com/Aymanbegh/Benchmarking-performance#image-distortions): presents the main concept about image distortion
- [Requirements](https://github.com/Aymanbegh/Benchmarking-performance#requirements): gives global dependencies information and links
- [Distorted dataset generation](https://github.com/Aymanbegh/Benchmarking-performance#distorted-dataset-generation): provides a tutorial about the distorted dataset generation
- [Evaluation protocols](https://github.com/Aymanbegh/Benchmarking-performance#evaluation-protocols): explains the evaluation protocol and how to launch it for each models (Mask-RCNN, EfficientDet and YOLOv4) 
- [Evaluation results](https://github.com/Aymanbegh/Benchmarking-performance#evaluation-results): shows results of ours evaluations
- [Training results](https://github.com/Aymanbegh/Benchmarking-performance#training-results): explains how to perform a training through YOLOv4 method (YOLOv4 or YOLOv4-tiny) and how to evaluate the robustness of the trained model.
- [Citation](https://github.com/Aymanbegh/Benchmarking-performance#citation): BibTeX to cite this repository and the corresponding paper

**Codes of evaluation and training tasks are fully provided as well as distorted dataset.**


Overview
-----------------------------------

We propose this full framework evaluation of robustness for a set of object detection methods (**Mask-RCNN, EfficientDet, and YOLOv4**) through several distortions applied on the MS-COCO dataset. This data augmentation is performed through some common global distortions (noise, motion blur, defocus blur, haze, rain, contrast change, and compression artefacts) in the whole image and some local distortions (object blur, backlight illumination BI and object defocus blur) in specific areas that include the possible dynamic objects or scene conditions.
The main contributions are:
- A new dataset dedicated to the study of the impact of local and global distortions on the robustness of object detection is built from the MS-COCO dataset (see **Distorted dataset generation** section).
- A comprehensive evaluation of the robustness of the state-of-the-art object detection methods against global and local distortions at 10 levels of distortion (see **Evaluation** section).
- An evaluation of the training with distorted images impact on the robustness of YOLOv4-tiny model against synthetic distortions (see **Training** section).


Image Distortions
-----------------------------------

- **Global distortions**: affect the image as a whole and come from different sources related in general to the acquisition conditions. Some are directly dependent on the physical characteristics of the camera and are of photometric or geometric origin. Among the most common distortions that affect the quality of the signal are defocusing blur, photon noise, geometric or chromatic aberrations, and blur due to the movement of the camera or the movement of objects. The other types of degradation are related to the environment and more particularly the lighting and atmospheric disturbances in the case of outdoor scenes. Compression and image transmission artifacts are another source of degradation that is difficult to control. These common distortions have been already considered in benchmarking the performance of some models.
![image](https://user-images.githubusercontent.com/80038451/153573038-0f42a475-05d4-402e-9e8f-932b54e2919a.png)

- **Local distortions**: are undesirable signals affecting one or more localized areas in the image (see figure 1). A typical case is the blurring due to the movement of an object of relatively high speed. Another photometric distortion is the appearance of a halo around the object contours due to the limited sensitivity of the sensors or backlight illumination (BI). The artistic blur affecting a particular part of the targeted scene, the object to be highlighted by the pro-shooter, is another type of local distortion. Thus, integrating the local distortions in the database increases its size and makes it richer and more representative of scenarios close to real applications which improves the relevance of trained models.
![image](https://user-images.githubusercontent.com/80038451/153571907-c17dec87-0999-437a-bd00-92d6d3f730f8.png)

Requirements
-----------------------------------
- **MATLAB R2021a**
- **Python (tested with Pyhton 3.8)**
- **MS-COCO dataset: validation and train sets (corresponding images and instances annotations)**
    - https://cocodataset.org/#download  
- **Instances annotations converted in a Matlab matrix:**
    - **(train set):** https://drive.google.com/file/d/1vduixQEHJxMvdU0kaJ8GtiLkeqPE7i2L/view?usp=sharing
    - **(validation set):** https://drive.google.com/file/d/1yqHBH7kJfBWh7uG_r40P507wYWXdnjOy/view?usp=sharing
    - **(validation set MS-COCO 2014 for MASK-RCNN):** https://drive.google.com/file/d/1yqHBH7kJfBWh7uG_r40P507wYWXdnjOy/view?usp=sharing
- **Generated distorted datasets (if you dont want to generate them yourself):**
    - **(train set):** https://drive.google.com/file/d/1-oNNJUwfXOlM222g84t6ZM2U5GmbkUoo/view?usp=sharing
    - **(validation set): 3 links for MS-COCO 2017**
        - part1 (Blur, Compression, Contrast, Defocus): https://drive.google.com/file/d/1EsljL-cN-DpUKmn9w02WbkJiFta4aDBB/view?usp=sharing
        - part2 (Noise): https://drive.google.com/file/d/1VBy1i37uCLYl3Ew5p2Qu0PVGck8f3r8s/view?usp=sharing
        - part3 (others): https://drive.google.com/file/d/1V6_5vXR5vnfMhyhspOW4lM75cAKh2Vk-/view?usp=sharing
    - **(validation set 2014): MS-COCO 2014 for Mask-RCNN**
        - Link: https://drive.google.com/file/d/1aCWSAA0fA1jb6-5LFlin45tm1N7A53Ai/view?usp=sharing
- **Requirements for the models to evaluate**
- **YOLOv4-tiny pre-trained:**
    - Trained on original COCO dataset: https://drive.google.com/drive/folders/10s4mmJ1rkWGwrhveU92-h3cb03wA0VfD?usp=sharing
    - Trained on distorted COCO Dataset: https://drive.google.com/drive/folders/18anC53sr_SkDl7qMPn9iWcM3ub1p6d1D?usp=sharing

Distorted dataset generation
-----------------------------------
Distortions are applied to 2 sets from the MS-COCO 2017 dataset => train (118K images) and validation (5K images) sets. 
**You generate yourself your COCO distorted dataset for the train and evaluation sets thanks to the following functions. Otherwise, you can download directly download our distorted dataset: (train set: GB) and (validation set: GB)**
- **Validation set**: We apply the 10 types of distortions on all images from the validation set of MS-COCO (5K images) through 10 distortion levels specified in each respective generation function ("distortion_*distortion_name*.m"). The values of distortions are giver directly in each specific distortion function ("dist_*distortion_name*.m"). All of these functions, present in the **Distortions_validation** folder, are in the following tree structure:

    ```
  Distortions_validation
  ????????? Distortions functions
      ?????????distortion_*distortion_name*.m : function that generate the distortion specified by *distortion_name*
  ????????? dist_*distortion_name*.m: functions that call each respective functions in the folder "Distortions functions" 
  ????????? main.m: main script that calls all dist_*distortion_name*.m functions
  ```
**Download the Rain and Haze images sources to generate these distortion**: https://drive.google.com/drive/folders/1PDlCD63W8myRbsaJTRjwYBVlt8X2uwaA?usp=sharing  
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
    
The distorted images are as the following tree structure:   

      ```
      outputFolder: path given in the main script that described the output folder
      ????????? noise
          ????????? Level 1 of distortion (value)
          ...
          ...
          ????????? Level 10 of distortion (value)
      ????????? Next distortion  
          ????????? Level 1 of distortion (value)
          ...
          ...
          ????????? Level 10 of distortion (value)   
         ```  
         
- **Train set**: we applied distortions through 5% of the contained images for each of the 10 distortion types (5.9K images per distortion type). The values of distortions have been randomly chosen in intervals specific to each distortion type. The functions to generate these distortions, present in the **Distortions_train** folder, are similarly structured to the previous:

    ```
  Distortions_train
  ????????? Distortions functions
      ?????????distortion_*distortion_name*.m : function that generate the distortion specified by *distortion_name*
  ????????? main_distortion_application.m : main script that calls all dist_*distortion_name*.m functions and assigns the distortion type to images
  ```
  
  You need to modify the different paths listed below in the main script according to your folders structure:
  
        - imgtrain_path (line 20): path directory of the train set containing images
        - imgtrain_dist (line 27): where to generate the distorted train set
        - path_annotation (line 36): path directory of the train set containing annotations
        - hazeFolder (line 39): path directory containing the haze images source
        - rainFolder (line 41): path directory containing the rain images source
        - outputFolder (line 45): as imgtrain_dist

      
Evaluation protocols
-----------------------------------

We provide many additional files to perform the robustness evaluation against distortions of models **Mask-RCNN, EfficientDet, and YOLOv4**.
- **YOLOv4/YOLOv4-tiny:** How to evaluate YOLO
    - Download the darknet repository: https://github.com/AlexeyAB/darknet
    - Install the darknet executable into the darknet directory: https://pjreddie.com/darknet/install/
    - Copy and paste into the darknet directory our dependencies (cfg and img_dir folders, and python and shell files): https://drive.google.com/drive/folders/187RnbPSwFhEOH5k1E4LgrEDFuMOY4qEI?usp=sharing
    - Download the desired **MODEL** in paste it in the darknet directory (find it here): https://github.com/AlexeyAB/darknet#pre-trained-models
    - Evaluation shell script for the selected **MODEL** and **COCO_CONFIG**: 
        
            ./darknet detector valid cfg/**COCO_CONFIG**.data cfg/**MODEL**.cfg **MODEL**.weights
            python coco_eval.py $PATH_TO_INSTANCE_ANNOTATION$/instances_val2017.json ./results/coco_results.json bbox
        
    - **MODEL**: choosen model (yolov4 or yolov4-tiny by exemple)
    - **$PATH_TO_INSTANCE_ANNOTATION$**: path to the directory containing annotation from COCO
    - **img_dir directory**: contains all text file with distorted images paths according to the distortion type and level
        - val2017: contain path for the original validation set from MS-COCO => val2017.txt
        - val2017_$distortion_name$$level$: by exemple for the distortion noise of level 2 => val2017_noise2.txt 
        - **Change the path to images of eauc text file according to your directory** 
        
                ---------By exemple for val2017_blur1.txt-------------------------
                /home/beghdadi/COCO/val2017_d/blur_motion/2.500000/000000182611.jpg
                /home/beghdadi/COCO/val2017_d/blur_motion/2.500000/000000335177.jpg
                ---------To change:-----------------------------------------------
                /path_to/val2017_d/blur_motion/2.500000/000000182611.jpg
                /path_to/val2017_d/blur_motion/2.500000/000000335177.jpg
            
    - **COCO_CONFIG**: data file that contains all necessary information such as:
        
            classes= 80 => define number of class
            train  = /path_to/train2017.txt  => give path to text file that contain path for each used images for training
            valid  = /path_to/val2017.txt   => give path to text file that contain path for each used image for validation
            #valid = data/coco_val_5k.list
            names = data/coco.names     => give path to file that contain all category names
            backup = /path_to/darknet/backup/ => give path to folder where to save trained model
            eval=coco
                  
    - **How to launch the evaluation of yolov4 model for all distortions**:
    
            ./launch_eval_yolov4.sh
            contains by exemple: ./darknet detector valid cfg/coco_comp1.data cfg/yolov4.cfg yolov4.weights
            
        - **cfg/coco_comp1.data**: where "coco_comp1" is the data file that include path information of distorted images through compression 
        
   - **How to launch the evaluation of yolov4-tiny model for all distortions**:
    
            ./launch_eval_yolov4_tiny.sh
            contains by exemple: ./darknet detector valid cfg/coco_comp1.data cfg/yolov4-tiny.cfg yolov4-tiny.weights
            
        - **cfg/coco_comp1.data**: where "coco_comp1" is the data file that include path information of distorted images through compression 

- **Mask-RCNN:** How to evaluate the Mask-RCNN model
    - Download and extract repository from:  https://github.com/ahmedfgad/Mask-RCNN-TF2
    - Follow installation instructions: https://github.com/ahmedfgad/Mask-RCNN-TF2#installation
    - Download our dependencies and paste it into the mask-rcnn directory: https://drive.google.com/drive/folders/1P9JLeSzgsNDazkz0vtvgE5cST8Xs5Ezc?usp=sharing
    - Run the following command:

            python3 samples/coco/coco.py evaluate --dataset=/home/beghdadi/COCO/  --model=coco


- **EfficientDet:** How to evaluate the EfficientDet model
    - Download directory from: https://github.com/google/automl/tree/master/efficientdet
    - Follow the installation instruction: https://github.com/google/automl/tree/master/efficientdet#efficientdet
    - Download the desired model: https://github.com/google/automl/tree/master/efficientdet#2-pretrained-efficientdet-checkpoints
    - Download our dependencies and paste them into the automl directory: https://drive.google.com/drive/folders/1HJqgQIkNUqRtnuHqDmTfnBoPwh1lgaJ1?usp=sharing
    - Create the "annotations" folder in the autml directory and paste "instances_val2017.json" and "captions_val2017.json" from MS-COCO dataset into it 
    - **Launch EfficientDet Evaluation for all distortion type and level**:
        - Modify the shell script "launch" to add yout directory configuration to indicate the **image_dir** path
        - Run the following script: **./launch.sh**
         

Evaluation results
-----------------------------------
Evaluation experiments are done with YOLOv4-tiny, YOLOv4, EfficientDet-D0, EfficientDet-D1, EfficientDet-D2, EfficientDet-D3, EfficientDet-D4 and Mask-RCNN models on GPU RTX 2080 SUPER. Here is, the mAP score of models acoording to distortion type and level (Level 0 corresponds to images non-distorted):
![image](https://user-images.githubusercontent.com/80038451/153758154-73f7ab7a-2776-49b5-b40d-81404302af9f.png)
![image](https://user-images.githubusercontent.com/80038451/153758166-71744e78-0b90-4896-ac32-347fa12f2c6f.png)
To better assess the impact of distortion on models performance, here is on the left a Bar graph that represents the mAP average of models according to all distortion type and level. On the right, a data distribution visualization including box and violin plots that provide more information about data composition:
![image](https://user-images.githubusercontent.com/80038451/154288132-5f1732d7-edc0-45f6-bb1e-bc27e94ff03b.png)





Training results
-----------------------------------

Training experiments are done with the YOLOv4-tiny model on GPU RTX 2080 SUPER. Find all dependencies to train your model with our distorted train set here:
- Copy and paste into the darknet directory our dependencies (cfg, img_dir, and data folders): https://drive.google.com/drive/folders/187RnbPSwFhEOH5k1E4LgrEDFuMOY4qEI?usp=sharing
- **coco2017_d**: files that contains annotation in txt format.
    - link: https://drive.google.com/file/d/1O3TtciCbmqeq0M5FpkaSjqP_boXB9eR7/view?usp=sharing
- **data folder**: folder that must contain information files to run training
    - link: https://drive.google.com/drive/folders/1Wd0wcNEoeNcKaJs1M6BMPZUtFPQve8hv?usp=sharing
- **pre-trained models**: instructions and pre-trained models to launch a costum training
    - link: https://github.com/AlexeyAB/darknet#how-to-train-to-detect-your-custom-objects

Protocol to launch a costum training:
- Copy and paste files from the coco2017_d folder previously downloaded into the coco2017 folder from the data folder present in the darknet directory:

      ```
      ????????? darknet
          ????????? data
            ????????? coco2017
                ????????? paste here all files contain in the coco2017_d folder
            ????????? coco2017.data    
            ...
            ????????? val2017.txt
      ????????? cfg 
          ????????? 9k.labels
          ...
          ????????? yolo-voc.cfg
      ????????? img_dir
          ????????? train2017.txt
          ...
          ????????? val2017_rain10.txt   
         ```  
         
- Copy and paste python and shell files into the darknet directory : https://drive.google.com/drive/folders/187RnbPSwFhEOH5k1E4LgrEDFuMOY4qEI?usp=sharing
- **To train your model on our distorted MS-COCO dataset:**
    - Copy and paste images from our distorted MS-COCO 2017 training set (**see Requirements to download it**) into the coco2017 folder (in folder data)
    - Copy and paste the desired **pre-trained models** in the darknet directory
    - Modify the coco2017.data in the data folder as follow:

            classes= 80
            train  = /home/beghdadi/darknet/data/train2017_d.txt
            valid  = /home/beghdadi/darknet/data/val2017.txt
            #valid = data/coco_val_5k.list
            names = data/coco2017.names
            backup = /home/beghdadi/darknet/backup/
            eval=coco
        
    - Select the desired models to train into the script **launch_traind** and run it as follow:
    
            ./launch_traind.sh

- **To train your model on the original MS-COCO dataset:**
    - make the same process but copy paste the original MS-COCO 2017 training set instead of our distorted MS-COCO 2017 training set.

Here, evaluation results of our trained models robustness against each distortion type and level.
![image](https://user-images.githubusercontent.com/80038451/153755895-5503f06a-9465-4267-b3c9-e4df9f794dd7.png)
![image](https://user-images.githubusercontent.com/80038451/153755924-b7496789-4b34-46f8-92f9-a5e4379f28ab.png)

Previous graphics are summarized in the following table to highlight the impact of data augmentation on robustness for each specific distortions and for specified levels:

|Distortion Type| 2  | 4 | 6 | 8 | 10 |mAP Average per distortion| 
| ------ | :------: | :------: | :------: |  :------: | :------: | :------: |
| **Noise** | 9.58% | 22.3% |37.9% | 80.3% | 114% | 47.2% |
| **Contrast** | -0.54% | 1.8% | 2.47% | 3.23% | 5.71% | 1.99% |
| **Compression** | -2.36% | -0.48% |-0.5% | 4.84% | 35.4% | 4.26% |
| **Rain** | 12.7% | 40.4% | 71.4% | 101.8% | 114.3% | 61.7% |
| **Haze** | -0.49% | 3.14% |10.5% | 29.8% | 51.7% | 15.8% |
| **Motion-Blur** | 6.11% | 39.5% |95.3% | 151.4% | 183.3% | 86.3% |
| **Defoc-Blur** | 1.02% | 14.2% |22.4% | 26.3% | 26.7% | 16.5% |
| **Loc. MBlur** | 10.3% | 31.6% |46.9% | 59.3% | 67.0% | 39.8% |
| **Loc. Defoc.** | 3.08% | 16.0% |23.3% | 25.5% | 25.9% | 17.2% |
| **BAckLit** | 1.45% | 5.85% |19.1% | 40.3% | 76.8% | 24.1% |
| **Average per level** | 4.11% | 17.9% |32.9% | 52.3% | 70.1% | **31.5%** |


In our case the global average improvement reaches 31.5%. 

    
    
Citation
-----------------------------------

Use this BibTeX to cite this repository:



Use this BibTeX to cite the corresponding paper:

