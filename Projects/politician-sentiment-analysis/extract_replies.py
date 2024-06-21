import tweepy
import csv
import pandas as pd
import openpyxl
from textblob import TextBlob
from datetime import datetime

# Oauth keys
consumer_key = "Hide"
consumer_secret = "Hide"
access_token = "Hide"
access_token_secret = "Hide"

# Authentication with Twitter
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth,wait_on_rate_limit=True)

# get the rate limit status for the search endpoint
search_limit = api.rate_limit_status()['resources']['search']['/search/tweets']

# extract the remaining requests from the limit status
remaining_requests = search_limit['remaining']

print(f"The number of remaining API requests for the search endpoint is {remaining_requests}.")

columns_replies = ['Tweet ID','Username','Tweet Text','Created Dated','Like Count','Retweet Count','Sentiment','Sentiment Score']

screen_names = {
    "Anwar Ibrahim":"anwaribrahim",
    "Hannah Yeoh":"hannahyeoh",
    "Syed Saddiq":"SyedSaddiq",
}

files = {
    "anwar_replies_file":'anwar_replies_detail.csv',
    "ssaddiq_replies_file":'ssaddiq_replies_detail.csv',
}

REPLIES_COUNT = 1000

Sentiment = {
    "Positive":"Positive",
    "Negative":"Negative",
    "Neutral":"Neutral"
}

#sentiment analysis using textblob
def GetSentiment(text):
    blob = TextBlob(text)
    sentiment_polarity = blob.sentiment.polarity
    
    return sentiment_polarity

def StoreRepliesToFile(screen_name,tweets_num,file_name):
    data=[]
    replies_by_date_dict = {}
    total_positive_sentiment = 0
    total_neutral_sentiment = 0
    total_negative_sentiment = 0
    total_likes = 0
    total_retweet = 0

    for tweet in tweepy.Cursor(api.search_tweets, q=f'to:'+screen_name,result_type='recent').items(tweets_num):
        tweet_sentiment = ""
        #if hasattr(tweet, 'in_reply_to_status_id_str'): #check null value of the attribute of the tweet object, null means its not a reply tweet
        if hasattr(tweet, 'in_reply_to_status_id_str') and not tweet.text.startswith('RT @') and tweet.user.screen_name != screen_names: #eliminate the case of retweet in replies and replies of user itself
            if GetSentiment(tweet.text) > 0 :
                total_positive_sentiment = total_positive_sentiment+1
                tweet_sentiment = Sentiment['Positive']
            elif GetSentiment(tweet.text) < 0:
                total_negative_sentiment = total_negative_sentiment+1
                tweet_sentiment = Sentiment['Negative']
            else:
                total_neutral_sentiment = +1
                tweet_sentiment = Sentiment['Neutral']

            total_likes += tweet.favorite_count
            total_retweet += tweet.retweet_count            
        
            data.append([tweet.id,
                        tweet.user.screen_name,
                        tweet.text,
                        tweet.created_at,
                        tweet.favorite_count,
                        tweet.retweet_count,
                        tweet_sentiment,
                        GetSentiment(tweet.text)])

    for tweet in data:
        temp_positive = 0
        temp_negative = 0
        temp_neutral = 0

        if tweet[7] > 0:
            temp_positive +=1
        elif tweet[7] < 0:
            temp_negative +=1
        else:
            temp_neutral +=1

        date_obj = datetime.fromisoformat(str(tweet[3]))
        date_only = date_obj.date()
        
        if date_only not in replies_by_date_dict:
            replies_by_date_dict[date_only] = {'Replies Count':1,
                                               'Average Sentiment Score':tweet[7],
                                               'Positive Sentiment':temp_positive,
                                               'Neutral Sentiment':temp_neutral,
                                               'Negative Sentiment':temp_negative}
        else:
            replies_by_date_dict[date_only]['Replies Count'] += 1
            replies_by_date_dict[date_only]['Average Sentiment Score'] = (replies_by_date_dict[date_only]['Average Sentiment Score']*(replies_by_date_dict[date_only]['Replies Count']-1)+
                                                 tweet[7])/replies_by_date_dict[date_only]['Replies Count']
            replies_by_date_dict[date_only]['Positive Sentiment'] += temp_positive
            replies_by_date_dict[date_only]['Neutral Sentiment'] += temp_neutral
            replies_by_date_dict[date_only]['Negative Sentiment'] += temp_negative
            

    df = pd.DataFrame(data,columns=columns_replies)
    df.to_csv(file_name,index=False)
    
    with open(file_name, mode='a', newline='') as csv_file:
        writer = csv.writer(csv_file)
        writer.writerow([])
        writer.writerow(['','Total Positive Sentiment','Total Neutral Sentiment','Total Negative Sentiment',
                         'Total Likes Count','Total Retweet Count'])
        writer.writerow(['',total_positive_sentiment,total_neutral_sentiment,total_negative_sentiment,total_likes,total_retweet])       
        writer.writerow([])
        writer.writerow(['Tweets in each Date'])
        writer.writerow(['Date','Replies Count','Positive Sentiment','Neutral Sentiment','Negative Sentiment','Average Sentiment Scores'])
        for key,value in replies_by_date_dict.items():
            writer.writerow([key,value['Replies Count'],value['Positive Sentiment'],
                             value['Neutral Sentiment'],value['Negative Sentiment'],value['Average Sentiment Score']])

StoreRepliesToFile(screen_names['Anwar Ibrahim'],REPLIES_COUNT,files['anwar_replies_file'])
StoreRepliesToFile(screen_names['Syed Saddiq'],REPLIES_COUNT,files['ssaddiq_replies_file'])