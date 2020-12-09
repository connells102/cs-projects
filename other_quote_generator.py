# Based on Mathais Schlaffer's fake news headline generating project which can be found at:
# https://towardsdatascience.com/using-a-markov-chain-sentence-generator-in-python-to-generate-real-fake-news-e9c904e967e

import pandas as pd
import nltk 
from nltk.tokenize import word_tokenize 
from numpy.random import choice
import numpy as np
import re
import sys

# Open file
file = open("quotes.txt",newline='',encoding="utf8")

# Separate sentences into words
result = file.read()
words = word_tokenize(result)

# Remove punctuation
# (Code used from https://kite.com/python/answers/how-to-remove-all-punctuation-marks-with-nltk-in-python)
words= [word for word in words if word.isalnum()]

# Put the last word of each sentence into a separate array
# By reading the file line-by-line instead
lines = file.readlines()
end_words = []
for line in lines:
    line = line.split()
    end_words.append(line[-1])

# Organize words into lead and follow and find the frequency of each word
dict_df = pd.DataFrame(columns = ['lead', 'follow', 'freq'])
dict_df['lead']=words
follow = words[1:]
follow.append('EndWord')
dict_df.follow = follow

# Assign frequencies
dict_df['freq']= dict_df.groupby(by=['lead','follow'])['lead','follow'].transform('count').copy()

# Remove duplicates
dict_df = dict_df.drop_duplicates()
pivot_df = dict_df.pivot(index = 'lead', columns= 'follow', values='freq')

# Ensure percentages sum to 1 for probabilities
sum_words = pivot_df.sum(axis=1)
pivot_df = pivot_df.apply(lambda x: x/sum_words)

# Function to generate a sentence
def make_a_sentence(start):
    word= start
    sentence=[word]
    while len(sentence) < 30:
        next_word = choice(a = list(pivot_df.columns), p = (pivot_df.iloc[pivot_df.index ==word].fillna(0).values)[0])
        if next_word == 'EndWord':
                continue
        elif next_word in end_words:
            if len(sentence) > 2:    
                sentence.append(next_word)
                break
            else :
                continue
        else :
            sentence.append(next_word)
        word=next_word
    sentence = ' '.join(sentence)
    return sentence

# Generate a sentence beginning with the word "The"
sentence = make_a_sentence('The')
print(sentence)

another = ""

val = input("Do you find this inspirational? ")
while True:
    if val == "yes":
        another = input("Would you like another? ")
        if another == "yes":
            sentence = make_a_sentence('The')
            print(sentence)
            val = input("Do you find this inspirational? ")
        else:
            sys.exit()
    else:
        another = input("Would you like another? ")
        if another == "yes":
            sentence = make_a_sentence('The')
            print(sentence)
            val = input("Do you find this inspirational? ")
        else:
            sys.exit()
