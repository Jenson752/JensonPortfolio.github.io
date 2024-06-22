# Politician Sentiment Analysis

## Project Overview

During my internship, I was assigned to a comprehensive project to analyze the sentiment surrounding politicians on Twitter for proof of concept (POC) purposes. The project **aimed** to understand both the sentiment expressed by the politicians themselves and the sentiment of the public towards them, including those who mentioned or interacted with them on Twitter. In this case, I utilized several essential tools to execute this project effectively.

**Note**:
  - Politician's tweets means the tweets that they posted on their account
  - Politician's mentions means the audience or followers that have mentioned the politician on their tweets

## Objectives

- Data Collection: Gather tweets from selected politicians and mentions using the Twitter API and Tweepy.
- Sentiment Analysis: Employ ChatGPT APIs to classify and interpret sentiments in the tweet data.
- Preprocessing: Clean and prepare the tweet data to ensure quality and consistency.
- Visualization: Create visual representations of sentiment patterns and trends over time for politicians and their audiences.

## Methodologies

### 1. Web Scraping

- **API Setup:**
   - Obtain Twitter API keys: consumer key, consumer secret, access token, and access token secret.
   
- **Data Extraction:**
   - Use Tweepy to fetch tweets from selected politicians and those mentioning them.
   - Target politicians for this POC: **Dato' Seri Anwar Ibrahim** and **YB Syed Saddiq**.

- **Data Features:**
   - Define attributes to be extracted:
     - **For Politicians' Tweets:**
       - Tweet ID
       - Tweet Text
       - Date
       - Likes Count
       - Retweet Count
       - Hashtags
       - Followers Count
     - **For Politicians' Mentions:**
       - Tweet ID
       - Username
       - Tweet Text
       - Created Date
       - Like Count
       - Retweet Count
- Store the extracted data into separate dataframes for Tweets and Mentions for each politician.

### 2. Sentiment Classification

- **API Setup:**
   - Configure OpenAI API for sentiment analysis.

- **Classification:**
   - Use OpenAI’s sentiment analysis to categorize the tweet text into:
     - Positive
     - Neutral
     - Negative

- **Feature Enhancement:**
   - Add a "Sentiment" feature to the existing dataframes for both the politicians' tweets and mentions.

### 3. Engagement Rate Calculation

- **Metrics Definition:**
   - Create an "Engagement Rate" feature to effectively measurethe engagements of the politicians' tweets.
   
- **Formula:**
   - Define the engagement rate as: **(Likes Count + Retweet Count) / Number of Followers**
   
- **Feature Enhancement:**
   - Store the calculated engagement rates in the Politicians' Tweets dataframe.

### 4. Data Storage

- **Data Organization:**
   - Store the processed data and newly created features into Excel files for each politician.
   
- **Excel Structure:**
   - Each file contains two sheets:
     - "tweets_details": stores data related to the politician's tweets.
     - "mentions_details": stores data related to the mentions of the politician.
   
- **Sample Files:**
   - Download and view sample Excel files:
     - [Dato' Seri Anwar Ibrahim Twitter Info](https://github.com/Jenson752/JensonPortfolio.github.io/blob/main/Projects/politician-sentiment-analysis/anwar_twitter_info_ds.xlsx)
     - [YB Syed Saddiq Twitter Info](https://github.com/Jenson752/JensonPortfolio.github.io/blob/main/Projects/politician-sentiment-analysis/ssaddiq_twitter_info_ds.xlsx)

### Implementation for Step 1 - 4

You can explore the practical implementation of the steps described above through the provided Python scripts:

- **[Extracting Politicians' Tweets](https://github.com/Jenson752/JensonPortfolio.github.io/blob/main/Projects/politician-sentiment-analysis/extract_politician_tweets.py):** This script retrieves tweets directly from the specified politicians' Twitter accounts.
  - Included Step [1](https://github.com/Jenson752/JensonPortfolio.github.io/tree/main/Projects/politician-sentiment-analysis#1-web-scraping), [2](https://github.com/Jenson752/JensonPortfolio.github.io/tree/main/Projects/politician-sentiment-analysis#2-sentiment-classification), [3](https://github.com/Jenson752/JensonPortfolio.github.io/tree/main/Projects/politician-sentiment-analysis#3-engagement-rate-calculation), [4](https://github.com/Jenson752/JensonPortfolio.github.io/tree/main/Projects/politician-sentiment-analysis#4-data-storage)
- **[Extracting Politicians' Mentions](https://github.com/Jenson752/JensonPortfolio.github.io/blob/main/Projects/politician-sentiment-analysis/extract_replies.py):** This script collects tweets that mention the politicians, providing insights into public interactions and responses.
  - Included Step [1](https://github.com/Jenson752/JensonPortfolio.github.io/tree/main/Projects/politician-sentiment-analysis#1-web-scraping), [2](https://github.com/Jenson752/JensonPortfolio.github.io/tree/main/Projects/politician-sentiment-analysis#2-sentiment-classification), [4](https://github.com/Jenson752/JensonPortfolio.github.io/tree/main/Projects/politician-sentiment-analysis#4-data-storage)


    
