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
   - Obtain Twitter API keys (provided by company): consumer key, consumer secret, access token, and access token secret.
   
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
   - Configure OpenAI API with keys (provided by company) for sentiment analysis.

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

##

### 5. Data Cleaning and Preprocessing

In this step, we focus on refining and preparing the tweets' text for analysis. Below are the key activities performed:

- **Text Cleaning Using Regular Expressions**
  - **Remove URLs:** Strip out any web addresses from the text.
  - **Remove Mentions:** Eliminate any Twitter handles (e.g., `@username`).
  - **Remove Hashtag Symbols:** Keep the hashtagged words but remove the `#` symbol (e.g., `#Election` to `Election`).
  - **Remove Punctuation:** Erase all punctuation marks except underscores to retain formats like `email_address`.
  - **Filter to ASCII Characters:** Exclude non-ASCII characters to avoid garbled text, such as `ðÿ`.
  - **Convert to Lowercase:** Standardize the text to lowercase for uniform processing.

- **Handle Empty Strings**
  - **Remove Empty Tweets:** Remove tweets where the text content ends up being an empty string after cleaning.

- **Tokenization**
  - **Break Down Text:** Split the tweets into individual words (tokens) for detailed analysis.
  - **Sentence and Word Tokenization:** Separate the text into sentences or words to facilitate easier processing.

- **Word Counting**
  - **Count Words:** Perform a count of words in each tweet to gather insights into tweet length and content.

- **Stopword Removal**
  - **English Stopwords:** Use the NLTK library to remove common English stopwords (e.g., `the`, `is`, `and`).
  - **Malay Stopwords:** Use the [Malaysian Stopwords dataset](https://www.kaggle.com/datasets/heeraldedhia/stop-words-in-28-languages?select=malaysian.txt) from Kaggle to filter out common Malay stopwords, enhancing multilingual text processing.

- **Lemmatization**
  - **Reduce to Base Form:** Reduce words to their base or root form to standardize variations (e.g., `running` to `run`).
  - **English Words:** Apply NLTK’s lemmatization tools for English text.
  - **Malay Words:** Use the MALAYA library for lemmatizing Malay words.

### 6. Sentiment Analysis

In this section, various visualizations are created to gain insights from the cleaned and processed tweet data.

- **Word Cloud**
  - **Purpose:** Visualize the most frequent words in the tweets to quickly understand common themes and topics discussed by the politician and their audience.
  - **Visualization:** Generate a word cloud to highlight the prominence of words based on their frequency.

- **Sentiment Distribution**
  - **Overall Sentiment Count:**
    - **Purpose:** Show the distribution of positive, neutral, and negative sentiments in the dataset.
    - **Visualization:** Create a bar plot to display the count of each sentiment category.
  - **Sentiment Distribution Over Time:**
    - **Purpose:** Track how sentiment towards the politician changes over time.
    - **Visualization:** Use a line plot to depict the variation of sentiment over a specified period.

- **Engagement Analysis (Politician's Tweets Only)**
  - **Engagement Rate Distribution:**
    - **Purpose:** Understand how engagement varies across different tweets.
    - **Visualization:** Create a histogram to show the distribution of engagement rates.
  - **Engagement Rate Over Time:**
    - **Purpose:** Observe trends and patterns in engagement rates over time.
    - **Visualization:** Plot a scatter plot to illustrate how engagement rates change with each tweet over time.
  - **Mean Engagement Rate by Sentiment:**
    - **Purpose:** Compare the average engagement rates across different sentiment categories.
    - **Visualization:** Generate a bar plot to show the mean engagement rate for positive, neutral, and negative tweets.
  - **Outlier Detection and Removal:**
    - **Purpose:** Identify and handle tweets with unusually high or low engagement to ensure accurate analysis.
    - **Procedure:** Manually inspect the data for patterns of outliers, then preprocess the data to remove them for cleaner analysis.

- **Word Count Analysis**
  - **Top Words in Politician's Tweets and Mentions:**
    - **Purpose:** Determine the most common words used in the tweets and mentions.
    - **Visualization:** Display a bar plot of the top 10 words to highlight their frequency in the dataset.

- **Hashtag Analysis**
  - **Correlation of Hashtags and Engagement:**
    - **Purpose:** Analyze the impact of hashtags on tweet engagement rates.
    - **Visualization:** Create a bar plot to show the correlation between the presence of hashtags and the average engagement rate.

### Implementation for Step 5 - 6

You can explore the practical implementation of steps 5 and 6 with detailed workflows and analysis through the [jupyter notebook](https://github.com/Jenson752/JensonPortfolio.github.io/blob/main/Projects/politician-sentiment-analysis/sentiment_analysis.ipynb).

##

## Challenges

- **Limited Data Coverage:**
  - The data collection period was constrained to 1-2 weeks due to API rate limits and time constraints. This limitation results in:
    - **Reduced Data Volume:** The analysis is based on a smaller dataset, which might not capture the full range of patterns and trends.
    - **Ineffective Time Series Visualizations:** With a short timeframe, time series visualizations may not effectively illustrate meaningful trends or changes over time.
    - **Evident Data Limitations:** Visualizations may reflect the limitations of the dataset rather than the broader sentiment trends.
    - **Restricted Visualization Options:** The limited data confines the types and depth of visualizations that can be effectively utilized.

- **Incomplete Removal of Malay Stopwords:**
  - Despite utilizing a comprehensive list of over 300 Malay stopwords, some common stopwords were still present in the analysis. This can lead to:
    - **Inconsistent Data Cleaning:** The presence of unremoved stopwords can affect the accuracy and consistency of text analysis.
    - **Need for Enhanced Stopword List:** Further research is needed to expand the Malay stopwords list to improve data preprocessing.

- **Potential Bias in Sentiment Classification:**
  - Using OpenAI's sentiment classifier may introduce biases in sentiment analysis due to:
    - **Classifier Limitations:** The pre-trained model might not accurately capture the nuances of sentiment in political tweets, especially in different languages or cultural contexts.
    - **Sentiment Misclassification:** There is a risk of misclassifying tweets, leading to potential inaccuracies in sentiment trends and analysis.

## Future Improvements

- **Expand Data Collection:**
  - **Increase API Access:** Seek higher API limits or alternative data sources to collect a larger and more diverse dataset over a more extended period. This will:
    - **Enhance Data Volume:** Provide a more robust dataset for comprehensive analysis.
    - **Enable Detailed Trends Analysis:** Allow for more effective time series visualizations and trend identification.

- **Enhance Visualization Techniques:**
  - **Create Impactful Visualizations:** With a larger dataset, employ advanced visualization techniques to uncover deeper insights and trends. This includes:
    - **Interactive Dashboards:** Develop dashboards to dynamically explore and visualize the data.
    - **Detailed Sentiment Over Time:** Use extended data to better capture and display sentiment changes over significant periods.
  
- **Develop a Custom Sentiment Model:**
  - **Machine Learning Classification:** Train a custom sentiment analysis model tailored to political tweets, utilizing tools such as pre-trained models or building a model from scratch. This approach includes:
    - **Use of Transfer Learning:** Leverage existing pre-trained models and fine-tune them on the dataset to improve classification accuracy.
    - **Incorporate Domain-Specific Features:** Integrate features specific to political discourse to enhance sentiment detection.

- **Improve Data Cleaning for Malay Text:**
  - **Expand Stopword List:** Continuously update and refine the list of Malay stopwords to ensure more thorough data cleaning.
  - **Use Advanced NLP Techniques:** Employ more sophisticated text preprocessing techniques to handle multilingual and mixed-language content effectively.
