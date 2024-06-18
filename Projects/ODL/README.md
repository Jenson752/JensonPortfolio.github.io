# Optimization and Deep Learning: A Dog Breed Classification Project

## Project Overview

This project encompasses a comprehensive approach to leveraging neural network algorithms for real-world data analytics, specifically focusing on classifying dog breeds from images. Initially, it emphasizes meticulous data preparation and preprocessing to ensure the dataset is handled for accurate analysis. Following this, the project delves into justifying and selecting appropriate neural network models tailored to the dog breed classification problem. Building on this foundation, it then explores the application of deep learning techniques and optimization strategies to enhance model performance, offering practical solutions to the complex challenge of accurately identifying dog breeds from visual data.

## 1. Dataset and Algorithm Selection

### 1.1 Data Collection

The [dataset](https://www.kaggle.com/datasets/venktesh/person-images/data) used for this project was sourced from kaggle, which contains over 8,000 images spanning 133 dog breeds.

### 1.2 Literature Review

Extensive literature review has been conducted to understand past research and methodologies applied to similar problems. Key findings include:

- **Ramadhan and Setiawan (2023)**: Developed a cat breed classification app using CNN models like VGGNet, MobileNetV2, and InceptionV3.
- **Borwarnginn et al. (2021)**: Used CNN-based models like MobileNetV2, NASNet, Xception, and InceptionV3 on an augmented dataset for dog breed classification.
- **Cui et al. (2023)**: Applied various CNN architectures such as Inception V3, InceptionResNet V2, NASNet, and PNASNet with a transfer learning approach for classifying dog breeds from the Stanford Dog Dataset.
- **Ayanzadeh and Vahidnia (2018)**: Utilized DenseNet-121, ResNet-50, DenseNet-169, and GoogleNet for fine-tuning on the Stanford Dog Dataset.
- **Valarmathi et al. (2023)**: Employed advanced models like Xception, VGG19, NasNetMobile, EfficientNetV2M, ResNet152V2, and hybrid architectures for dog breed classification.

### 1.3 Model Justification

The following models have been selected for their robustness in handling image classification tasks:

- **Deep Neural Network (DNN)**: Chosen for its ability to learn complex patterns across various tasks and serving as a versatile baseline model.
- **Convolutional Neural Network (CNN)**: Preferred for its efficiency in capturing patterns and dependencies in visual data, particularly in large datasets with high-resolution images.
- **Xception-based CNN**: Selected for its capability to improve computation efficiency and reduce parameter complexity while leveraging pre-trained knowledge from large datasets like ImageNet.

## 2. Data Preperation

### 2.1 Data Understanding
- **File Path Exploration**: Loaded and explored the dataset directory structure, confirming the organization of images for further processing.
- **Class Count Exploration**: Verified the presence of 133 balanced classes across training, validation, and testing datasets.
- **Class Distribution**: Analyzed and visualized the image distribution, maintaining an 8:1:1 ratio for training, validation, and testing sets.
- **Sample Image Visualization**: Displayed random images from various classes to understand the dataset’s variety and quality.
- **Image Properties Exploration**: Identified image size inconsistencies, necessitating uniform resizing during preprocessing.

### 2.2 Data Preprocessing
- **Image Resizing**: Standardized all images to 150x150 pixels to ensure consistent input for model training.
- **Image Augmentation**: Enhanced the training set by applying rotations, flips, and translations, increasing dataset size and diversity to improve model generalization and reduce overfitting.
- **Image Vectorization and Normalization**: Converted images into one-dimensional vectors and normalized pixel values, preparing data for deep learning model processing.
- **Label Encoding and One-Hot Encoding**: Encoded class labels into numerical and categorical (one-hot) formats, facilitating effective training of classification models.

## 3. Model Building (Base Model)

### DNN
- Sequential model with dense layers (32, 64, 128 neurons) using ReLU activation.
- Output layer with softmax activation for 133 dog breed classes.
- Compiled with categorical cross-entropy loss, accuracy metrics, and Adam optimizer.
- Early stopping after 50 epochs based on validation loss.
- Initial poor performance with low accuracy and precision.

### CNN
- Starts with convolutional layers (32, 64, 128, 256 neurons) and max-pooling.
- Dense layers (1024, 512 neurons) with ReLU activation for classification.
- Dropout (0.5 rate) applied to prevent overfitting.
- Compiled with Adam optimizer, sparse categorical cross-entropy loss.
- Shows accuracy improvements but indicates overfitting in validation.

### Xception 
- Uses Xception pre-trained on ImageNet with custom classification layers.
- Compiled with Adam optimizer, 0.001 learning rate, sparse categorical cross-entropy loss.
- Initial high accuracy (95% on training) but validation accuracy drops, suggesting overfitting.
- Overall performance metrics around 65%, indicating potential for improvement.

## 4. Model Tuning
Hyperparameter tuning using Random Search in Keras Tuner aimed to optimize model performance for dog breed classification.

### 4.1 DNN

#### Manual Improvement
- Added batch normalization and dropout layers to mitigate overfitting.
- Achieved moderate improvements in training and validation metrics.

#### Hyperparameter Tuning
- Used RandomSearch to explore optimal configurations.
- Best validation accuracy reached approximately 10%, with incremental performance gains.

### 4.2 CNN

#### Manual Improvement
- Implemented batch normalization and increased convolutional layers for better pattern recognition.
- Faced challenges with overfitting despite architectural enhancements.

#### Hyperparameter Tuning
- Conducted Random Search to find optimal settings.
- Training terminated early with limited improvement, indicating difficulty in achieving robust performance.

### 4.3 Xception

#### Manual Improvement
- Enhanced with additional layers and regularization techniques to stabilize training.
- Initially high accuracy but struggled with generalization to validation data.

#### Hyperparameter Tuning
- Utilized Keras Tuner for hyperparameter exploration.
- Achieved peak validation accuracy of approximately 80% during tuning, but actual performance lower (~38%), revealing challenges in parameter generalization.

## 5. Model Evaluation & Discussion

### 5.1 Evaluation Metrics

In this study, four key evaluation metrics were used to measure the performance of the neural network models:

- **Accuracy**: Measures overall correctness of predictions.
- **Precision**: Indicates the proportion of true positives among positive predictions.
- **Recall**: Measures the proportion of true positives identified correctly.
- **F1-Score**: Harmonic mean of precision and recall, useful for imbalanced datasets.

### 5.2 DNN Models

#### Performance Comparison

| Metrics / Model         | DNN Base Model | DNN Manual Improvement | DNN Hyperparameter Tuning |
|-------------------------|----------------|------------------------|---------------------------|
| Accuracy                | 0.0179         | 0.0806                 | 0.0789                    |
| Precision               | 0.0003         | 0.0334                 | 0.0639                    |
| Recall                  | 0.0179         | 0.0806                 | 0.0789                    |
| F1-score                | 0.0006         | 0.0382                 | 0.0609                    |

### 5.3 CNN Models

#### Performance Comparison

| Metrics / Model         | CNN Base Model | CNN Manual Improvement | CNN Hyperparameter Tuning |
|-------------------------|----------------|------------------------|---------------------------|
| Accuracy                | 0.1918         | 0.4444                 | 0.2921                    |
| Precision               | 0.1827         | 0.4708                 | 0.3139                    |
| Recall                  | 0.1918         | 0.4444                 | 0.2921                    |
| F1-score                | 0.1739         | 0.4326                 | 0.2753                    |

### 5.4 Xception Models

#### Performance Comparison

| Metrics / Model         | Xception Base Model | Xception Manual Improvement | Xception Hyperparameter Tuning |
|-------------------------|---------------------|-----------------------------|--------------------------------|
| Accuracy                | 0.6452              | 0.6398                      | 0.3889                         |
| Precision               | 0.7268              | 0.7299                      | 0.4262                         |
| Recall                  | 0.6452              | 0.6398                      | 0.3889                         |
| F1-score                | 0.6451              | 0.6392                      | 0.3843                         |

### 5.5 Best Model Comparison

#### Comparison of Best Performing Models

| Metrics / Model         | DNN Hyperparameter Tuning Model | CNN Manual Improvement Model | Xception Base Model |
|-------------------------|---------------------------------|------------------------------|---------------------|
| Accuracy                | 0.0790                          | 0.4444                       | 0.6452              |
| Precision               | 0.0639                          | 0.4708                       | 0.7268              |
| Recall                  | 0.0790                          | 0.4444                       | 0.6452              |
| F1-score                | 0.0609                          | 0.4326                       | 0.6451              |

### 5.6 Discussion

- **DNN Models**: Both manual improvement and hyperparameter tuning showed improvements over the base model but did not achieve satisfactory results, indicating challenges in using DNNs for such a complex classification task.
  
- **CNN Models**: Manual improvement significantly enhanced performance, while hyperparameter tuning also provided improvements, albeit less effectively, highlighting the importance of architecture adjustments.

- **Xception Models**: The base model outperformed both manual improvement and hyperparameter tuning efforts, suggesting the inherent strength of pre-trained models in image classification tasks.

Overall, the Xception base model demonstrates the highest predictive power, indicating the effectiveness of leveraging pre-trained models for complex image classification tasks like dog breed identification.

## 6.0 Conclusion

In this section, we evaluate the performance of the best model from this study against benchmarks established by prior literature in the domain of deep learning-based dog breed image classification. Insights from previous studies are critically analyzed, and avenues for future enhancements are explored.

### Comparison of Testing Accuracy with Prior Studies

The table below compares the final testing accuracy of the best models from each study:

| Study                        | Best Model         | Testing Accuracy |
|------------------------------|--------------------|------------------|
| Ramadhan & Setiawan (2023)   | MobileNetV2        | 82%              |
| Borwarnginn et al. (2021)    | NASNet             | 89.92%           |
| Cui et al. (2023)            | NASNet             | 93.96%           |
| Ayanzadeh & Vahidnia (2018)  | DenseNet-169       | 85.37%           |
| B. Valarmathi et al. (2023)  | Xception + Inception-v3 | 92.4%      |
| This study                   | Xception           | 64.52%           |

While the Xception model in this study achieved a respectable validation accuracy of 64.52% in classifying dog breed images, it falls short compared to the top-performing models in the selected literature. Factors such as model architecture, preprocessing techniques, and hardware requirements may contribute to this performance gap.

### Recommendations for Future Enhancements

To enhance the classification results:

- **Advanced Data Augmentation**: Utilize advanced augmentation methods such as geometric and color transformations to generate more diverse training data and reduce overfitting.
  
- **Transfer Learning**: Incorporate more pre-trained models like MobileNetV2, NASNet, DenseNet, and ResNet. Fine-tuning these models can significantly improve accuracy.
  
- **Hybrid Models**: Explore hybrid or ensemble models that combine multiple CNN architectures and pre-trained models to leverage their respective strengths.
  
- **New Architectures**: Experiment with newer architectures such as NASNetMobile and EfficientNetV2M, which have shown superior performance compared to older models like ResNet and InceptionV3.

By implementing methodologies from existing literature and exploring new techniques in neural network architectures, we can enhance the accuracy and robustness of future classification models in this domain.

Continuous exploration of advancements in neural networks will be essential for achieving further improvements.

## Practical Solutions

For a more in-depth look into the practical solutions and detailed methodologies used in this study, please refer to the [Jupyter Notebook](https://github.com/Jenson752/JensonPortfolio.github.io/blob/main/Projects/ODL/ODL_notebook.ipynb).
