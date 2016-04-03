import tweepy

consumer_key = "Lw2koKoRtbdHYcS84VSLuH0Tw";


consumer_secret = "x6IAPQWPaYYGBYsyogtCeAfrY6H4wLx12F5h7wd0cMZpZcpYnP";

access_token = "711688427708620804-dUTkRuBvSav7Q5zjoXianboH43lUjQY";

access_token_secret = "weBjOPCLNjP6fU0h6xU03mUKU8SKraWQoB1q15ZWSL0rw";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



