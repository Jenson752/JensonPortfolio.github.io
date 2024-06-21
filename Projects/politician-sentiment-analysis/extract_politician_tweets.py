import tweepy
import csv
import pandas as pd
import openpyxl
import openai
from openpyxl.utils.dataframe import dataframe_to_rows
from textblob import TextBlob
from tweepy import OAuthHandler
from datetime import datetime

openai.api_key = "Hide"

consumer_key = "Hide"
consumer_secret = "Hide"
access_token = "Hide"
access_token_secret = "Hide"

auth = OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth)

#tweets limit
GET_TWEETS_COUNT = 1000

#Openpyxl
twitter_workbook = openpyxl.Workbook()
workbook_name = "twitter_details_and_sentiment.xlsx"
anwar_worksheet = twitter_workbook.active
anwar_worksheet.title = "Twitter Data"
anwar_worksheet.append(["Tweet ID", "Username", "Text", "Created Date", "Like Count", "Retweet Count"])

#Data Frame
columns_politician_df = ['Tweet ID','Tweet Text','Date','Likes Count','Retweet Count','Hashtag/s','Sentiment','Engagement Rate']
columns_audience_df = ['Tweet ID','Username','Tweet Text','Date','Likes Count','Retweet Count','Hashtag/s']

#screen_names
screen_names = {
    "Anwar Ibrahim":"anwaribrahim",
    "Hannah Yeoh":"hannahyeoh",
    "Syed Saddiq":"SyedSaddiq",
}

#Keywords
anwar_keywords = 'anwaribrahim -filter:retweets'
ssaddiq_keywords = 'SyedSaddiq -filter:retweets'

#file name
files = {
    "anwar_tweets_file":"anwar_tweets_details.csv",
    "ssaddiq_tweets_file":"ssaddiq_tweets_details.csv",
}

Sentiment = {
    "Positive":"Positive",
    "Negative":"Negative",
    "Neutral":"Neutral"
}

#functions
def GetUserTweets(screen_name,tweets_count):
    tweets = api.user_timeline(screen_name=screen_name,count=tweets_count)
    return tweets

def GetUserStatus(id):
    user_status = api.get_status(id=id)
    return user_status

def GetUserObject(screen_name):
    user_object = api.get_user(screen_name=screen_name)
    return user_object

def GetFollowersCount(screen_name):
    user = api.get_user(screen_name=screen_name)
    return user.followers_count

#openai sentiment 
def GetSentimentOpenAI(text):
    prompt = f"Please classify the sentiment of the following tweet: '{text}'\nSentiment:"
    response = openai.Completion.create(
        engine="text-curie-001",
        prompt=prompt,
        temperature=0.5,
        max_tokens=1,
        n=1,
        stop=None,
        timeout=30,
    )
    sentiment = response.choices[0].text.strip().lower()
    if "positive" in sentiment:
        sentiment = "positive"
    elif "negative" in sentiment:
        sentiment = "negative"
    else:
        sentiment = "neutral"

    return sentiment

#textblob sentiment
def GetSentimentTextBlob(text):
    blob = TextBlob(text)
    sentiment_polarity = blob.sentiment.polarity
    
    return sentiment_polarity

def GetEngagementRate(likes,retweets,followers,tweets_num):
    return (likes+retweets)*100/(followers)

#XSLX Format
def GetAudienceTweets(keywords,num_tweets,workbook,worksheet,filename):
    for tweet in tweepy.Cursor(api.search_tweets, q=keywords, lang="en", tweet_mode="extended").items(num_tweets):
        tweet_id = tweet.id
        username = tweet.user.screen_name
        text = tweet.full_text
        created_at = tweet.created_at
        like_count = tweet.favorite_count
        retweet_count = tweet.retweet_count

        worksheet.append([tweet_id, username, text, created_at, like_count, retweet_count])
    
    workbook.save(filename)

#paginate through all the tweets of a specific user 
def RetrieveAllTweets(screen_name):
    all_tweets = []
    new_tweets = api.user_timeline(screen_name=screen_name, tweet_mode="extended")

    # Keep retrieving pages of tweets until there are no more left
    for tweet in tweepy.Cursor(api.user_timeline, screen_name=screen_name, tweet_mode="extended").items():
        all_tweets.append(tweet)

    #print(f"Number of tweets retrieved: {len(all_tweets)}")

    return all_tweets

