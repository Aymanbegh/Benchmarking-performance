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
  
- **Validation set**:

Evaluation results
-----------------------------------


Training results
-----------------------------------

