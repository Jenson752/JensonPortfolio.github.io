# Text Analytics and Supervised Text Classification Project

## Project Overview

This repository explores key text analytics techniques and builds a supervised text classification model. The project is divided into two main parts:

- **Project Part A**: Focuses on fundamental text processing tasks such as tokenization, stop word removal, stemming, POS tagging, and computing sentence probabilities using bigram models.
- **Project Part B**: Involves dataset selection, exploratory data analysis (EDA), and building supervised text classification models using Python and SAS Text Miner. This includes hyperparameter tuning and evaluating model performance.

## [Project Part A](https://github.com/Jenson752/JensonPortfolio.github.io/blob/main/Projects/TXSA/TXSA%20Part%20A.ipynb)

### Text Preprocessing and Analysis

In this section, the following tasks were covered using the **Data_1.txt** file:

1. **Tokenization**

   - Demonstrate and comapre different methods to split text into tokens using:
     - Basic `split` function.
     - Regular Expressions.
     - NLTK library.

2. **Stop Words and Punctuation Removal**

   - Identify and remove common stop words and punctuation from the text to clean the dataset.

### Stemming

Stemming reduces words to their base or root form. Demonstrated using **Data_1.txt**:

1. **Importance of Stemming**

   - Explain why reducing words to their base or root forms is useful in text analytics.

2. **Stemming Methods**

   - Demonstrate and compare different stemming techniques including:
     - Regular Expression-based stemming.
     - Porter Stemmer.
     - Lancaster Stemmer.

### Parts of Speech Tagging and Parsing

By using the **Data_2.txt** file to demonstrate:

1. **POS Tagging**

   - Apply various POS tagging methods using:
     - NLTK.
     - TextBlob.
     - Regular Expression-based taggers.

2. **Parse Tree Drawing**

   - Create parse trees for sentences to understand their syntactic structures using suitable Python code.

### Sentence Probabilities

Using **Data_3.txt**, which contains sentences marked by s and /s tags:

1. **Unsmoothed Bigram Model**

   - Compute sentence probabilities without smoothing using bigram models manually.

2. **Smoothed Bigram Model**

   - Compute sentence probabilities with smoothing techniques manually.

3. **Python Implementation**

   - Implement both unsmoothed and smoothed bigram models in Python to calculate sentence probabilities programmatically.

## [Project Part B](https://github.com/Jenson752/JensonPortfolio.github.io/blob/main/Projects/TXSA/TXSA%20Part%20B.ipynb)

### Dataset Selection and EDA

1. **Dataset Selection**

   - Chose [Women’s Clothing E-commerce Reviews Dataset](https://www.kaggle.com/datasets/nicapotato/womens-ecommerce-clothing-reviews) from Kaggle for text sentiment classification purposes. This dataset contains real customer reviews of women's clothing, and it is ideal for analyzing customer sentiment.

2. **Exploratory Data Analysis (EDA)**

   - Perform EDA to understand the dataset’s structure, distribution, and key characteristics. This includes examining the distribution of sentiments, the frequency of words in reviews, and any other interesting patterns in the data.

### Supervised Text Classification

1. **Python Models**

   - Build and evaluate text classification models using Python libraries such as NLTK, Scikit-learn, and SpaCy.
     - **Chosen Models**:
       - **a. Random Forest**
       - **b. Multinomial Naive Bayes**
       - **c. Logistic Regression**

### Hyperparameter Selection

1. **Hyperparameter Listing**

   - List and explain the hyperparameters that can be tuned for each model.

2. **Tuning Methods**

   - Use grid search or random search methods to find and report the optimal hyperparameters for the models.

### Evaluation and Discussion

1. **Evaluation Metrics**

   - Select and describe the metrics used to evaluate the performance of the models, such as accuracy, precision, recall, and F1-score.

2. **Model Evaluation**

   - Present the evaluation results for the built models.

3. **Critical Analysis**

   - Compare and critically analyze the performance of the models to identify the best approach.