def UserTweetsInfoToCSV(screen_name,tweets_num,file_name):
    data = []
    hashtags_dict = {} #likes,retweet,each sentiment amount
    tweets_by_date_dict = {}
    total_positive_sentiment = 0
    total_neutral_sentiment = 0
    total_negative_sentiment = 0
    total_likes = 0
    total_retweet = 0
    total_tweets = 0

    user_followers = GetFollowersCount(screen_name)

    tweets = api.user_timeline(screen_name=screen_name,count=tweets_num)
    for tweet in tweets:
        temp_positive = 0
        temp_negative = 0 
        temp_neutral = 0

        tweet_sentiment = ""
        
        if GetSentimentTextBlob(tweet.text) > 0:
            total_positive_sentiment += 1
            temp_positive += 1
            tweet_sentiment = Sentiment['Positive']
        elif GetSentimentTextBlob(tweet.text) < 0:
            total_negative_sentiment += 1
            temp_negative += 1
            tweet_sentiment = Sentiment['Negative']
        else:
            total_neutral_sentiment += 1
            temp_neutral += 1
            tweet_sentiment = Sentiment['Neutral']

        total_likes += tweet.favorite_count
        total_retweet += tweet.retweet_count
        total_tweets += 1

        hashtag_text = ""
        hashtag_texts = []

        hashtags = tweet.entities['hashtags']
        for hashtag in hashtags:
            hashtag_texts.append(hashtag['text'])
            if  hashtag['text'] not in hashtags_dict:
                hashtags_dict[hashtag['text']] = {'Likes':tweet.favorite_count,
                                                  'Retweets':tweet.retweet_count,
                                                  'Positive Sentiment':temp_positive,
                                                  'Neutral Sentiment':temp_neutral,
                                                  'Negative Sentiment':temp_negative}
                
                # hashtags_dict[hashtag['text']] = [tweet.favorite_count,tweet.retweet_count,
                #                                   temp_positive,temp_neutral,temp_negative] #hashtags dict value structure
            else:
                hashtags_dict[hashtag['text']]['Likes'] += tweet.favorite_count
                hashtags_dict[hashtag['text']]['Retweets'] += tweet.retweet_count
                hashtags_dict[hashtag['text']]['Positive Sentiment'] += temp_positive
                hashtags_dict[hashtag['text']]['Neutral Sentiment'] += temp_neutral
                hashtags_dict[hashtag['text']]['Negative Sentiment'] += temp_negative
                
        hashtag_text = ','.join(hashtag_texts)

        data.append([tweet.id,
                    tweet.text,
                    tweet.created_at,
                    tweet.favorite_count,
                    tweet.retweet_count,
                    hashtag_text,
                    tweet_sentiment,
                    GetEngagementRate(tweet.favorite_count,tweet.retweet_count,user_followers,total_tweets)
                    ])

    #count average engagemnet rate
    total_engagement_rate = 0
    avg_engagement_rate = 0
    for tweet in data:
        total_engagement_rate += tweet[7]
        
        #format date
        date_obj = datetime.fromisoformat(str(tweet[2]))
        date_only = date_obj.date()
        if date_only not in tweets_by_date_dict:
            tweets_by_date_dict[date_only] = {'Tweets_Count':1,'Average_Engagement_Rate':tweet[7]}
        else:
            tweets_by_date_dict[date_only]['Tweets_Count'] += 1
            tweets_by_date_dict[date_only]['Average_Engagement_Rate'] = (tweets_by_date_dict[date_only]['Average_Engagement_Rate']*(tweets_by_date_dict[date_only]['Tweets_Count']-1)+
                                                 tweet[7])/tweets_by_date_dict[date_only]['Tweets_Count']

    avg_engagement_rate = total_engagement_rate/len(data)

    df = pd.DataFrame(data,columns=columns_politician_df)
    df.to_csv(file_name,index=False)

    #generating summary
    with open(file_name, mode='a', newline='') as csv_file:
        writer = csv.writer(csv_file)
        writer.writerow([])
        writer.writerow(['Followers','Total Positive Sentiment','Total Neutral Sentiment','Total Negative Sentiment',
                         'Total Likes Count','Total Retweet Count','Total Tweets','Overall Engagement Rate'])
        writer.writerow([user_followers,total_positive_sentiment,total_neutral_sentiment,
                         total_negative_sentiment,total_likes,total_retweet,total_tweets,avg_engagement_rate])   
        writer.writerow([])
        writer.writerow(['Hashtag Summary'])
        writer.writerow(['Hashtag','Likes Count','Retweet Count','Positive Sentiment','Neutral Sentiment','Negative Sentiment'])
        for key,value in hashtags_dict.items():
            writer.writerow([key,value['Likes'],value['Retweets'],value['Positive Sentiment'],value['Neutral Sentiment'],value['Negative Sentiment']])
        writer.writerow([])
        writer.writerow(['Tweets in each Date'])
        writer.writerow(['Date','Tweets Count','Average Engagement Rate'])
        for key,value in tweets_by_date_dict.items():
            writer.writerow([key,value['Tweets_Count'],value['Average_Engagement_Rate']])

#DF for CSV
def KeywordTweetsToCSV(keywords,num_tweets,file_name):
    data = []
    for tweet in tweepy.Cursor(api.search_tweets, q=keywords, lang="en", tweet_mode="extended").items(num_tweets):
        hashtag_text = ""
        hashtags = tweet.entities['hashtags']
        hashtag_texts = [hashtag['text'] for hashtag in hashtags]
        hashtag_text = ','.join(hashtag_texts)
        data.append([tweet.id,
                    tweet.user.screen_name,
                    tweet.full_text,
                    tweet.created_at,
                    tweet.favorite_count,
                    tweet.retweet_count,
                    hashtag_text,
                    GetSentimentOpenAI(tweet.full_text)
                    ])
    df = pd.DataFrame(data,columns=columns_audience_df)
    df.to_csv(file_name,index=False)

#Anwar CSVs
UserTweetsInfoToCSV(screen_names["Anwar Ibrahim"],GET_TWEETS_COUNT,files['anwar_tweets_file'])
UserTweetsInfoToCSV(screen_names["Syed Saddiq"],GET_TWEETS_COUNT,files["ssaddiq_tweets_file"])

#KeywordTweetsToCSV(screen_names["Anwar Ibrahim"],GET_TWEETS_COUNT,anwar_mentioned_file)