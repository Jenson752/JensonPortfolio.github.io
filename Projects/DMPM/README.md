# Data Mining and Predictive Modelling

## Project Overview
This project explore the application of data mining techniques to address business challenges within a chosen industry. The goals of this project were focused on leveraging data analytics to uncover insights and develop predictive or descriptive models using **SAS Enterprise Miner tool**, which eventually drive decision-making and solve specific problems in the business domain.

## Problem Statement
A bank manager is concerned about customer attrition of credit cards and seeks to understand the reasons behind it. The goal is to predict which customers are likely to churn so that proactive measures can be taken to retain them.

## Aim
To analyze a dataset of credit card customers' information to:
- Identify the reasons for customer attrition.
- Predict customers who are likely to cancel their credit cards.
- Enable proactive customer outreach to improve retention.
- Enhance services to influence customers' decisions positively.

## Objectives
- Investigate factors contributing to customer attrition.
- Analyze existing customer data to predict credit card cancellations.

## Dataset
The [customer churning dataset](https://www.kaggle.com/datasets/whenamancodes/credit-card-customers-prediction) has been obtained from Kaggle, providing comprehensive information necessary for analyzing customer attrition in the banking sector.

## Project Implementation

#### 1. Exploratory Data Analysis

- **Stat Explore and Graph Explore:** Utilized SAS Enterprise Miner's Stat Explore and Graph Explore features to comprehensively analyze the dataset. Stat Explore was employed to summarize variable distributions and detect outliers, while Graph Explore was used to visualize relationships between variables.

- **Variable Worth Analysis:** Conducted variable worth analysis to identify significant predictors for the predictive models. This step guided the selection of influential variables while disregarding those with minimal impact on model performance.

#### 2. Data Pre-processing

- **Target Variable Selection:** Designated "Attrition_Flag" as the target variable for classification modeling, essential for predicting customer attrition.

- **Class Balancing:** Addressed class imbalance through sampling techniques, ensuring an equal representation of attrited and existing customers in the training dataset. This step aimed to prevent bias toward the majority class during model training.

- **Variable Selection:** Employed variable worth analysis results to select predictors with the highest impact on the target variable. Non-influential or redundant variables were excluded to streamline model complexity and improve predictive accuracy.

- **Data Transformation:** Applied necessary transformations (e.g., log transformations) to handle outliers and skewed distributions in the data. This ensured that the data met the assumptions required for accurate modeling.

- **Data Replacement:** Standardized data representations and handled missing or out-of-bound values to maintain data integrity. Categorical variables were encoded appropriately, and numerical outliers were treated to enhance model robustness.

- **Data Partitioning:** Split the dataset into training and validation sets using SAS Enterprise Miner's Data Partition node. This separation enabled proper model training on one set while validating its performance on another, ensuring unbiased evaluation.

#### 3. Model Development

- Decision Tree
  - Properties: Maximum depth of 6, maximum 2 branches, minimum categorical size of 5.
  - Validation: Misclassification rate (MISC) of 0.1232, accuracy approximately 87.68%.
  - Outcome: Identified decision rules for predicting attrition and existing customers.
 
- Decision Tree 3 Way Split
  - Properties: Maximum depth of 6, maximum 3 branches, minimum categorical size of 6.
  - Validation: Accuracy 89% approx.
  - Outcome: Detailed node rules for predicting customer behavior.

- HP Tree
  - Properties: Default
  - Validation: Accuracy 91% approx.
  - Outcome: Enhanced accuracy compared to Decision Tree 3 Way Split.

- HP Forest
   - Properties: Default settings.
   - Validation: Lower MISC of 0.0710, accuracy approximately 92.90%.
   - Outcome: Enhanced accuracy compared to the Decision Tree model.

- Stepwise Logistic Regression
  - Properties: Logistic regression with stepwise selection
  - Validation: MISC of 0.170921 after 7 steps
  - Outcome: Detailed parameter estimates and odds ratio plots.

- HP 3 Polynomial Degree Stepwise Logistic Regression
  - Properties: Polynomial regression with stepwise selection
  - Validation: Lower MISC of 0.10099
  - Outcome: Improved accuracy compared to Stepwise Logistic Regression.

 - Ensemble Models (Combined Models)
   - Properties: Combined Decision Tree 3 Way Split, Decision Tree, and Stepwise Logistic Regression
   - Validation: MISC of 0.1054
   - Outcome: Integrated strengths of individual models to improve predictive accuracy.
  
#### 4. Comparitive Analysis and Discussion
- Highest Accuracy: HP Forest (~92.90%)
- Lowest MISC: HP Forest (0.0710)
- Decision Tree models provided interpretability through decision rules.
- Logistic Regression models offered insights into variable impacts but with varying accuracy.
- HP models consistently outperformed others in accuracy and misclassification rates, especially HP Forest and HP Tree.
- Ensemble model showed competitive performance, leveraging strengths of individual models to achieve improved accuracy.

## Document
For a more comprehensive analysis and detailed implementation description, feel free to refer the [project document](https://docs.google.com/document/d/e/2PACX-1vSnwY0NoWIPwtrNVzbBqRh7EhKSHsiPZGshnGLF-tKqmPyZ8QgEFjJXa56EGNGV7g/pub).
 



