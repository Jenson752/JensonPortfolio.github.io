# Data Analytics using R

## Project Overview

This project focused on analyzing the "employee_attrition" dataset. It involves comprehensive data analysis techniques such as data import, cleaning, pre-processing, exploration, manipulation, and visualization. Each question within the project will utilize these techniques systematically to provide thorough insights. The analysis will be conducted using R programming language in R Studio, emphasizing practical application for effective problem-solving. Assumptions were made due to potential gaps in the dataset.

## Project Implementation for Data Analysis
  
### 1. Data Import / Cleaning / Pre-processing

- Data Import: Imported the dataset from a CSV file into R using the read.csv function.
- Data Cleaning: Checked for null values using sum(is.na()), and confirmed no duplicated records.
- Data Pre-processing: Removed unnecessary columns like "gender_short" for clarity and renamed headers for better understanding.

### 2. Data Exploration

- Explored the dataset to understand its structure (class, dim), and used summary for statistical summaries.
- Examined distinct values in categorical columns to familiarize with the dataset.

### 3. Question & Analysis

#### Question 1 – Why do employees resign?

- Analysis 1-1: Explored resignation patterns by age using histograms, noting peaks around ages 21 and 30.
- Analysis 1-2: Determined the most resigned job ("Cashier") using bar plots.
- Analysis 1-3: Explored tenure by age for resigned employees using point plots and boxplots.
- Analysis 1-4: Analyzed resignations over the years using bar plots and specific store analyses.
  
#### Question 2 – Reasons for employee layoffs

- Analysis 2-1: Investigated layoffs by job using histograms, highlighting "Cashier" as most affected.
- Analysis 2-2: Examined layoffs by store using bar plots, identifying trends across different jobs.
- Analysis 2-3: Explored layoffs by age using bar plots and specific job analyses.
  
#### Question 3 – Job dependency on gender

- Analysis 3-1: Determined job distributions by gender, highlighting differences.
- Analysis 3-2: Explored resigned employees by gender and job using bar plots and violin plots for deeper insights.
- Analysis 3-3: Analyzed layoffs by gender and job, focusing on differences observed in previous analyses.

#### Question 4 – Overall employee shortage

- Analysis 4-1: Compared new hires and terminations from 2006 onwards by store.
- Analysis 4-2: Identified stores with fewer than 100 employees and discussed implications.
- Analysis 4-3: Explored job distributions in stores with fewer than 20 employees, specifically identifying "Dairy Person."

#### Question 5 – Factors influencing high termination rates

- Analysis 5-1: Explored city populations using bar plots to understand potential influences on termination rates.
- Analysis 5-2: Compared active and terminated employees by city using count plots.
- Analysis 5-3: Analyzed termination rates by job using percentages and bar plots to highlight jobs with high termination rates.

### Conclusion

Each question was systematically analyzed using appropriate R functions and packages (ggplot2, dplyr, etc.) to provide visual and statistical insights into the dataset. Hypotheses were formulated based on observed patterns, and detailed visualizations enhanced understanding across various dimensions of the dataset. Overall, the analysis demonstrates a comprehensive approach to exploring and interpreting employee attrition data, leveraging R's capabilities effectively.

### Additional Features utilized in Project

- Density Plot: Visualizes numerical variable distributions using kernel density estimation, providing a smoothed histogram alternative unaffected by variations in bin counts.
- Scatterplot: Displays relationships between two numerical variables using (x, y) coordinates, useful for identifying patterns like clusters and correlations.
- geom_count() Plot: A variant of geom_point that aggregates and maps discrete data observations, useful for visualizing overplotting.
- Box Plot: Summarizes dataset distributions with key statistics (minimum, quartiles, maximum), efficiently displaying data from multiple sources.
- Violin Plot: Combines box plot features with density plots to show summary statistics and data distribution insights in a single view.
- geom_text Function: Labels bars in bar plots or histograms with their values, enhancing data interpretation directly on the plot.
- coord_flip Function: Rotates x and y axes in plots, beneficial for managing numerous categorical values on the x-axis to avoid overlap and improve readability.
- facet_wrap Function: Organizes plots by categorical data groups, facilitating comparative analysis across different segments or subsets of the dataset.
- get_dupes Function: Checks for duplicate values within a data frame, ensuring data integrity by identifying and managing duplicated entries.

## Project Document

For a more comprehensive analysis and further interpretation, feel free to view the [project document](https://docs.google.com/document/d/e/2PACX-1vSEn_hbFv-aBcXZVr4NHXHjoX6feqWlqm-mHsBCNn4HjnUqYNCLeIhZLU3Rbm8Xjw/pub).
