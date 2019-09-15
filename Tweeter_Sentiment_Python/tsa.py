# ---------------- CODE --------------------

import pandas as pd
import numpy as np
import csv
# To model the Bernoulli Navie Bayes classifier
from sklearn.naive_bayes import BernoulliNB
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfTransformer
from sklearn.pipeline import Pipeline

# creating pipeline for classification
text_clf = Pipeline([
                ('vect', CountVectorizer()),
                ('tfidf', TfidfTransformer()),
                ('clf', BernoulliNB()),
])

# Loading the training and testing datasets
training_data = pd.read_csv('train_tweets.csv')
testing_data  = pd.read_csv('test_tweets.csv')

# we will only select the third column for our feature set as we only need "tweets"
features = training_data.values[:, 2]
# second column in the dataset are the labels
labels   = training_data.values[:, 1].astype('int')

# fitting the data onto the classifier

text_clf = text_clf.fit(features, labels)

testing_data = testing_data.values[:, 1]

# predicting the values
predictions = text_clf.predict(testing_data)

hate = 0
non_hate = 0

for i in predictions:
    if i == 0:
        non_hate += 1
    else:
        hate += 1

print('Total Hate Tweets:', hate, ' Total Non-Hate Tweets:', non_hate)

# outputing the hate tweets and no-hate tweets with their labels:
# Note: Hate tweets have label 1 and non-hate tweets have label 0

with open('output.csv', 'w') as csvfile:
    fieldnames = ['label', 'tweet']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    for i in range(len(predictions)):
        writer.writerow({'label': predictions[i], 'tweet': testing_data[i]})

# ---------------- OUTPUT --------------------
