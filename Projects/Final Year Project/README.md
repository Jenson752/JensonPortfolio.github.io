# Improving Traffic Safety with YOLO-based Car Accident Detection

This project addresses the critical challenge of traffic accidents through innovative deep learning models, specifically YOLOv5, YOLOv6, and YOLOv8 models, for real-time accident detection.

## Project Aim
The aim to develop an efficient and accurate car accident detection model using YOLO-based models, that will benefit society by improving road safety, reducing response times, minimizing traffic congestion, optimizing emergency services, supporting traffic management, and empowering road users with real-time information.

## Project Objectives
1. To develop YOLO-based deep learning models customized for real-time car accident detection

2. To implement optimization techniques to enhance the accuracy and efficiency of the YOLO models

3. To evaluate the performance of the developed YOLO models using comprehensive metrics and comparative analysis against existing models

4. To deploy the optimal YOLO model for practical use on real-time accident detection on sample images and videos

## Key Features
- **Datasets:** Utilizes diverse, high-quality images from Roboflow, essential for robust model training.
  - **Dataset 1 Source:** https://universe.roboflow.com/accidents/accidentsdetection/dataset/6
  - **Dataset 2 Source:** https://universe.roboflow.com/gourab-dl9ef/car_accident_dataset/dataset/1
- **Methodology:**
  - Data understanding on image quality, labels, and bounding boxes.
  - Implements an experimental double transfer learning strategy, training models successively on two different Roboflow datasets.
  - Performance evaluations between developed models and similar works, using metrics and techniques such as:
    - Precision, Recall, F1, mAP50, mAP50-95
    - Learning curve analysis
    - precision-recall curve analysis
    - Confusion matrix analysis
    - Validation results analysis
    - Model inference analysis
- **Performance:** The YOLOv8 improved model is the optimal choice, achieving:
  - **Precision:** 99.9%
  - **Recall:** 98.6%
  - **mAP (Mean Average Precision):** 99.5%

## Impact
By developing an efficient traffic accident detection model, this project aims to mitigate the impact of accidents on roadways, contributing to safer and more responsive transportation systems.

## Project Document
For an in-depth analysis of the project, including methodologies, model performance evaluations, limitations, future enhancement and more, please refer to my [Final Year Project (FYP) document](https://docs.google.com/document/d/e/2PACX-1vRCqvxYbddcprMxscJ9_snErpHuU_66p8CXKTlzzMePJ96x92ifS57Y7I7pSunBvw/pub).

## Model Deployment
If you have more time, feel free to try out my [model](https://universe.roboflow.com/fyp-projects-ttk43/accident-detection-xymwp/model/1), which I had deployed on Roboflow website. 
